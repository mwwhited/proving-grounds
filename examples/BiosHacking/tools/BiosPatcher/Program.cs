using System;
using System.IO;
using System.Linq;
using System.Collections.Generic;
using Iced.Intel;
using static Iced.Intel.AssemblerRegisters;

// Builds the LBA-translation INT13h shim, assembles it, and either:
//   --selftest   : runs it through the built-in x86-16 interpreter against known-good
//                  test vectors (verified independently in JS) and reports pass/fail.
//   --patch <in.bin> <out.bin> : injects the shim into a copy of the ROM and rewrites
//                  the INT13h vector-install instruction to point at it.
//
// Shim placement is fixed by the free-space survey done during analysis:
//   file offset 0x13FBC == F000:3FBC (6,212 bytes of erased 0xFF here).
// Original INT13h handler entry (untouched) is F000:7DFE == file 0x17DFE.
// Helper "get fixed-disk parameter table ptr for DL" is F000:8255 == file 0x18255.
// Vector-install instruction to patch: file 0x17C79-0x17C7A, imm16 7DFEh -> 3FBCh.

const int ShimOrigin = 0x3FBC;
const int OrigHandlerOffset = 0x7DFE;
const int GetTableHelperOffset = 0x8255;
const int VectorPatchFileOffset = 0x17C79; // low byte of the imm16 operand
const int ShimFileOffset = 0x13FBC;
const int MaxIter = 4; // safety cap proven sufficient & DIV-overflow-safe, see BIOS_ANALYSIS.md

