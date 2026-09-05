# Compuadd 486 "Color Scan 450" BIOS — Reverse-Engineering Notes

Source image: `BIOS from Compuadd 486 Color Scan 450.BIN` (131,072 bytes / 128 KB), a laptop
system BIOS with no expansion slots — any fix has to live inside this one chip.

This is the index. Full detail lives in [`analysis/`](analysis/); full mechanical disassembly
listings are in [`disassembly/`](disassembly/), including an annotated/labeled version of the
disk driver. Raw analysis was done with the throwaway 16-bit disassembler in
[`tools/BiosDisasm`](tools/BiosDisasm) (built on [Iced](https://github.com/icedland/iced)).

All addresses are given as `segment:offset` and, where relevant, as a file byte offset
(`file 0x…`). `file offset = 0x10000 + segment-offset` for the core BIOS (`F000:xxxx`).

## Documents

| Doc | Covers |
|---|---|
| [`analysis/01_memory_map_and_boot.md`](analysis/01_memory_map_and_boot.md) | Confirmed E000/E800/F000 segment map (with hard evidence, not inference), PhoenixMISER module map, full boot flow |
| [`analysis/02_int13h_disk_driver.md`](analysis/02_int13h_disk_driver.md) | Complete INT13h dispatch table, fixed-disk parameter table layout, every disk subroutine traced, and the one piece of retry logic that's genuinely ambiguous from static analysis |
| [`analysis/03_video_bios_module.md`](analysis/03_video_bios_module.md) | Chips & Technologies VGA option ROM identification |
| [`analysis/04_setup_ui.md`](analysis/04_setup_ui.md) | Reconstructed Setup screens (Salt mockups) and hard-disk type table |
| [`disassembly/int13h_handler_annotated.asm`](disassembly/int13h_handler_annotated.asm) | Hand-labeled disassembly of the disk driver (vs. the raw mechanical dump in `disassembly/03_core_bios_F000.asm`) |
| [`PATCH_NOTES.md`](PATCH_NOTES.md) | LBA patch attempt: design, what's built, what's blocked, and why |

## Identification

| Module | File range | Segment | Size | Identity |
|---|---|---|---|---|
| Video BIOS | `0x00000–0x07FFF` | `E000:0000` | 32 KB | Chips & Technologies 65535 VGA BIOS v2.0.0, © 1994 |
| "PhoenixMISER" | `0x08000–0x0FFFF` | `E800:0000` | 32 KB | OEM chipset/power-management service module |
| Core system BIOS | `0x10000–0x1FFFF` | `F000:0000` | 64 KB | **Phoenix "A486" core v1.03**, OEM tag `PhoenixMISER(TM) PT68C268`, © 1985-1993 Phoenix Technologies |

The whole 128 KB is one chip decoded at physical `E0000–FFFFF` — see
`analysis/01_memory_map_and_boot.md` for the hard evidence (real far-call sites proving each
segment mapping, not just "this is the conventional layout").

## LBA support: confirmed absent

- The INT13h dispatch table has no AH=41h/42h/43h/44h/47h/48h (INT13h Extensions/EDD) entries —
  anything ≥0x16 falls straight into the generic "invalid function" path.
- `AH=08` (Get Drive Parameters) packs the returned cylinder count into a **hard 10-bit** field
  (`CH` + 2 bits of `CL`) with no bit-shift/translation logic anywhere.
- The low-level task-file builder (`831Bh`) masks the ATA head field to the classic **4-bit
  (16-head)** ceiling.
- The Setup UI has no "LBA/Large/Auto" translation-mode option anywhere — every drive type,
  including the user-defined slot, is a raw CHS entry.

`1024 × 16 × 63 × 512 bytes ≈ 504 MiB` — the classic pre-LBA barrier, matching the symptom of
needing a boot-time LBA loader.

## Status

**Patched and ready for cautious hardware testing.** The first design translated CHS and handed
off to the vendor's own `831Bh`, which turned out to truncate cylinder numbers to 10 bits while
building the ATA command — a hard wall regardless of translation. The shipped design instead
bypasses `831Bh` entirely: it converts the caller's CHS straight to a 28-bit LBA value and talks
to the drive in native ATA LBA mode (every IDE drive since ATA-1 supports this), reusing the
vendor's own send/wait/transfer subroutines in exactly the pattern they already use for a normal
single-sector transfer. This sidesteps the cylinder ceiling entirely and resolved the earlier
DRQ-wait ambiguity without needing an emulator — see [`PATCH_NOTES.md`](PATCH_NOTES.md) for the
full redesign story, what's verified, and how to test.
