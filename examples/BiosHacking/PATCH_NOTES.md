# LBA Patch — Design, Status, and What's Blocked

Goal: let a CF card be addressed past 504 MiB on this laptop's BIOS, permanently, without a
boot-time TSR/floppy — by hooking INT 13h with a translator living inside the existing 128 KB
system BIOS chip (no expansion slots exist to hang a separate option-ROM card off of).

**Current status: paused, blocked on one unverified piece of the vendor's own driver.** The tool
in [`tools/BiosPatcher`](tools/BiosPatcher) builds a working shim for the narrow case (drives
whose true geometry is already ≤1024 cylinders); going further needs verification this session
couldn't complete. Read on for exactly what and why.

## What's built and verified

- **Hook mechanism** (solid): a single 2-byte edit — `file 0x17C79-0x17C7A`, changing the
  INT13h-vector-install instruction's immediate from `7DFEh` to `3FBCh` — redirects `INT 13h` to
  a new shim placed in a confirmed 6,212-byte block of erased ROM at `file 0x13FBC` (`F000:3FBC`).
  Nothing else about the existing code changes.
- **CHS↔LBA translation math** (solid): the "Large/ECHS"-style algorithm in
  `BIOS_ANALYSIS.md`/this file's §"Translation algorithm" was independently verified with a
  reference implementation (Node.js) doing full round-trip checks (`true CHS -> logical CHS ->
  true CHS`) across a dozen drive geometries, including non-power-of-two head counts and the
  DIV-overflow safety bound. This part is correct.
