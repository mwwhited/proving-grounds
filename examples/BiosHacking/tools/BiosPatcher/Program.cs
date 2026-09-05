using System;
using System.IO;
using System.Linq;
using System.Collections.Generic;
using Iced.Intel;
using static Iced.Intel.AssemblerRegisters;

// Builds the LBA-translation INT13h shim, assembles it, and either:
//   --dump                     : prints the assembled shim bytes.
//   --patch <in.bin> <out.bin> : injects the shim into a copy of the ROM and rewrites
//                                 the INT13h vector-install instruction to point at it.
//
// DESIGN (v2 - direct LBA, see PATCH_NOTES.md "Direct-LBA redesign"):
// Earlier versions of this shim translated the caller's CHS into a "true CHS" and handed off
// to the vendor's own 831Bh (task-file builder), which turned out to truncate cylinder numbers
// to 10 bits - a hard wall for any drive over roughly 504MB-1GB depending on interpretation.
//
// This version bypasses 831Bh entirely for read/write: it converts the caller's logical CHS
// straight to a 28-bit LBA and writes the ATA task-file bytes itself with the LBA-mode bit set
// (drive/head register = 0xE0, vs. the vendor's 0xA0 for CHS mode) - the same general approach
// XTIDE Universal BIOS uses (see reference/xtide-universal-bios/, GPLv2, consulted for the
// architecture - IdeCommand.asm's OutputSectorCountAndAddress, Address.asm's LBA-assist
// conversion; no XTIDE code is copied here, this is a fresh implementation against the vendor
// ROM's own port layout and subroutines). Once the task-file bytes are in place, it reuses the
// vendor's own send/wait/transfer subroutines (8383h/8298h/8404h/842Ah/83B4h/8458h) in exactly
// the call sequence and per-sector pattern the vendor's own AH=02h/03h handlers already use.
// Cross-comparing 8404h and 842Ah's near-identical structure resolved the one ambiguous branch
// flagged in analysis/02_int13h_disk_driver.md SS5: both are "wait for DRQ" functions - the
// *caller* always does its own INSW/OUTSW afterward, exactly like the vendor's inline code does.
//
// Only drive 80h is translated; drive 81h and floppies pass through untouched. Reported logical
// geometry is fixed at heads=255, spt=63 (LBA addressing doesn't care about real heads/sectors
// any more), cylinders sized to the drive's real capacity (from the fixed-disk parameter table)
// up to the classic 1024 cap - i.e. up to ~7.8 GiB reportable/addressable through plain
// (non-extended) INT13h, comfortably past "more than 504 MB" for any period-correct CF card.
//
// This shim issues exactly one ATA command per sector (no multi-sector-per-command bursts) -
// simpler and safer to get right than replicating the vendor's burst-mode loop, at some cost in
// transfer speed for large multi-sector requests.
//
// Shim placement is fixed by the free-space survey done during analysis:
//   file offset 0x13FBC == F000:3FBC (6,212 bytes of erased 0xFF here, well below the
//   checksummed-but-unenforced F000:5800-FFFF range - see PATCH_NOTES.md).
// Original INT13h handler entry (untouched) is F000:7DFE == file 0x17DFE.
// Helper "get fixed-disk parameter table ptr for DL" is F000:8255 == file 0x18255.
// Vector-install instruction to patch: file 0x17C79-0x17C7A, imm16 7DFEh -> 3FBCh.

const int ShimOrigin = 0x3FBC;
const int OrigHandlerOffset = 0x7DFE;
const int GetTableHelperOffset = 0x8255;
const int SendAtaTaskFileOffset = 0x8383;     // vendor: send control byte + task file + command
const int WaitControllerReadyOffset = 0x8298; // vendor: wait not-busy/ready (read path)
const int DrqWaitReadOffset = 0x842A;         // vendor: wait DRQ (read path)
const int DrqWaitWriteOffset = 0x8404;        // vendor: wait DRQ (write path)
const int AtaErrorPeekOffset = 0x8458;        // vendor: non-blocking error-register peek
const int PostTransferCheckOffset = 0x83B4;   // vendor: post-transfer status/retry check
const int VectorPatchFileOffset = 0x17C7B;    // low byte of the imm16 SOURCE operand (7DFEh) in
                                               // `C7 06 4C 00 FE 7D` = MOV WORD [004Ch],7DFEh.
                                               // 0x17C79-0x17C7A is the DESTINATION (004Ch, the
                                               // IVT slot) - do not confuse the two; this was a
                                               // real bug here until caught by --patch's own
                                               // byte-match sanity check refusing to proceed.
