using System;
using System.Collections.Generic;
using System.Text;
using System.Reflection;
using System.IO;
using System.Windows.Forms;
using System.IO.Compression;
using System.Security.Cryptography;

namespace ConsoleApplication2
{
    class Program
    {
        public static byte[] Compress(byte[] input)
        {
            if (input == null || input.Length < 1)
                return null;

            using (MemoryStream rawDataStreamIn = new MemoryStream(input))
            {
                using (MemoryStream compressedDataStreamOut = new MemoryStream())
                {
                    using (DeflateStream deflateCompress = new DeflateStream(compressedDataStreamOut, CompressionMode.Compress, true))
                    {
                        byte[] buffer = new byte[1024];
                        int bufferLen;
                        do
                        {
                            bufferLen = rawDataStreamIn.Read(buffer, 0, buffer.Length);
                            if (bufferLen > 0)
                                deflateCompress.Write(buffer, 0, bufferLen);
                        } while (bufferLen > 0);
                    }
                    return compressedDataStreamOut.ToArray();
                }
            }
        }

        public static byte[] Decompress(byte[] input)
        {
            if (input == null || input.Length < 1)
                return null;

            using (MemoryStream compressedData = new MemoryStream(input))
            {
                using (MemoryStream decompressedData = new MemoryStream())
                {
                    using (DeflateStream deflateDecompress = new DeflateStream(compressedData, CompressionMode.Decompress, true))
                    {
                        byte[] buffer = new byte[1024];
                        int bufferLen;
                        do
                        {
                            bufferLen = deflateDecompress.Read(buffer, 0, buffer.Length);
                            if (bufferLen > 0)
                                decompressedData.Write(buffer, 0, bufferLen);
                        } while (bufferLen > 0);
                    }
                    return decompressedData.ToArray();
                }
            }
        }

        public static byte[] Encrypt(byte[] input, ref byte[] iv, ref byte[] key)
        {
            if (input == null || input.Length < 1)
                return null;

            using (MemoryStream rawStream = new MemoryStream(input))
            {
                using (MemoryStream encryptedStreamOut = new MemoryStream())
                {
                    using (SymmetricAlgorithm symAlg = SymmetricAlgorithm.Create())
                    {
                        if (iv == null || iv.Length < 1)
                        {
                            symAlg.GenerateIV();
                            iv = symAlg.IV;
                        }
                        else
                            symAlg.IV = iv;

                        if (key == null || key.Length < 1)
                        {
                            symAlg.GenerateKey();
                            key = symAlg.Key;
                        }
                        else symAlg.Key = key;

                        using (CryptoStream cryptoStream = new CryptoStream(encryptedStreamOut, symAlg.CreateEncryptor(), CryptoStreamMode.Write))
                        {
                            byte[] buffer = new byte[1024];
                            int bufferLen;
                            do
                            {
                                bufferLen = rawStream.Read(buffer, 0, buffer.Length);
                                if (bufferLen > 0)
                                    cryptoStream.Write(buffer, 0, bufferLen);
                            } while (bufferLen > 0);
                        }

                    }
                    return encryptedStreamOut.ToArray();
                }
            }
        }

        public static byte[] Decrypt(byte[] input, byte[] iv, byte[] key)
        {
            if (input == null || input.Length < 1)
                return null;

            using (MemoryStream encryptedStreamIn = new MemoryStream(input))
            {
                using (MemoryStream decryptedStream = new MemoryStream())
                {
                    using (SymmetricAlgorithm symAlg = SymmetricAlgorithm.Create())
                    {
                        if (iv == null || iv.Length < 1)
                            throw new ArgumentNullException();
                        else
                            symAlg.IV = iv;

                        if (key == null || key.Length < 1)
                            throw new ArgumentNullException();
                        else
                            symAlg.Key = key;
                        using (CryptoStream cryptoStream = new CryptoStream(encryptedStreamIn, symAlg.CreateDecryptor(), CryptoStreamMode.Read))
                        {
                            byte[] buffer = new byte[1024];
                            int bufferLen;
                            do
                            {
                                bufferLen = cryptoStream.Read(buffer, 0, buffer.Length);
                                if (bufferLen > 0)
                                    decryptedStream.Write(buffer, 0, bufferLen);
                            } while (bufferLen > 0);
                        }
                    }
                    return decryptedStream.ToArray();
                }
            }
        }

        public static KeyIvPosition[] KeyIvs = new KeyIvPosition[]
            {
                KeyIvPosition.IKX,
                KeyIvPosition.IXK,
                KeyIvPosition.KIX,
                KeyIvPosition.KXI,
                KeyIvPosition.XIK,
                KeyIvPosition.XKI
            };

