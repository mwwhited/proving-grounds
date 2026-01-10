using System;
using System.Collections.Generic;
using System.Windows.Forms;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO.Compression;

namespace twoFold
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            using (OpenFileDialog odf = new OpenFileDialog())
            //using (OpenFileDialog odf2 = new OpenFileDialog())
            {
                if (odf.ShowDialog() == DialogResult.OK)
                {
                    byte[] inBuffer = File.ReadAllBytes(odf.FileName);
                    byte[] fileBuffer = Compress(inBuffer);

                    if (inBuffer.Length < fileBuffer.Length)
                        fileBuffer = inBuffer;
                    int length = fileBuffer.Length;
                    byte[] header = BitConverter.GetBytes(length);

                    int width = (int)Math.Sqrt((int)((length + header.Length) / 4)) + 1;

                    Bitmap newBmp = new Bitmap(width, width);

                    int x = 1, y = 0;
                    //newBmp.SetPixel(0, 0, Color.FromArgb(header[0] ^ 0x55, header[1] ^ 0xFF, header[2] ^ 0xAA, header[3]));
                    newBmp.SetPixel(0, 0, Color.FromArgb(header[0], header[1], header[2], header[3]));

                    for (int i = 0; i < fileBuffer.Length + 4; i += 4)
                    {
                        if (x >= width)
                        {
                            y++; 
                            x = 0;
                        }

                        Color dataColor = Color.FromArgb(
                            i >= fileBuffer.Length ? (byte)0 : fileBuffer[i], // ^ 0x55,
                            i + 1 >= fileBuffer.Length ? (byte)0 : fileBuffer[i + 1], // ^ 0xFF,
                            i + 2 >= fileBuffer.Length ? (byte)0 : fileBuffer[i + 2], // ^ 0xAA,
                            i + 3 >= fileBuffer.Length ? (byte)0 : fileBuffer[i + 3]
                            );

                        newBmp.SetPixel(x, y, dataColor);
                        x++;
                    }

                    newBmp.Save(odf.FileName + ".png", ImageFormat.Png);
                    newBmp.Dispose();

                    //===============================================================

                    List<byte> buffer = new List<byte>();
                    Bitmap check = new Bitmap(odf.FileName + ".png");
                    for (int cy = 0; cy < check.Height; cy++)
                        for (int cx = 0; cx < check.Width; cx++)
                        {
                            Color dataColor = check.GetPixel(cx, cy);

                            buffer.Add((byte)((byte)dataColor.A));// ^ (byte)0x55));
                            buffer.Add((byte)((byte)dataColor.R));// ^ (byte)0xFF));
                            buffer.Add((byte)((byte)dataColor.G));// ^ (byte)0xAA));
                            buffer.Add((byte)((byte)dataColor.B));// ^ (byte)0x00));
                        }

                    int bigSize = check.Height * check.Width;

                    byte[] outHeader = new byte[4];
                    Array.Copy(buffer.ToArray(), 0, outHeader, 0, outHeader.Length);
                    int fileLength = BitConverter.ToInt32(outHeader, 0);
                    byte[] outBuffer = new byte[fileLength];
                    Array.Copy(buffer.ToArray(), header.Length, outBuffer, 0, outBuffer.Length);

                    uint compressCheck = BitConverter.ToUInt32(outBuffer, 0);
                    if (compressCheck == 0x6007bded)
                    {
                        //File.WriteAllBytes(odf.FileName + ".comp", outBuffer);
                        File.WriteAllBytes(odf.FileName + ".dat", Decompress(outBuffer));
                    }
                    else
                        File.WriteAllBytes(odf.FileName + ".dat", outBuffer);
                }
            }
        }

        public static byte[] CompressGz(byte[] input)
        {
            if (input == null || input.Length < 1)
                return null;

            using (MemoryStream rawDataStreamIn = new MemoryStream(input))
            {
                using (MemoryStream compressedDataStreamOut = new MemoryStream())
                {
                    using (GZipStream deflateCompress = new GZipStream(compressedDataStreamOut, CompressionMode.Compress, true))
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

        public static byte[] DecompressGz(byte[] input)
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
    }
}