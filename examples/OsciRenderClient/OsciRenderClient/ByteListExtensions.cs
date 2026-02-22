using System.Text;
// Extension helpers


namespace OsciRenderClient;
public static class ByteListExtensions
{
    public static void AddTag(this List<byte> buf, string tag)
        => buf.AddRange(Encoding.UTF8.GetBytes(tag)); // must be exactly 8 chars

    public static void AddUInt64(this List<byte> buf, ulong value)
        => buf.AddRange(BitConverter.GetBytes(value)); // LE on x86 by default

    public static void AddDouble(this List<byte> buf, double value)
        => buf.AddRange(BitConverter.GetBytes(value));
}
