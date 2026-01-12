using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.IO.Compression;

namespace WhitedUS.Libs.CompressedFiles.PKZip
{
    public static class Utilities
    {
        public static void UnZip(this string inFile, string outPath)
        {
            byte[] zipFileContents = File.ReadAllBytes(inFile);
            int offset = 0;
            while (true)
            {
                LocalFileHeader localFileHeader = zipFileContents;
                if (localFileHeader.Signature != 0x04034b50)
                    break;

                offset += localFileHeader.HeaderSize;
                if (localFileHeader.CompressionMethod == 
                        CompressionMethodType.Deflate)
                {
                    var fileContent = new byte[localFileHeader.CompressedSize];
                    Array.Copy(zipFileContents, 
                               offset, 
                               fileContent, 
                               0, 
                               fileContent.Length);
                    File.WriteAllBytes(Path.Combine(outPath, 
                                                    localFileHeader.FileName), 
                                       fileContent.DecompressDeflate());
                }
                offset += zipFileContents.Length;


                byte[] newBuffer = new byte[zipFileContents.Length - offset];
                Array.Copy(zipFileContents, 
                           offset, 
                           newBuffer, 
                           0, 
                           newBuffer.Length);
                zipFileContents = newBuffer;
                offset = 0;
            }
        }

        public static byte[] DecompressDeflate(this byte[] input)
        {
            if (input == null || input.Length < 1)
                return null;

            using (var compressedData = new MemoryStream(input))
            using (var decompressedData = new MemoryStream())
            {
                using (var deflateDecompress = new DeflateStream(
                                                    compressedData, 
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

        public static byte[] CompressDeflate(this byte[] input)
        {
            if (input == null || input.Length < 1)
                return null;

            using (MemoryStream rawDataStreamIn = new MemoryStream(input))
            using (MemoryStream compressedDataStreamOut = new MemoryStream())
            {
                using (DeflateStream deflateCompress = new DeflateStream(
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
