using System;
using System.IO;

// Minimal 8085 disassembler. Usage:
//   I8085Disasm <romfile> <fileOffsetHex> <lengthHex> <baseAddrHex>
// Prints a linear disassembly: ADDR: bytes   mnemonic
// The 8085 instruction set is Intel's fully public, documented ISA (8080-compatible plus
// RIM/SIM); this table is transcribed from that public opcode map, not from any third-party text.

if (args.Length < 4)
{
    Console.WriteLine("Usage: I8085Disasm <romfile> <fileOffsetHex> <lengthHex> <baseAddrHex>");
    return;
}

string path = args[0];
int fileOffset = Convert.ToInt32(args[1], 16);
int length = Convert.ToInt32(args[2], 16);
int baseAddr = Convert.ToInt32(args[3], 16);

byte[] rom = File.ReadAllBytes(path);

string[] reg8 = { "B", "C", "D", "E", "H", "L", "M", "A" };
string[] regPair = { "B", "D", "H", "SP" };      // for LXI/INX/DCX/DAD
string[] regPairPush = { "B", "D", "H", "PSW" }; // for PUSH/POP
string[] cc = { "NZ", "Z", "NC", "C", "PO", "PE", "P", "M" };

byte ReadB(int off) => off < rom.Length ? rom[off] : (byte)0;
string Hex2(int v) => v.ToString("X2") + "h";
string Hex4(int v) => v.ToString("X4") + "h";

int addr = baseAddr;
int fo = fileOffset;
int end = fileOffset + length;

