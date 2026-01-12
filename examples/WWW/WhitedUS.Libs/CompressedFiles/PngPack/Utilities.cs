using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;

namespace WhitedUS.Libs.CompressedFiles.PngPack
{
    public class Utilities
    {
        public static void PackPng(string unpackedFile, string packedFile)
        {
            if (string.IsNullOrEmpty(unpackedFile))
                throw new ArgumentNullException("unpackedFile");

            if (string.IsNullOrEmpty(packedFile))
                throw new ArgumentNullException("packedFile");

            byte[] dataBuffer = File.ReadAllBytes(unpackedFile);
            byte[] dataBufferLength = BitConverter.GetBytes(dataBuffer.Length);
            int width = (int)Math.Sqrt((dataBuffer.Length + 
                                        dataBufferLength.Length) / 4);

            int x = 0, y = 0;

            using (MemoryStream ms = new MemoryStream())
            using (Bitmap bmp = new Bitmap(width, 
                                           width + 1, 
                                           PixelFormat.Format32bppArgb))
            {
                ms.Write(dataBufferLength, 0, dataBufferLength.Length);
                ms.Write(dataBuffer, 0, dataBuffer.Length);

                ms.Seek(0, SeekOrigin.Begin);

                byte[] littleBuffer = new byte[4];
                int littleBufferLength = 0;

                while (true)
                {
                    littleBufferLength = ms.Read(littleBuffer, 
                                                 0, 
                                                 dataBufferLength.Length);

                    bmp.SetPixel(x, y, Color.FromArgb(
                        littleBuffer[0],
                        littleBuffer[1],
                        littleBuffer[2],
                        littleBuffer[3]));

                    if (littleBufferLength <= 0)
                        break;

                    x++;
                    if (x >= bmp.Width)
                    {
                        x = 0;
                        y++;
                        if (y >= bmp.Height)
                            throw new OverflowException();
                    }
                }

                bmp.Save(packedFile, ImageFormat.Png);
            }
        }

        public static void UnpackPng(string packedFile, string unpackedFile)
        {
            if (string.IsNullOrEmpty(unpackedFile))
                throw new ArgumentNullException("unpackedFile");

            if (string.IsNullOrEmpty(packedFile))
                throw new ArgumentNullException("packedFile");

            int x = 0, y = 0, dataLength = 0;

            using (MemoryStream ms = new MemoryStream())
            using (Bitmap bmp = new Bitmap(packedFile))
            {
                byte[] littleBuffer = new byte[4];
                int littleBufferLength = 0;

                Color pixelData = bmp.GetPixel(x, y);
                dataLength = BitConverter.ToInt32(new byte[]{
                    pixelData.A,
                    pixelData.R,
                    pixelData.G,
                    pixelData.B,
                }, 0);
                x++;

                while (true)
                {
                    pixelData = bmp.GetPixel(x, y);

                    littleBuffer[0] = pixelData.A;
                    littleBuffer[1] = pixelData.R;
                    littleBuffer[2] = pixelData.G;
                    littleBuffer[3] = pixelData.B;

                    ms.Write(littleBuffer, 
                             0, 
                             littleBufferLength < dataLength 
                                ? littleBuffer.Length 
                                : littleBufferLength - dataLength);

                    if (littleBufferLength >= dataLength)
                        break;

                    littleBufferLength += 4;

                    x++;
                    if (x >= bmp.Width)
                    {
                        x = 0;
                        y++;
                        if (y >= bmp.Height)
                            throw new OverflowException();
                    }
                }

                File.WriteAllBytes(unpackedFile, ms.ToArray());
            }
        }
    }
}