        public enum KeyIvPosition //nibble
        {
            X,
            XI,
            XK,
            XIK,
            XKI,
            IX,
            KX,
            IKX,
            KIX,
            IXK,
            KXI,
            R1,
            R2,
            R3,
            R4,
            R5
        }

        public static ushort GetBaseLength(byte[] input)
        {
            if (input != null && input.Length > 1)
            {
                if ((input.Length % 2) != 0)
                    throw new ArgumentOutOfRangeException();
                return (ushort)Math.Log((double)input.Length, 2d);
            }
            return 0;
        }

        public static byte[] Pack(byte[] input, byte[] iv, byte[] key, KeyIvPosition keyIv)
        {
            if (input == null || input.Length < 1)
                throw new ArgumentOutOfRangeException();

            byte[] inputLength = BitConverter.GetBytes(input.Length);

            ushort rawPackedHeader = (ushort)((((ushort)keyIv & 0xF) << 12) | (GetBaseLength(inputLength) & 0xF));

            if (
                keyIv == KeyIvPosition.IKX || keyIv == KeyIvPosition.IX ||
                keyIv == KeyIvPosition.IXK || keyIv == KeyIvPosition.KIX ||
                keyIv == KeyIvPosition.XI || keyIv == KeyIvPosition.XIK ||
                keyIv == KeyIvPosition.XKI || keyIv == KeyIvPosition.KXI
                )
                rawPackedHeader |= (ushort)((GetBaseLength(iv) & 0xF) << 8);

            if (
                keyIv == KeyIvPosition.KIX || keyIv == KeyIvPosition.KX ||
                keyIv == KeyIvPosition.KXI || keyIv == KeyIvPosition.XK ||
                keyIv == KeyIvPosition.KXI || keyIv == KeyIvPosition.IKX ||
                keyIv == KeyIvPosition.XIK || keyIv == KeyIvPosition.IXK
                )
                rawPackedHeader |= (ushort)((GetBaseLength(key) & 0xF) << 4);

            byte[] packedHeader = BitConverter.GetBytes(rawPackedHeader);

            using (MemoryStream packedStream = new MemoryStream())
            {
                packedStream.Write(packedHeader, 0, packedHeader.Length);
                packedStream.Write(inputLength, 0, inputLength.Length);

                for (int i = 0; i < 3; i++)
                {
                    if (
                        ((i == 0) && (keyIv < KeyIvPosition.IX)) ||
                        ((i == 1) && (keyIv == KeyIvPosition.IX || keyIv == KeyIvPosition.KX || keyIv == KeyIvPosition.IXK || keyIv == KeyIvPosition.KXI)) ||
                        ((i == 2) && (keyIv == KeyIvPosition.IKX || keyIv == KeyIvPosition.KIX))
                        )
                        packedStream.Write(input, 0, input.Length);
                    else if (iv != null && (
                        ((i == 0) && (keyIv == KeyIvPosition.IKX || keyIv == KeyIvPosition.IX || keyIv == KeyIvPosition.IXK)) ||
                        ((i == 1) && (keyIv == KeyIvPosition.KIX || keyIv == KeyIvPosition.XI || keyIv == KeyIvPosition.XIK)) ||
                        ((i == 2) && (keyIv == KeyIvPosition.XKI || keyIv == KeyIvPosition.KXI))
                        ))
                        packedStream.Write(iv, 0, iv.Length);
                    else if (key != null && (
                        ((i == 0) && (keyIv == KeyIvPosition.KIX || keyIv == KeyIvPosition.KX || keyIv == KeyIvPosition.KXI)) ||
                        ((i == 1) && (keyIv == KeyIvPosition.XK || keyIv == KeyIvPosition.KXI || keyIv == KeyIvPosition.IKX)) ||
                        ((i == 2) && (keyIv == KeyIvPosition.XIK || keyIv == KeyIvPosition.IXK))
                        ))
                        packedStream.Write(key, 0, key.Length);
                }

                return packedStream.ToArray();
            }
        }