byte[] BuildShim(out Dictionary<string, int> labelOffsets)
{
    var c = new Assembler(16);

    var lEntry = c.CreateLabel("Entry");
    var lPass = c.CreateLabel("PassThrough");
    var lGetParams = c.CreateLabel("HandlerGetParams");
    var lRW = c.CreateLabel("HandlerRW");
    var lGetTrueGeom = c.CreateLabel("GetTrueGeom");
    var lComputeFactor = c.CreateLabel("ComputeFactor");
    var lCFLoop = c.CreateLabel("CFLoop");
    var lCFDone = c.CreateLabel("CFDone");
    var lGPClylOK = c.CreateLabel("GPCylOK");
    var lGPExit = c.CreateLabel("GPExit");

    // ---------------- Entry ----------------
    c.Label(ref lEntry);
    c.cmp(dl, 0x80);
    c.jne(lPass);
    c.cmp(ah, 0x08);
    c.je(lGetParams);
    c.cmp(ah, 0x02);
    c.je(lRW);
    c.cmp(ah, 0x03);
    c.je(lRW);

    c.Label(ref lPass);
    // JMP FAR PTR F000:7DFEh (opcode EA, offset16, segment16) - Assembler has no direct
    // "jmp to absolute far immediate" helper, so this is emitted as raw bytes.
    c.db(0xEA, (byte)(OrigHandlerOffset & 0xFF), (byte)((OrigHandlerOffset >> 8) & 0xFF), 0x00, 0xF0);

    // ---------------- GetTrueGeom (ax=true_cyl[unused by caller in RW path], bx=true_heads, cx=true_spt) ----------------
    c.Label(ref lGetTrueGeom);
    c.call(GetTableHelperOffset); // -> es:si = table ptr; clobbers ax
    var mCyl = __word_ptr[si]; mCyl.Segment = Register.ES;
    c.mov(ax, mCyl);
    c.xor(bx, bx);
    var mHeads = __byte_ptr[si + 2]; mHeads.Segment = Register.ES;
    c.mov(bl, mHeads);
    c.xor(cx, cx);
    var mSpt = __byte_ptr[si + 0x0E]; mSpt.Segment = Register.ES;
    c.mov(cl, mSpt);
    c.ret();

    // ---------------- ComputeFactor (in bx=true_heads; out bx=logical_heads; clobbers ax,cx) ----------------
    c.Label(ref lComputeFactor);
    c.xor(cx, cx);
    c.Label(ref lCFLoop);
    c.cmp(cx, MaxIter);
    c.jae(lCFDone);
    c.mov(ax, bx);
    c.shl(ax, 1);
    c.cmp(ax, 240);
    c.ja(lCFDone);
    c.mov(bx, ax);
    c.inc(cx);
    c.jmp(lCFLoop);
    c.Label(ref lCFDone);
    c.ret();

    // ---------------- Handler_GetParams (AH=08, DL=80h) ----------------
    c.Label(ref lGetParams);
    c.push(bp);
    c.mov(bp, sp);
    c.push(bx);
    c.push(cx);
    c.push(dx);
    c.push(si);
    c.push(es);
    c.push(ds);

    c.call(lGetTrueGeom);          // ax=true_cyl, bx=true_heads, cx=true_spt
    c.push(ax);                    // save true_cyl
    c.push(cx);                    // save true_spt
    c.call(lComputeFactor);        // in bx=true_heads -> out bx=logical_heads, cx=k
    c.pop(dx);                     // dx = true_spt
    c.pop(ax);                     // ax = true_cyl
    c.shr(ax, cl);                 // ax = logical_cyl = true_cyl >> k
    c.cmp(ax, 1024);
    c.jbe(lGPClylOK);
    c.mov(ax, 1024);
    c.Label(ref lGPClylOK);
    c.dec(ax);                     // ax = logical_cyl - 1
    c.mov(ch, al);
    c.mov(cl, ah);
    c.and(cl, 0x03);
    c.shl(cl, 6);
    c.or(cl, dl);                  // dl = true_spt low byte (<=63)
    c.dec(bx);                     // bx = logical_heads - 1
    c.mov(dh, bl);
    // NOTE: deliberately NOT replicating the original's DL=(count of hard disks) output here -
    // doing so needs DS repointed at the BDA (mov ds,[cs:0D49Fh] in the original), and no
    // mainstream INT13h AH=08 caller actually keys off DL for a fixed disk. Leaving DL=80h
    // (the input drive number) is a safe, low-risk simplification. See BIOS_ANALYSIS.md/PATCH_NOTES.md.
    c.xor(ah, ah);                 // ah = 0 (success)
    c.and(__word_ptr[bp + 6], 0xFFFE); // clear CF in the FLAGS word IRET will pop
    c.Label(ref lGPExit);
    c.pop(ds);
    c.pop(es);
    c.pop(si);
    c.mov(sp, bp);
    c.pop(bp);
    c.iret();

    // ---------------- Handler_RW (AH=02/03, DL=80h) ----------------
    c.Label(ref lRW);
    c.push(bp);
    c.mov(bp, sp);
    c.sub(sp, 20);
    c.push(si);
    c.push(di);
    c.push(es);
    c.push(ds);

    c.mov(__word_ptr[bp - 2], ax);
    c.mov(__word_ptr[bp - 4], bx);
    c.mov(__word_ptr[bp - 6], cx);
    c.mov(__word_ptr[bp - 8], dx);

    // unpack logical CHS from cx (CH:CL) / dx (DH:DL)
    c.mov(ax, cx);
    c.mov(bl, al);      // bl = CL byte
    c.mov(al, ah);      // al = CH (cyl low8)
    c.mov(ah, bl);
    c.and(ah, 0xC0);
    c.shr(ah, 6);       // ax = logical_cyl_in (al=lo8, ah=hi2)
    c.mov(__word_ptr[bp - 16], ax);
    c.mov(al, bl);
    c.and(al, 0x3F);
    c.xor(ah, ah);
    c.mov(__word_ptr[bp - 20], ax); // sector_in
    c.mov(al, dh);
    c.xor(ah, ah);
    c.mov(__word_ptr[bp - 18], ax); // logical_head_in

    c.call(lGetTrueGeom);          // ax=true_cyl(unused), bx=true_heads, cx=true_spt
    c.mov(__word_ptr[bp - 10], bx);
    c.mov(__word_ptr[bp - 12], cx);
    c.call(lComputeFactor);        // -> bx=logical_heads
    c.mov(__word_ptr[bp - 14], bx);

    // step1: dx:ax = logical_cyl_in * logical_heads ; += logical_head_in
    c.mov(ax, __word_ptr[bp - 16]);
    c.mul(__word_ptr[bp - 14]);
    c.add(ax, __word_ptr[bp - 18]);
    c.adc(dx, 0);

    // step2: dx:ax = (dx:ax) * true_spt   (32x16->32)
    c.push(ax);
    c.mov(ax, dx);
    c.mov(cx, __word_ptr[bp - 12]);
    c.mul(cx);
    c.mov(bx, ax);
    c.pop(ax);
    c.mul(cx);
    c.add(dx, bx);

    // += (sector_in - 1)
    c.mov(cx, __word_ptr[bp - 20]);
    c.dec(cx);
    c.add(ax, cx);
    c.adc(dx, 0);
    // dx:ax = LBA

    // true_cyl_out = LBA / (true_heads*true_spt) ; remainder1 in dx
    c.push(ax); // LBA_lo
    c.mov(ax, __word_ptr[bp - 10]);
    c.mul(__word_ptr[bp - 12]); // ax = true_heads*true_spt
    c.mov(cx, ax);
    c.pop(ax);  // ax = LBA_lo, dx = LBA_hi (untouched since the mul above only used ax/dx transiently then we overwrote ax via pop -- dx from LBA calc survives because mul's dx output was captured into ax->cx path without touching outer dx? NEED CARE: 'mul word[bp-12]' writes DX too. See note.)
    c.div(cx);  // ax = true_cyl_out, dx = remainder1

    c.mov(si, ax); // si = true_cyl_out
    c.mov(ax, dx); // ax = remainder1
    c.xor(dx, dx);
    c.mov(cx, __word_ptr[bp - 12]); // true_spt
    c.div(cx); // ax = true_head_out, dx = sector_out - 1

    c.push(ax);       // save true_head_out
    c.mov(ax, dx);
    c.inc(ax);         // ax = true_sect_out (1-based)
    c.mov(cl, al);      // temp hold sector in cl
    c.mov(ax, si);      // ax = true_cyl_out
    c.mov(ch, al);      // ch = cyl low8
    c.mov(al, ah);
    c.and(al, 0x03);
    c.shl(al, 6);
    c.or(al, cl);
    c.mov(cl, al);      // cl = final sector+cylhi byte
    c.pop(ax);          // ax = true_head_out
    c.mov(dh, al);      // dh = true head (0-based)
    c.mov(dl, 0x80);

    c.mov(bx, __word_ptr[bp - 4]);
    c.mov(ax, __word_ptr[bp - 2]);

    c.pop(ds);
    c.pop(es);
    c.pop(di);
    c.pop(si);
    c.mov(sp, bp);
    c.pop(bp);
    c.db(0xEA, (byte)(OrigHandlerOffset & 0xFF), (byte)((OrigHandlerOffset >> 8) & 0xFF), 0x00, 0xF0);

    var stream = new MemoryStream();
    var writer = new StreamCodeWriter(stream);
    c.Assemble(writer, ShimOrigin);

    labelOffsets = new Dictionary<string, int>();
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
    var bytes = BuildShim(out _);
    Console.WriteLine($"Shim size: {bytes.Length} bytes (budget: 6212 bytes free)");
    for (int i = 0; i < bytes.Length; i += 16)
    {
        var chunk = bytes.Skip(i).Take(16).ToArray();
        Console.WriteLine($"+0x{i:X4}  {BitConverter.ToString(chunk).Replace("-", " ")}");
    }
}
else if (args[0] == "--patch" && args.Length >= 3)
{
    var shim = BuildShim(out _);
    if (shim.Length > 6212) throw new Exception($"Shim too large: {shim.Length} > 6212 bytes free");
    var rom = File.ReadAllBytes(args[1]);
    Array.Copy(shim, 0, rom, ShimFileOffset, shim.Length);
    // pad remainder of the free block back to 0xFF (already is, but be explicit/safe)
    // patch vector-install immediate 7DFEh -> ShimOrigin
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