const int ShimFileOffset = 0x13FBC;
const int LogicalHeads = 255;
const int LogicalSpt = 63;

byte[] BuildShim()
{
    var c = new Assembler(16);

    var lEntry = c.CreateLabel("Entry");
    var lPass = c.CreateLabel("PassThrough");
    var lGetParams = c.CreateLabel("HandlerGetParams");
    var lGPCylOk = c.CreateLabel("GPCylOk");
    var lGetTrueGeom = c.CreateLabel("GetTrueGeom");
    var lBuildTaskFile = c.CreateLabel("BuildLbaTaskFile");
    var lRwShared = c.CreateLabel("RwShared");
    var lCmdSet = c.CreateLabel("CmdSet");
    var lReadLoopTop = c.CreateLabel("ReadLoopTop");
    var lReadError = c.CreateLabel("ReadError");
    var lWriteLoopTop = c.CreateLabel("WriteLoopTop");
    var lWriteError = c.CreateLabel("WriteError");
    var lReadNoSegBump = c.CreateLabel("ReadNoSegBump");
    var lWriteNoSegBump = c.CreateLabel("WriteNoSegBump");
    var lRwSuccess = c.CreateLabel("RwSuccess");
    var lRwExit = c.CreateLabel("RwExit");
    var lRwSetCF = c.CreateLabel("RwSetCF");
    var lRwRestore = c.CreateLabel("RwRestore");

    // ================= Entry =================
    c.Label(ref lEntry);
    c.cmp(dl, 0x80);
    c.jne(lPass);
    c.cmp(ah, 0x08);
    c.je(lGetParams);
    c.cmp(ah, 0x02);
    c.je(lRwShared);
    c.cmp(ah, 0x03);
    c.je(lRwShared);

    c.Label(ref lPass);
    c.db(0xEA, (byte)(OrigHandlerOffset & 0xFF), (byte)((OrigHandlerOffset >> 8) & 0xFF), 0x00, 0xF0);

    // ================= GetTrueGeom =================
    // Out: ax=true_cyl, bx=true_heads, cx=true_spt. Only used by AH=08h now, to size the
    // reported capacity - read/write no longer needs "true" geometry at all.
    c.Label(ref lGetTrueGeom);
    c.push(dx);
    c.xor(dl, dl); // 8255h wants a 0-based drive index; we only ever handle drive 80h -> index 0
    c.call(GetTableHelperOffset);
    c.pop(dx);
    c.db(0x26); c.mov(ax, __word_ptr[si]);
    c.xor(bx, bx);
    c.db(0x26); c.mov(bl, __byte_ptr[si + 2]);
    c.xor(cx, cx);
    c.db(0x26); c.mov(cl, __byte_ptr[si + 0x0E]);
    c.ret();

    // ================= Handler_GetParams (AH=08h) =================
    // Reports a fixed 255-head/63-sector logical geometry, cylinder count sized to the
    // drive's real capacity (capped at 1024).
    c.Label(ref lGetParams);
    c.push(bp);
    c.mov(bp, sp);
    c.push(bx);
    c.push(cx);
    c.push(dx);
    c.push(si);
    c.push(es);
    c.push(ds);

    c.call(lGetTrueGeom);              // ax=true_cyl, bx=true_heads, cx=true_spt
    c.mul(bx);                         // dx:ax = true_cyl * true_heads
    c.push(ax);
    c.mov(ax, dx);
    c.mov(bx, cx);                     // bx = true_spt
    c.mul(bx);                         // dx:ax = (true_cyl*true_heads hi word) * true_spt
    c.mov(cx, ax);                     // cx = high-word contribution
    c.pop(ax);
    c.mul(bx);                         // dx:ax = (true_cyl*true_heads lo word) * true_spt
    c.add(dx, cx);                     // dx:ax = total_sectors (32-bit)

    c.mov(cx, LogicalHeads * LogicalSpt); // constant divisor = 255*63 = 16065
    c.div(cx);                         // ax = logical_cyl (floor); safe since true_cyl is a
                                        // 16-bit field, so total_sectors/16065 always fits AX
    c.cmp(ax, 1024);
    c.jbe(lGPCylOk);
    c.mov(ax, 1024);
    c.Label(ref lGPCylOk);
    c.dec(ax);                         // ax = logical_cyl - 1
    c.mov(ch, al);
    c.mov(cl, ah);
    c.and(cl, 0x03);
    c.shl(cl, 6);
    c.or(cl, LogicalSpt);
    c.mov(dh, LogicalHeads - 1);
    c.xor(ah, ah);
    c.and(__word_ptr[bp + 6], 0xFFFE); // clear CF in the on-stack FLAGS word for IRET
    c.pop(ds);
    c.pop(es);
    c.pop(si);
    c.mov(sp, bp);
    c.pop(bp);
    c.iret();

    // ================= BuildLbaTaskFile =================
    // In: [bp-12]=ata command byte, [bp-20]/[bp-22]=current LBA (lo/hi word).
    // Writes the 8-byte task-file mirror at 40:441-448 directly in LBA mode (drive/head = E0h),
    // bypassing the vendor's 831Bh (which cannot represent cylinders beyond 10 bits - see
    // analysis/02_int13h_disk_driver.md). DS must already be 0. Sector count is always 1: this
    // shim issues one ATA command per sector rather than replicating the vendor's multi-sector
    // burst path.
    c.Label(ref lBuildTaskFile);
    c.mov(bx, 0x441);
    c.mov(__byte_ptr[bx + 1], 0);               // features - unused for read/write sector cmds
    c.mov(__byte_ptr[bx + 2], 1);               // sector count = 1
    c.mov(ax, __word_ptr[bp - 20]);             // LBA low word
    c.mov(__byte_ptr[bx + 3], al);              // LBA[7:0]   -> sector number register (1F3h)
    c.mov(__byte_ptr[bx + 4], ah);              // LBA[15:8]  -> cylinder low (1F4h)
    c.mov(ax, __word_ptr[bp - 22]);             // LBA high word
    c.mov(__byte_ptr[bx + 5], al);              // LBA[23:16] -> cylinder high (1F5h)
    c.mov(__byte_ptr[bx + 6], 0xE0);            // drive/head: LBA mode, master, LBA[27:24]=0
                                                  // (our capacity ceiling keeps LBA <16M, so the
                                                  // top nibble is always 0 - see PATCH_NOTES.md)
    c.mov(al, __byte_ptr[bp - 12]);
    c.mov(__byte_ptr[bx + 7], al);              // command (0x20/0x30)
    c.mov(__byte_ptr[0x476], 0);                // control byte -> port 3F6h via SendAtaTaskFile
    c.ret();

    // ================= HandlerRead / HandlerWrite (shared prologue) =================
    // Frame (push bp; mov bp,sp; sub sp,22; push si,di,es,ds):
    //   [bp-2]  orig ax (ah=cmd 2/3, al=sector count)
    //   [bp-6]  orig cx (logical cyl/sector, packed)
    //   [bp-12] ata command byte (0x20/0x30)
    //   [bp-14] sectors_remaining
    //   [bp-16] cur_buf_off   [bp-18] cur_buf_seg
    //   [bp-20] cur_lba_lo    [bp-22] cur_lba_hi
    c.Label(ref lRwShared);
    c.push(bp);
    c.mov(bp, sp);
    c.sub(sp, 22);
    c.push(si);
    c.push(di);
    c.push(es);
    c.push(ds);

    c.mov(__word_ptr[bp - 2], ax);              // orig ax, AH still intact here (2 or 3)
    c.mov(__word_ptr[bp - 6], cx);              // orig cx

    c.mov(al, ah);
    c.cmp(al, 2);
    c.mov(__byte_ptr[bp - 12], 0x20);
    c.je(lCmdSet);
    c.mov(__byte_ptr[bp - 12], 0x30);
    c.Label(ref lCmdSet);

    c.mov(ax, __word_ptr[bp - 2]);
    c.xor(ah, ah);                              // ax = sector count (from orig al), zero-extended
    c.mov(__word_ptr[bp - 14], ax);

    c.mov(__word_ptr[bp - 16], bx);             // cur_buf_off = orig bx
    c.mov(ax, es);
    c.mov(__word_ptr[bp - 18], ax);             // cur_buf_seg = orig es

    // unpack logical CHS (heads=255, spt=63 fixed) into a 32-bit LBA
    c.mov(ax, __word_ptr[bp - 6]);              // ax = orig cx (CH:CL)
    c.mov(bl, al);                              // bl = CL byte
    c.mov(al, ah);                              // al = CH (cyl low8)
    c.mov(ah, bl);
    c.and(ah, 0xC0);
    c.shr(ah, 6);                               // ax = logical_cyl_in (0..1023)
    c.mov(di, ax);
    c.mov(al, bl);
    c.and(al, 0x3F);
    c.xor(ah, ah);
    c.mov(si, ax);                              // si = sector_in (1..63)
    c.mov(al, dh);
    c.xor(ah, ah);                              // ax = logical_head_in (0..254)

    c.push(ax);
    c.mov(ax, di);
    c.mov(cx, LogicalHeads);
    c.mul(cx);                                  // dx:ax = logical_cyl_in * 255
    c.pop(cx);
    c.add(ax, cx);
    c.adc(dx, 0);                               // dx:ax = track

    c.push(ax);
    c.mov(ax, dx);
    c.mov(cx, LogicalSpt);
    c.mul(cx);
    c.mov(bx, ax);
    c.pop(ax);
    c.mul(cx);                                  // dx:ax = track * 63
    c.add(dx, bx);

    c.mov(cx, si);
    c.dec(cx);
    c.add(ax, cx);
    c.adc(dx, 0);                               // dx:ax = LBA (32-bit)

    c.mov(__word_ptr[bp - 20], ax);
    c.mov(__word_ptr[bp - 22], dx);

    c.mov(al, __byte_ptr[bp - 12]);
    c.cmp(al, 0x20);
    c.je(lReadLoopTop);
    c.jmp(lWriteLoopTop);

    // ---------------- Read loop (one ATA READ SECTOR command per iteration) ----------------
    c.Label(ref lReadLoopTop);
    c.cmp(__word_ptr[bp - 14], 0);
    c.je(lRwSuccess);

    c.xor(ax, ax);
    c.mov(ds, ax);
    c.call(lBuildTaskFile);
    c.call(SendAtaTaskFileOffset);
    c.jc(lReadError);
    c.call(WaitControllerReadyOffset);
    c.jc(lReadError);

    c.mov(ax, __word_ptr[bp - 18]);
    c.mov(es, ax);
    c.mov(di, __word_ptr[bp - 16]);

    c.call(DrqWaitReadOffset);
    c.jc(lReadError);

    // Vendor's own AH=02h handler always does this transfer itself right after calling 842Ah,
    // regardless of what 842Ah did internally - mirrored exactly (see file header note).
    c.mov(dx, 0x1F7);
    c.@in(al, dx);
    c.cli();
    c.mov(dx, 0x1F0);
    c.mov(cx, 0x100);
    c.rep.insw();
    c.sti();

    c.call(PostTransferCheckOffset);
    c.jc(lReadError);

    c.mov(ax, __word_ptr[bp - 20]);
    c.add(ax, 1);
    c.mov(__word_ptr[bp - 20], ax);
    c.adc(__word_ptr[bp - 22], 0);

    c.mov(ax, __word_ptr[bp - 16]);
    c.add(ax, 512);
    c.mov(__word_ptr[bp - 16], ax);
    c.jnc(lReadNoSegBump);
    c.mov(ax, __word_ptr[bp - 18]);
    c.add(ax, 0x1000);
    c.mov(__word_ptr[bp - 18], ax);
    c.Label(ref lReadNoSegBump);

    c.dec(__word_ptr[bp - 14]);
    c.jmp(lReadLoopTop);

    c.Label(ref lReadError);
    c.jmp(lRwExit);

    // ---------------- Write loop (one ATA WRITE SECTOR command per iteration) ----------------
    c.Label(ref lWriteLoopTop);
    c.cmp(__word_ptr[bp - 14], 0);
    c.je(lRwSuccess);

    c.xor(ax, ax);
    c.mov(ds, ax);
    c.call(lBuildTaskFile);
    c.call(SendAtaTaskFileOffset);
    c.jc(lWriteError);

    // Write path waits DRQ via 8404h directly (no 8298h first) - matches the vendor's own
    // AH=03h handler sequence exactly.
    c.call(DrqWaitWriteOffset);
    c.jc(lWriteError);

    c.push(ds);
    c.mov(ax, __word_ptr[bp - 18]);
    c.mov(ds, ax);
    c.mov(si, __word_ptr[bp - 16]);
    c.mov(dx, 0x1F0);
    c.mov(cx, 0x100);
    c.cli();
    c.rep.outsw();
    c.pop(ds);
    c.sti();

    c.call(WaitControllerReadyOffset);
    c.jc(lWriteError);
    c.call(AtaErrorPeekOffset);
    c.jc(lWriteError);
    c.call(PostTransferCheckOffset);
    c.jc(lWriteError);

    c.mov(ax, __word_ptr[bp - 20]);
    c.add(ax, 1);
    c.mov(__word_ptr[bp - 20], ax);
    c.adc(__word_ptr[bp - 22], 0);

    c.mov(ax, __word_ptr[bp - 16]);
    c.add(ax, 512);
    c.mov(__word_ptr[bp - 16], ax);
    c.jnc(lWriteNoSegBump);
    c.mov(ax, __word_ptr[bp - 18]);
    c.add(ax, 0x1000);
    c.mov(__word_ptr[bp - 18], ax);
    c.Label(ref lWriteNoSegBump);

    c.dec(__word_ptr[bp - 14]);
    c.jmp(lWriteLoopTop);

    c.Label(ref lWriteError);
    c.jmp(lRwExit);

    // ---------------- Shared exit: we did all the work ourselves, so just IRET (no tail-jump
    // into the original handler - it would re-run AH=02/03 through 831Bh/CHS mode on stale
    // registers, which is wrong for an LBA-mode request). ----------------
    c.Label(ref lRwSuccess);
    c.xor(ah, ah);

    c.Label(ref lRwExit);
    c.or(ah, ah);
    c.jz(lRwSetCF);
    c.or(__word_ptr[bp + 6], 1);
    c.jmp(lRwRestore);
    c.Label(ref lRwSetCF);
    c.and(__word_ptr[bp + 6], 0xFFFE);
    c.Label(ref lRwRestore);
    c.pop(ds);
    c.pop(es);
    c.pop(di);
    c.pop(si);
    c.mov(sp, bp);
    c.pop(bp);
    c.iret();

    var stream = new MemoryStream();
    var writer = new StreamCodeWriter(stream);
    c.Assemble(writer, ShimOrigin);
    return stream.ToArray();
}

