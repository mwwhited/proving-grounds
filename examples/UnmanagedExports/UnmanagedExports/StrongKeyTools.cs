using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Threading;
using System.Text.RegularExpressions;

namespace UnmanagedExports
{
    public static class StrongKeyTools
    {
        static readonly string sn =
            @"c:\Program Files\Microsoft SDKs\Windows\v6.0A\bin\sn.exe";

        public static IEnumerable<string> AsPublicKey(this byte[] buffer)
        {
            var sb = new StringBuilder();
            for (int i = 0; i < buffer.Length; i++)
            {
                if (i % 16 == 0)
                {
                    if (i == 0)
                        sb.Append("  .publickey = (");
                    else
                    {
                        yield return sb.ToString();
                        sb = new StringBuilder();
                        sb.Append("                ");
                    }
                }
                sb.Append(buffer[i].ToString("X2") + " ");
            }
            sb.Append(")");
            yield return sb.ToString();
        }

        public static IEnumerable<string> ParseStrongKey(
                                            this IEnumerable<string> ilLines,
                                                 string keyFile)
        {
            if (string.IsNullOrEmpty(keyFile) || !File.Exists(keyFile))
                foreach (var line in ilLines)
                    yield return line;

            var publicKey = Path.GetTempFileName();
            var keyArgs = string.Format("-p \"{0}\" \"{1}\"",
                                        keyFile,
                                        publicKey);

            keyFile.BlockTillRead();
            Thread.Sleep(100);
            sn.RunAs(keyArgs);
            publicKey.BlockTillRead();

            var publicKeyBuffer = File.ReadAllBytes(publicKey);
            if (File.Exists(publicKey))
                File.Delete(publicKey);

            //.assembly extern ExportTest
            //.assembly ExportTest
            //{
            //  .publickey = (00 24 00 00 04 80 00 00 94 00 00 00 06 02 00 00   // .$..............
            //                00 24 00 00 52 53 41 31 00 04 00 00 01 00 01 00   // .$..RSA1........
            //                ED 51 AB 5E 06 71 85 8E 48 45 48 FD 7C FD F6 51   // .Q.^.q..HEH.|..Q
            //                FF 6E 05 FD B7 9D 5E 95 9F E8 B3 7D 01 2C CD D4   // .n....^....}.,..
            //                3D F0 76 11 0A 1D DE 8F CB B5 8D BA 72 27 A9 D7   // =.v.........r'..
            //                B0 12 D1 2D CD CD F4 F4 8A E7 82 CA 58 D9 C1 45   // ...-........X..E
            //                6B 3D C7 97 FD 3F 73 48 DD 33 76 5A D1 67 04 03   // k=...?sH.3vZ.g..
            //                55 E6 3E 0E AE 7D 4C 4F 59 8A EB 5B E5 D0 B1 72   // U.>..}LOY..[...r
            //                6B F8 68 4A FC A7 EE 02 AA 45 31 DE 9C 72 E8 10   // k.hJ.....E1..r..
            //                CE E5 07 3D DE C8 E4 EC 1A 56 82 78 9A 84 1E A9 ) // ...=.....V.x....
            //  .hash algorithm 0x00008004
            //  .ver 1:0:0:0
            //}
            keyFile = Path.GetFullPath(keyFile);
            var skipKey = false;
            var inAssembly = false;
            foreach (var line in ilLines)
            {
                var trimmed = line.TrimStart();
                if (trimmed.StartsWith(".assembly "))
                {
                    if (!trimmed.StartsWith(".assembly extern "))
                        inAssembly = true;
                }

                if (inAssembly)
                {
                    if (trimmed.StartsWith("}"))
                    {
                        inAssembly = false;
                        skipKey = false;
                    }

                    if (trimmed.StartsWith(".hash"))
                        foreach (var keyLine in publicKeyBuffer.AsPublicKey())
                            yield return keyLine;

                    if (trimmed.StartsWith(".publickey"))
                        skipKey = true;

                    if (skipKey)
                    {
                        var regEx = new Regex(@"(?<atr>([^/]*))(//.*)?");
                        var match = regEx.Match(line);
                        var attrib = match.Groups["atr"];
                        var value = attrib.Value.TrimEnd();

                        if (value.EndsWith(")"))
                            skipKey = false;
                        continue;
                    }
                }

                yield return line;
            }
        }
    }
}
