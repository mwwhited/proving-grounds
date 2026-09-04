using System;
using System.IO;
using Iced.Intel;

// Usage: disasm <romfile> <fileOffsetHex> <lengthHex> <ipHex> [labelPrefix]
// Disassembles 16-bit real-mode code starting at fileOffsetHex, printing addresses as ipHex+delta.
if (args.Length < 4)
{
    Console.WriteLine("Usage: disasm <romfile> <fileOffsetHex> <lengthHex> <ipHex>");
    return;
}

string path = args[0];
int fileOffset = Convert.ToInt32(args[1], 16);
int length = Convert.ToInt32(args[2], 16);
ulong ip = Convert.ToUInt64(args[3], 16);

byte[] rom = File.ReadAllBytes(path);
byte[] slice = new byte[length];
Array.Copy(rom, fileOffset, slice, 0, length);

var codeReader = new ByteArrayCodeReader(slice);
var decoder = Decoder.Create(16, codeReader);
decoder.IP = ip;
ulong endIp = ip + (ulong)length;

var formatter = new NasmFormatter();
formatter.Options.DigitSeparator = "";
formatter.Options.FirstOperandCharIndex = 8;
var output = new StringOutput();

while (decoder.IP < endIp)
{
    ulong instrIp = decoder.IP;
    int startOffset = fileOffset + (int)(instrIp - ip);
    decoder.Decode(out var instr);
    if (instr.IsInvalid)
    {
        Console.WriteLine($"F000:{instrIp:X4}  [+0x{startOffset:X5}]  DB 0x{slice[(int)(instrIp - ip)]:X2}  (bad)");
        continue;
    }
    formatter.Format(instr, output);
    string disasmLine = output.ToStringAndReset();
    string bytesHex = BitConverter.ToString(slice, (int)(instrIp - ip), instr.Length).Replace("-", " ");
    Console.WriteLine($"F000:{instrIp:X4}  [+0x{startOffset:X5}]  {bytesHex,-24} {disasmLine}");
}
