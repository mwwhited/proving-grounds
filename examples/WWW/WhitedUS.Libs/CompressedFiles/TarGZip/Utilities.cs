using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.IO.Compression;
using System.Diagnostics;

namespace WhitedUS.Libs.CompressedFiles.TarGZip
{
    public static class TarGzUtilities
    {
        public static void UnTarGZ(this string inFile, string outPath)
        {
            byte[] infile = File.ReadAllBytes(inFile).DecompressGZ();

            byte[] buffer = new byte[512];
            TarHeader header = null;
            bool getHeader = true;
            FileStream newFile = null;
            int lengthWrote = 0;

            for (int i = 0; i < infile.Length; i += 512)
            {
                Array.Copy(infile, i, buffer, 0, buffer.Length);

                if (getHeader)
                {
                    header = buffer.ToHeader();
                    getHeader = false;
                }

                switch (header.FileType)
                {
                    case TarFileType.Normal:
                        if (header.FileSize == 0)
                            getHeader = true;
                        else
                        {
                            if (newFile == null)
                            {
                                var newFileName = Path.GetFullPath(Path.Combine(outPath, header.FileName));
                                var directory = Path.GetDirectoryName(newFileName);
                                if (!Directory.Exists(directory))
                                    Directory.CreateDirectory(directory);

                                lengthWrote = 0;
                                newFile = new FileStream(
                                            newFileName,
                                            FileMode.Create,
                                            FileAccess.ReadWrite);
                            }
                            else
                            {
                                newFile.Write(buffer, 0, Math.Min(
                                                buffer.Length,
                                                header.FileSize - lengthWrote
                                            ));
                                lengthWrote += 512;

                                if (lengthWrote >= header.FileSize)
                                {
                                    newFile.Flush();
                                    newFile.Close();
                                    newFile = null;
                                    getHeader = true;
                                    lengthWrote = 0;
                                }
                            }
                        }

                        break;
                    case TarFileType.HardLink:
                    case TarFileType.SymbolicLink:
                    case TarFileType.CharacterDevice:
                    case TarFileType.BlockDevice:
                    case TarFileType.NamedPipe:
                    case TarFileType.ContiguousFlie:
                        Debug.WriteLine("Windows doesn't care about these");
                        break;
                    case TarFileType.Directory:
                        if (!Directory.Exists(header.FileName))
                            Directory.CreateDirectory(header.FileName);
                        getHeader = true;
                        break;
                }
            }
        }

        public static TarHeader ToHeader(this byte[] input)
        {
            var result = new TarHeader();
            result.FileName = input.ToString(0, 100);
            result.FileMode = input.ToString(100, 8);
            result.OwnerId = input.ToString(108, 8);
            result.GroupId = input.ToString(116, 8);
            string fileSize = input.ToString(124, 12);
            result.FileSize = Convert.ToInt32(fileSize ?? "0", 8);
            result.LastModifiedTime = Convert.ToInt32(input.ToString(136, 12)
                                                                ?? "0", 8);
            result.CheckSum = input.ToString(148, 8);
            result.FileType = input.ToTarFileType();
            result.LinkedFile = input.ToString(157, 100);

            return result;
        }

        private static TarFileType ToTarFileType(this byte[] input)
        {
            try
            {
                return (TarFileType)Convert.ToByte(input.ToString(156, 1) ?? "0", 8);
            }
            catch (Exception e)
            {
                return TarFileType.NamedPipe;
                //var v = input[156];
                //var c = (char)v;
                //var s = input.ToString(156, 1);


                //var b = Convert.ToByte(s, 8);
                //var x = (TarFileType)b;
                //return x;
            }
        }

        public static string ToString(this byte[] input, int index, int length)
        {
            if (input == null || input.Length == 0)
                return null;
            else
            {
                string result = Encoding.ASCII.GetString(input, index, length)
                                                            .Trim('\0', ' ');
                if (result == string.Empty)
                    return null;
                else
                    return result;
            }
        }

        public static byte[] DecompressGZ(this byte[] input)
        {
            if (input == null || input.Length < 1)
                return null;

            using (MemoryStream compressedData = new MemoryStream(input))
            using (MemoryStream decompressedData = new MemoryStream())
            {
                using (GZipStream deflateDecompress =
                                    new GZipStream(compressedData,
                                                   CompressionMode.Decompress,
                                                   true))
                {
                    byte[] buffer = new byte[1024];
                    int bufferLen;
                    do
                    {
                        bufferLen = deflateDecompress.Read(buffer,
                                                           0,
                                                           buffer.Length);
                        if (bufferLen > 0)
                            decompressedData.Write(buffer, 0, bufferLen);
                    } while (bufferLen > 0);
                }
                return decompressedData.ToArray();
            }
        }

        public static byte[] CompressGZ(this byte[] input)
        {
            if (input == null || input.Length < 1)
                return null;

            using (MemoryStream rawDataStreamIn = new MemoryStream(input))
            using (MemoryStream compressedDataStreamOut = new MemoryStream())
            {
                using (GZipStream deflateCompress = new GZipStream(
                                                    compressedDataStreamOut,
                                                    CompressionMode.Compress,
                                                    true))
                {
                    byte[] buffer = new byte[1024];
                    int bufferLen;
                    do
                    {
                        bufferLen = rawDataStreamIn.Read(buffer,
                                                         0,
                                                        buffer.Length);
                        if (bufferLen > 0)
                            deflateCompress.Write(buffer, 0, bufferLen);
                    } while (bufferLen > 0);
                }
                return compressedDataStreamOut.ToArray();
            }
        }
    }
}
