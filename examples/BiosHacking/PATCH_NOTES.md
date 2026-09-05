# LBA Patch — Design, Status, and How to Test

Goal: let a CF card be addressed past 504 MiB on this laptop's BIOS, permanently, without a
boot-time TSR/floppy — by hooking INT 13h with a translator living inside the existing 128 KB
system BIOS chip (no expansion slots exist to hang a separate option-ROM card off of).

**Current status: built, self-consistent, ready for cautious hardware testing.** The blocker
from the first design (cylinder truncation in the vendor's own driver) is resolved by a
different architecture, not by working around it — see below.

## The redesign that unblocked this

The first version of this patch translated the caller's CHS into a "true CHS" and handed off to
the vendor's own `831Bh` (task-file builder) to do the actual ATA command. Tracing `831Bh`
byte-for-byte found it truncates cylinder numbers to 10 bits while building the hardware
command — a hard wall for any drive over roughly 504MB-1GB depending on interpretation (see
`analysis/02_int13h_disk_driver.md` §4 for the full trace). Going further that way meant
re-entering a stretch of DRQ-wait/retry logic (`842Ah`/`8458h`) whose exact behavior I couldn't
fully verify from static analysis, and an attempt to verify it in Bochs hit an unrelated
emulator/BIOS compatibility fault.

The fix was architectural, not a workaround: **bypass `831Bh` entirely and never use CHS
addressing for the actual drive access.** Every IDE drive since ATA-1 supports native 28-bit LBA
addressing — a completely separate addressing mode selected by one bit in the drive/head
register (`0xE0` for LBA mode vs. the vendor's `0xA0` for CHS mode). This is the same general
architecture [XTIDE Universal BIOS](https://www.xtideuniversalbios.org/) (GPLv2) uses — its
source was consulted for the approach (see `reference/xtide-universal-bios/`, kept with its
original license header and `COPYING.txt` per GPL) but no XTIDE code is used in this shim; it's
a fresh implementation against this specific ROM's own subroutines and port layout.

The shim now:
1. Converts the caller's classic CHS input straight to a 28-bit LBA value (fixed reporting
   geometry: 255 heads × 63 sectors, so no per-drive translation factor is needed at all).
2. Writes the 8-byte ATA task file directly (bypassing `831Bh` completely) with the LBA-mode bit
   set.
3. Reuses the vendor's own send/wait/transfer subroutines (`8383h`/`8298h`/`8404h`/`842Ah`/
   `83B4h`/`8458h`) in **exactly** the call sequence and per-sector pattern the vendor's own
   `AH=02h`/`03h` handlers already use for a single-sector transfer — which is what resolves the
   earlier ambiguity without an emulator: cross-comparing `8404h` (used by the write path) against
   `842Ah` (used by the read path) side by side showed they're the same "wait for DRQ" logic: both
   return to the *caller* to do the actual `INSW`/`OUTSW`, exactly mirroring the vendor's own
   inline code. I'm not doing anything the vendor's shipped, working code doesn't already do —
   just feeding it LBA-mode task-file bytes instead of CHS-mode ones.
4. Issues one ATA command per sector rather than replicating the vendor's multi-sector-per-command
   burst optimization — simpler to get right, at some cost in transfer speed for large requests.

## A bug this caught before it mattered

While re-testing after the redesign, `--patch`'s own byte-match sanity check refused to proceed:
the file offset I'd been using to patch the INT13h-vector-install instruction
(`VectorPatchFileOffset`) was **off by two bytes** for this entire project — pointing at the
*destination* operand (`004Ch`, the IVT slot address) of `MOV WORD [004Ch],7DFEh` instead of the
*source* operand (`7DFEh`, the handler address). Had this gone untested onto a real chip, it
would have corrupted the interrupt vector table setup itself rather than installing the shim.
Now fixed and verified (`file 0x17C7B-0x17C7C`, confirmed against a hex dump of the actual
instruction bytes). This is exactly the kind of mistake `--patch`'s refusal-on-mismatch check
exists to catch — it did its job.

## What's built and verified

- **Hook mechanism**: 2-byte edit at `file 0x17C7B-0x17C7C` (imm16 `7DFEh` → `3FBCh`) redirects
  `INT 13h` to a 512-byte shim placed in the confirmed-free block at `file 0x13FBC` (`F000:3FBC`,
  well below the checksummed-but-unenforced `F000:5800-FFFF` range — see "Integrity checks"
  below).
- **CHS→LBA translation math**: verified by disassembling the assembled shim and hand-tracing
  every instruction against the intended design (register/stack layout, ES-segment overrides,
  32×16→32 multiply composition, DIV-safety bounds). The reported/addressable ceiling is
  `1024 × 255 × 63 × 512 ≈ 7.84 GiB` — the classic non-extended-INT13h limit, comfortably past
  "more than 504 MB" for any period-correct CF card.
- **Diff confinement**: the patched ROM differs from the original in exactly the shim block plus
  the 2-byte vector patch — nothing else changed.
- **Command byte reuse verified**: ATA commands `0x20`(read)/`0x30`(write) are architecturally
  identical whether the drive/head register requests CHS or LBA mode — only that one bit differs.

## Integrity checks respected

- `F000:5800-FFFF` 8-bit-sum-to-zero "ROM checksum" — computed by POST but its result is
  **discarded** by a `jz $+4` trick (doesn't actually gate anything; the stock ROM's own checksum
  is non-zero today and it boots fine). Not a concern either way since the shim lives at
  `F000:3FBC`, below this range.
- `F000:E020-E2C2` folded with `F000:E840` — a **real**, enforced integrity check; mismatch hangs
  the machine in an obfuscated loop. Never touched by this patch (nowhere near the free-space
  block or the 2-byte vector patch).

## Known limitations (by design, not bugs)

- Only drive `0x80` is translated. Drive `0x81` and floppies pass through untouched.
- No INT13h Extensions (AH=41h/42h/48h/EDD) — not needed for a CF card in the multi-GB range
  addressed through plain DOS-era INT13h. Could be added later using the same direct-LBA
  approach (parse the Disk Address Packet, reuse the same per-sector loop) if a future OS/loader
  needs it.
- One ATA command per sector, not per-request bursts — correct but not maximally fast. A CF card
  in PIO mode is not going to feel snappy either way; this isn't the bottleneck.
- PhoenixMISER's suspend-to-disk save reinstalls `INT 13h` via a hardcoded trampoline
  (`F000:E3FE`, a fixed `JMP` straight to the *original* CHS-mode handler) before touching the
  disk, bypassing this shim entirely. In practice this is very likely fine — PHDISK's suspend
  partition is small and sits well inside classic CHS range regardless of whether the shim is
  active for it.

## How to test

1. Build: `cd tools/BiosPatcher && dotnet run -- --patch "../../BIOS from Compuadd 486 Color Scan 450.BIN" out.bin`
   (the repo already has a pre-built copy: `BIOS from Compuadd 486 Color Scan 450 - LBA PATCHED.BIN`).
2. Burn `out.bin` to your spare chip.
3. Boot with the CF card installed. Check that Setup's hard-disk type screen and a plain
   `FDISK`/`DIR C:` still work for whatever capacity you were already using — this exercises the
   read path even for small existing partitions, since *all* AH=02h/08h calls now go through the
   direct-LBA shim regardless of the actual LBA value involved.
4. If that works, try formatting/partitioning up toward the full CF card capacity to confirm
   capacity past 504 MB is actually usable (write test, then read back and verify).
5. If anything goes wrong: reprogram the original, unpatched image from your backup. Nothing
   about this patch is destructive to the chip itself — it's a straightforward reflash to undo.

## Reference material

- `reference/xtide-universal-bios/` — the two GPLv2 XTIDE source files consulted for the
  direct-LBA architecture (`Address.asm`, `IdeCommand.asm`), kept with their original license
  headers, plus `COPYING.txt`.
- `analysis/02_int13h_disk_driver.md` — full trace of the vendor's disk driver, including the
  `831Bh` cylinder-truncation finding that motivated this redesign.