while (fo < end && fo < rom.Length)
{
    int startFo = fo;
    int startAddr = addr;
    byte op = ReadB(fo);
    int len = 1;
    string mnem;

    int ddd = (op >> 3) & 7; // destination reg field
    int sss = op & 7;        // source reg field
    int rp = (op >> 4) & 3;  // register pair field

    if (op == 0x00) mnem = "NOP";
    else if (op == 0x76) mnem = "HLT";
    else if (op >= 0x40 && op <= 0x7F) mnem = $"MOV     {reg8[ddd]},{reg8[sss]}";
    else if ((op & 0xC7) == 0x06) { mnem = $"MVI     {reg8[ddd]},{Hex2(ReadB(fo + 1))}"; len = 2; }
    else if ((op & 0xCF) == 0x01) { mnem = $"LXI     {regPair[rp]},{Hex4(ReadB(fo + 1) | (ReadB(fo + 2) << 8))}"; len = 3; }
    else if ((op & 0xC7) == 0x04) mnem = $"INR     {reg8[ddd]}";
    else if ((op & 0xC7) == 0x05) mnem = $"DCR     {reg8[ddd]}";
    else if ((op & 0xCF) == 0x03) mnem = $"INX     {regPair[rp]}";
    else if ((op & 0xCF) == 0x0B) mnem = $"DCX     {regPair[rp]}";
    else if ((op & 0xCF) == 0x09) mnem = $"DAD     {regPair[rp]}";
    else if (op == 0x02) mnem = "STAX    B";
    else if (op == 0x12) mnem = "STAX    D";
    else if (op == 0x0A) mnem = "LDAX    B";
    else if (op == 0x1A) mnem = "LDAX    D";
    else if (op == 0x07) mnem = "RLC";
    else if (op == 0x0F) mnem = "RRC";
    else if (op == 0x17) mnem = "RAL";
    else if (op == 0x1F) mnem = "RAR";
    else if (op == 0x20) mnem = "RIM";
    else if (op == 0x30) mnem = "SIM";
    else if (op == 0x22) { mnem = $"SHLD    {Hex4(ReadB(fo + 1) | (ReadB(fo + 2) << 8))}"; len = 3; }
    else if (op == 0x2A) { mnem = $"LHLD    {Hex4(ReadB(fo + 1) | (ReadB(fo + 2) << 8))}"; len = 3; }
    else if (op == 0x32) { mnem = $"STA     {Hex4(ReadB(fo + 1) | (ReadB(fo + 2) << 8))}"; len = 3; }
    else if (op == 0x3A) { mnem = $"LDA     {Hex4(ReadB(fo + 1) | (ReadB(fo + 2) << 8))}"; len = 3; }
    else if (op == 0x27) mnem = "DAA";
    else if (op == 0x2F) mnem = "CMA";
    else if (op == 0x37) mnem = "STC";
    else if (op == 0x3F) mnem = "CMC";
    else if (op >= 0x80 && op <= 0x87) mnem = $"ADD     {reg8[sss]}";
    else if (op >= 0x88 && op <= 0x8F) mnem = $"ADC     {reg8[sss]}";
    else if (op >= 0x90 && op <= 0x97) mnem = $"SUB     {reg8[sss]}";
    else if (op >= 0x98 && op <= 0x9F) mnem = $"SBB     {reg8[sss]}";
    else if (op >= 0xA0 && op <= 0xA7) mnem = $"ANA     {reg8[sss]}";
    else if (op >= 0xA8 && op <= 0xAF) mnem = $"XRA     {reg8[sss]}";
    else if (op >= 0xB0 && op <= 0xB7) mnem = $"ORA     {reg8[sss]}";
    else if (op >= 0xB8 && op <= 0xBF) mnem = $"CMP     {reg8[sss]}";
    else if (op == 0xC6) { mnem = $"ADI     {Hex2(ReadB(fo + 1))}"; len = 2; }
    else if (op == 0xCE) { mnem = $"ACI     {Hex2(ReadB(fo + 1))}"; len = 2; }
    else if (op == 0xD6) { mnem = $"SUI     {Hex2(ReadB(fo + 1))}"; len = 2; }
    else if (op == 0xDE) { mnem = $"SBI     {Hex2(ReadB(fo + 1))}"; len = 2; }
    else if (op == 0xE6) { mnem = $"ANI     {Hex2(ReadB(fo + 1))}"; len = 2; }
    else if (op == 0xEE) { mnem = $"XRI     {Hex2(ReadB(fo + 1))}"; len = 2; }
    else if (op == 0xF6) { mnem = $"ORI     {Hex2(ReadB(fo + 1))}"; len = 2; }
    else if (op == 0xFE) { mnem = $"CPI     {Hex2(ReadB(fo + 1))}"; len = 2; }
    else if (op == 0xC3) { mnem = $"JMP     {Hex4(ReadB(fo + 1) | (ReadB(fo + 2) << 8))}"; len = 3; }
    else if ((op & 0xC7) == 0xC2) { mnem = $"J{cc[ddd],-3} {Hex4(ReadB(fo + 1) | (ReadB(fo + 2) << 8))}"; len = 3; }
    else if (op == 0xCD) { mnem = $"CALL    {Hex4(ReadB(fo + 1) | (ReadB(fo + 2) << 8))}"; len = 3; }
    else if ((op & 0xC7) == 0xC4) { mnem = $"C{cc[ddd],-3} {Hex4(ReadB(fo + 1) | (ReadB(fo + 2) << 8))}"; len = 3; }
    else if (op == 0xC9) mnem = "RET";
    else if ((op & 0xC7) == 0xC0) mnem = $"R{cc[ddd]}";
    else if ((op & 0xC7) == 0xC7) mnem = $"RST     {ddd}";
    else if ((op & 0xCF) == 0xC1) mnem = $"POP     {regPairPush[rp]}";
    else if ((op & 0xCF) == 0xC5) mnem = $"PUSH    {regPairPush[rp]}";
    else if (op == 0xE9) mnem = "PCHL";
    else if (op == 0xF9) mnem = "SPHL";
    else if (op == 0xE3) mnem = "XTHL";
    else if (op == 0xEB) mnem = "XCHG";
    else if (op == 0xF3) mnem = "DI";
    else if (op == 0xFB) mnem = "EI";
    else if (op == 0xD3) { mnem = $"OUT     {Hex2(ReadB(fo + 1))}"; len = 2; }
    else if (op == 0xDB) { mnem = $"IN      {Hex2(ReadB(fo + 1))}"; len = 2; }
    else { mnem = "DB      " + Hex2(op) + "  ; undefined opcode (NOP-like on real silicon)"; len = 1; }

    string bytesHex = "";
    for (int i = 0; i < len; i++) bytesHex += ReadB(startFo + i).ToString("X2") + " ";

    Console.WriteLine($"{startAddr:X4}: [+0x{startFo:X4}] {bytesHex,-10} {mnem}");

    fo += len;
    addr += len;
}
