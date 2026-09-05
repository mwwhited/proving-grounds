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

An LBA-translation patch was designed and partially built (CHS↔LBA math verified against an
independent reference implementation across many drive geometries) but is **currently blocked**:
tracing `831Bh` byte-for-byte revealed it truncates cylinder numbers to 10 bits *in how it talks
to the drive*, not just in the calling convention — so a translate-and-reuse-the-existing-driver
approach only works for drives whose true geometry is already ≤1024 cylinders. Going further
requires bypassing `831Bh` and re-entering a stretch of retry/DRQ-wait logic (`842Ah`/`8458h`)
whose exact success/failure semantics couldn't be pinned down from static analysis alone — see
`analysis/02_int13h_disk_driver.md` §5. An attempt to verify it in Bochs hit an unrelated
emulator/BIOS compatibility fault during early POST. Full detail and options going forward are in
[`PATCH_NOTES.md`](PATCH_NOTES.md).