- **The shim itself, for AH=02h/03h/08h only**: assembled via `tools/BiosPatcher` (uses
  [Iced](https://github.com/icedland/iced)'s Assembler to emit real x86-16 machine code, not
  hand-typed bytes), 302 bytes, comfortably inside the free-space budget. Confirmed by
  disassembling the assembled output that the ES-segment overrides, stack-frame arithmetic, and
  jump targets are byte-correct.
- **Two real bugs found and fixed** during this build (both by hand-tracing the vendor's own
  code, not by testing — worth noting since it's exactly the kind of mistake that would have
  silently broken on real hardware): the shim's internal calls to the vendor's `8255h`
  (table-pointer lookup) helper were passing the raw `DL=80h` instead of the 0-based drive index
  `8255h` actually expects (it does `MUL DL` to index a table — `0x80` gives a nonsense offset).

## What's blocked

Tracing the vendor's `831Bh` (the routine that builds the actual ATA command bytes) revealed it
**truncates the cylinder number to 10 bits while building the hardware command**, not just in the
INT13h calling convention:

```
shr cl, 6          ; keeps only 2 bits of the caller's cylinder-high field
xchg ch, cl         ; ch = those 2 bits, cl = cylinder-low-8
... or ch, dh>>5 ... ; looks like 3 more bits, but DH is restored right after and reused
                      ; for the head field - for any real caller (head<32) this is a no-op
```

This means: **translating a drive's CHS and handing off to the unmodified original driver only
works correctly if the drive's true geometry is already ≤1024 cylinders.** For anything bigger
(which is the actual point of the exercise — a modern CF card), cylinders above 1023 get silently
wrapped/truncated, which is wrong-sector addressing, not a crash. See
`analysis/02_int13h_disk_driver.md` §4 for the full bit-level trace.

The fix is understood and bounded: call `831Bh` for its correct side-effects (sector number,
head/drive byte, features/control byte, error signaling) exactly as before, but immediately
overwrite the two cylinder bytes it computed (`file offsets [445h]/[446h]` in the BDA task-file
mirror) with the correctly-computed 16-bit true cylinder before the command is sent. **What's
*not* bounded** is the next step: reusing the rest of the transfer sequence
(`8383h`→`8298h`→`842Ah`/`8404h`) means re-entering `842Ah`'s DRQ-wait/retry logic, and one branch
in there is genuinely ambiguous from static reading alone — see
`analysis/02_int13h_disk_driver.md` §5 for the exact instructions and why. Getting it wrong there
means silently reading or writing the wrong data, with no crash to signal it.

### Emulator verification attempt (blocked, different reason)

Installed Bochs 3.1 (via `winget`, silent NSIS install to a scratch dir since the winget
installer needed interactive elevation) intending to single-step through a real disk read and
settle the ambiguity directly. Bochs boots the split ROM image fine up through CPU reset, but
this specific BIOS's early POST code crashes it with repeated `EIP [00010000] > CS.limit
[0000FFFF]` — consistent with a "big real mode" trick (briefly touching protected mode to widen a
segment limit past 64 KB for a fast memory test, then dropping back to real mode without
reloading the limit) that many 486-era BIOSes use and that Bochs's CPU core doesn't tolerate the
same way real silicon does. This fault happens long before POST would reach the disk code, so the
emulator route is blocked on a *different*, unrelated compatibility issue. Scratch config for
whoever picks this back up:

```
tools not committed to the repo (scratchpad only) - reproduce with:
  romimage: file="bios_high64k.bin"          (file offset 0x10000-0x1FFFF of the ROM)
  optromimage1: file="bios_low64k.bin", address=0xe0000   (file offset 0x00000-0xFFFF)
  ata0-master: type=disk, path="disk.img", mode=flat, cylinders=615, heads=4, spt=17
  cpu: model=i486dx4
```
86Box (also available via `winget install 86Box.86Box`) was not tried and might tolerate this
BIOS's early POST better — it prioritizes cycle-accurate hardware quirks over Bochs's more
idealized CPU core.

## Translation algorithm (verified, for the parts that use it)

Only drive `0x80` is translated; everything else passes through untouched.

```
true_cyl, true_heads, true_spt   <- read from fixed disk parameter table (offsets 0x00,0x02,0x0E)

find smallest F in {1,2,4,8,16} (capped at F<=16, i.e. k<=4, to keep the DIV below provably safe)
such that:
    true_heads * F  <= 240

logical_cyl   = min(true_cyl / F, 1024)
logical_heads = true_heads * F
logical_spt   = true_spt

# AH=08 (get params): report logical_cyl-1 / logical_heads-1 / logical_spt to the caller

# AH=02/03 (read/write): caller gives logical CHS, translate to true CHS
LBA        = (logical_cyl_in * logical_heads + logical_head_in) * true_spt + (logical_sector_in - 1)
true_cyl   = LBA / (true_heads * true_spt)          ; provably < true_cyl, fits 16-bit DIV
true_head  = (LBA / true_spt) mod true_heads
true_sect  = (LBA mod true_spt) + 1
```

## EDD design (not implemented)

You asked for INT13h Extensions (AH=41h/42h/48h) for broader OS/loader compatibility beyond
plain DOS-style AH=02h/03h/08h. Design sketch, not built (blocked behind the same 831Bh issue,
plus its own added complexity):

- **AH=41h** (Installation Check): if `BX=55AAh`, return `BX=AA55h`, `CX=1` (extended
  read/write/get-params supported), `AH=30h` (version 3.0), `CF=0`. Otherwise pass through
  (matches pre-patch "invalid function" behavior for anyone probing without the signature).
- **AH=48h** (Extended Get Drive Parameters): report the drive's **true**, untranslated geometry
  plus a computed `total_sectors = true_cyl * true_heads * true_spt` in the standard 26-byte
  v1.0 result buffer. No 1024-cylinder ceiling applies here at all — EDD's entire purpose is
  bypassing that — so this part doesn't even hit the 831Bh problem.
- **AH=42h/43h** (Extended Read/Write): parse the caller's Disk Address Packet (16-byte v1.0:
  size, reserved, sector count, buffer offset:segment, 32-bit starting LBA — 64-bit LBA
  deliberately unsupported, this drive will never need more than 32 bits), then loop: for each
  chunk (bounded by both the remaining count and the current track's remaining sectors), compute
  true CHS from the current LBA, build a legacy-style call (`AH=02h/03h`, computed CHS,
  `DL=80h`), and invoke the original handler via `PUSHF` + `CALL FAR F000:7DFEh` — manually
  replicating what a real `INT 13h` would push, so the original's internal `POPF`/`RETF 2`
  epilogue unwinds correctly back into *this* loop instead of the real caller. Advance the LBA
  and the buffer pointer (handling 64KB segment-boundary carry) between chunks.
- This AH=42h/43h path hits the **exact same `831Bh`/`842Ah` questions** as the classic path,
  since it still wants to reuse the existing PIO transfer code for each chunk — so it's blocked
  on the same open question, not a new one.

## Next steps (pick one when you're ready)

1. **Resolve the `842Ah` ambiguity properly** — get Bochs past early POST (try disabling
   whatever CPU feature is causing the segment-limit fault, or try 86Box instead), single-step a
   real disk read, and confirm exactly what `842Ah`'s DRQ-ready branch does. Then implement the
   `831Bh`-bypass (build task-file bytes directly, skip only the truncating cylinder step) with
   confidence.
2. **Ship the narrow version now**: burn the current 302-byte shim (AH=02h/03h/08h only,
   `tools/BiosPatcher --patch`), which is fully verified for drives whose true geometry is
   ≤1024 cylinders. Whether that clears 504 MiB depends on what CHS your specific CF card reports
   by default — worth checking before deciding this is a dead end.
3. **Real hardware, cautiously**: since you have a programmer and can always reflash from the
   original backup, you could burn the >1024-cylinder bypass version with my best-effort (but
   unverified) reading of `842Ah`, test read-only operations first on a disposable/scratch card,
   and treat any corruption as confirmation the ambiguous branch needs the other interpretation.