        public static byte[] Unpack(byte[] packed, ref byte[] iv, ref byte[] key)
        {
            if (packed == null || packed.Length < 4)
                throw new ArgumentOutOfRangeException();

            byte[] buffer = new byte[2];
            Array.Copy(packed, buffer, buffer.Length);
            ushort packedHeaderData = BitConverter.ToUInt16(buffer, 0);
            KeyIvPosition keyIv = (KeyIvPosition)((packedHeaderData & 0xF000) >> 12);
            int ivLength = (int)Math.Pow(2, (packedHeaderData & 0x0F00) >> 8);
            int keyLength = (int)Math.Pow(2, (packedHeaderData & 0x00F0) >> 4);
            int dataHeaderLength = (int)Math.Pow(2, (packedHeaderData & 0x000F));

            buffer = new byte[dataHeaderLength];
            Array.Copy(packed, 2, buffer, 0, buffer.Length);
            int dataLength = BitConverter.ToInt32(buffer, 0);

            if (ivLength <= 1)
                iv = null;
            else
                iv = new byte[ivLength];

            if (keyLength <= 1)
                key = null;
            else
                key = new byte[keyLength];

            byte[] dataOutBuffer = null;
            if (dataLength < 1)
                dataOutBuffer = null;
            else
                dataOutBuffer = new byte[dataLength];

            int nextPosition = 2 + dataHeaderLength;
            for (int i = 0; i < 3; i++)
            {
                if (
                    ((i == 0) && (keyIv < KeyIvPosition.IX)) ||
                    ((i == 1) && (keyIv == KeyIvPosition.IX || keyIv == KeyIvPosition.KX || keyIv == KeyIvPosition.IXK || keyIv == KeyIvPosition.KXI)) ||
                    ((i == 2) && (keyIv == KeyIvPosition.IKX || keyIv == KeyIvPosition.KIX))
                    )
                {
                    Array.Copy(packed, nextPosition, dataOutBuffer, 0, dataOutBuffer.Length);
                    nextPosition += dataOutBuffer.Length;
                }
                else if (iv != null && (
                    ((i == 0) && (keyIv == KeyIvPosition.IKX || keyIv == KeyIvPosition.IX || keyIv == KeyIvPosition.IXK)) ||
                    ((i == 1) && (keyIv == KeyIvPosition.KIX || keyIv == KeyIvPosition.XI || keyIv == KeyIvPosition.XIK)) ||
                    ((i == 2) && (keyIv == KeyIvPosition.XKI || keyIv == KeyIvPosition.KXI))
                    ))
                {
                    Array.Copy(packed, nextPosition, iv, 0, iv.Length);
                    nextPosition += iv.Length;
                }
                else if (key != null && (
                   ((i == 0) && (keyIv == KeyIvPosition.KIX || keyIv == KeyIvPosition.KX || keyIv == KeyIvPosition.KXI)) ||
                   ((i == 1) && (keyIv == KeyIvPosition.XK || keyIv == KeyIvPosition.KXI || keyIv == KeyIvPosition.IKX)) ||
                   ((i == 2) && (keyIv == KeyIvPosition.XIK || keyIv == KeyIvPosition.IXK))
                   ))
                {
                    Array.Copy(packed, nextPosition, key, 0, key.Length);
                    nextPosition += key.Length;
                }
            }
            return dataOutBuffer;
        }

        [STAThread]
        static void Main(string[] args)
        {
            StringBuilder sb = new StringBuilder();
            DirectoryInfo di = new DirectoryInfo(".\\");
            foreach (FileInfo file in di.GetFiles())
            {
                if (!file.Name.StartsWith("out.") && !file.Name.EndsWith(".pck"))
                {
                    sb.AppendFormat("{0}^", file.Name);
                    sb.AppendLine(Convert.ToBase64String(File.ReadAllBytes(file.FullName)));
                }
            }

            byte[] inputBuffer = Encoding.UTF8.GetBytes(sb.ToString());
            //====================
            byte[] compressedBuffer = Compress(inputBuffer);
            //====================
            byte[] iv = null;
            byte[] key = null;
            byte[] encryptedBuffer = Encrypt(compressedBuffer, ref iv, ref key);
            //====================
            KeyIvPosition keyIv = KeyIvs[new Random().Next(KeyIvs.Length)];
            byte[] packed = Pack(encryptedBuffer, iv, key, keyIv);
            Clipboard.SetText(Convert.ToBase64String(packed));
            File.WriteAllBytes(string.Format("{0}.pck", Guid.NewGuid()), packed);
            //====================
            byte[] unpacked = Unpack(packed, ref iv, ref key);
            //====================
            byte[] decryptedBuffer = Decrypt(unpacked, iv, key);
            //====================
            byte[] decompressedDataBuffer = Decompress(decryptedBuffer);
            //====================
            if (Encoding.UTF8.GetString(decompressedDataBuffer) != Encoding.UTF8.GetString(inputBuffer))
                throw new InvalidOperationException();

            //string[] data = Encoding.UTF8.GetString(decompressedDataBuffer).Split('\r');
            //foreach (string content in data)
            //{
            //    string[] parts = content.Split('^');
            //    if (parts.Length > 1)
            //    {
            //        try
            //        {
            //            File.WriteAllBytes(string.Format("out.{0}", parts[0].Trim('\n')), Convert.FromBase64String(parts[1]));
            //        }
            //        catch (Exception ex)
            //        {
            //            Console.WriteLine(ex.ToString());
            //        }
            //    }
            //}
        }
    }
}