// ---------------- entry point ----------------
if (args.Length == 0)
{
    Console.WriteLine("Usage: BiosPatcher --dump | --patch <in.bin> <out.bin>");
    return;
}

if (args[0] == "--dump")
{
    var bytes = BuildShim();
    Console.WriteLine($"Shim size: {bytes.Length} bytes (budget: 6212 bytes free)");
    for (int i = 0; i < bytes.Length; i += 16)
    {
        var chunk = bytes.Skip(i).Take(16).ToArray();
        Console.WriteLine($"+0x{i:X4}  {BitConverter.ToString(chunk).Replace("-", " ")}");
    }
}
else if (args[0] == "--patch" && args.Length >= 3)
{
    var shim = BuildShim();
    if (shim.Length > 6212) throw new Exception($"Shim too large: {shim.Length} > 6212 bytes free");
    var rom = File.ReadAllBytes(args[1]);
    Array.Copy(shim, 0, rom, ShimFileOffset, shim.Length);
    if (!(rom[VectorPatchFileOffset] == 0xFE && rom[VectorPatchFileOffset + 1] == 0x7D))
        throw new Exception("Vector-install bytes at expected offset don't match 7DFEh - refusing to patch.");
    rom[VectorPatchFileOffset] = (byte)(ShimOrigin & 0xFF);
    rom[VectorPatchFileOffset + 1] = (byte)((ShimOrigin >> 8) & 0xFF);
    File.WriteAllBytes(args[2], rom);
    Console.WriteLine($"Patched. Shim: {shim.Length} bytes at file 0x{ShimFileOffset:X} (F000:{ShimOrigin:X4}). Wrote {args[2]}");
}

sealed class StreamCodeWriter : CodeWriter
{
    private readonly Stream _s;
    public StreamCodeWriter(Stream s) { _s = s; }
    public override void WriteByte(byte value) => _s.WriteByte(value);
}
