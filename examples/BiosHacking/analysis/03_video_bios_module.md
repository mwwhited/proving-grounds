# Video BIOS Module (`E000:0000-7FFF`)

Third-party component, not OEM code — Chips & Technologies 65535 VGA controller's own option
ROM, licensed/embedded by whoever built this system BIOS image. Documented here for completeness
of the "what's in this chip" picture; not reverse-engineered in depth since it's off the
critical path for the disk/LBA work and is generic (not OEM-specific) video BIOS code.

## Identification

```
Chips 65535/A VGA 32KB BIOS
Version 2.0.0
Copyright (C) 1994 Chips and Technologies, Inc.  All Rights Reserved.
```

Also contains the string `For Evaluation Use Only.` — notable: this suggests the specific VGA
BIOS build embedded in this OEM's flash image may be an unlicensed/evaluation-tier build rather
than a fully-licensed OEM release, which was a common cost-cutting shortcut on budget clone
boards in this era. Doesn't affect functionality either way.

## Structure (confirmed)

- Standard `55 AA`-headed, length-prefixed (`0x40` = 64×512 = 32768 bytes) option ROM.
- **Checksums correctly** as a standalone module (byte sum over all 32768 bytes ≡ 0 mod 256) —
  this is a real, complete, valid PC option ROM, not a fragment.
- Entry point at offset `0x0003` (`EB 3F` = `JMP short +0x3F`), matching the universal PC/AT
  convention for where a video card's BIOS init routine lives. Confirmed live: the core BIOS
  calls it via `CALL FAR E000:0003` at `file 0x162C5` during POST (see
  `01_memory_map_and_boot.md`).

## Not reverse-engineered here

Mode-set tables, font data, INT 10h service dispatch internals. These are generic
Chips-and-Technologies-chipset video BIOS internals, not specific to this OEM board, and don't
bear on the disk/LBA analysis. A copy of the same or a similar-version Chips&Tech VGA BIOS is
likely findable/documented independently in retro-computing archives if that's ever needed.
