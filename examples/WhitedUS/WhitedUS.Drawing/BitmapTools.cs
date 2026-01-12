using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Text;
using WhitedUS.Drawing.Exif;

namespace WhitedUS.Drawing
{
    public static class BitmapTools
    {
        public static byte[] Recompress(this byte[] data, int compression, ImageFormat format)
        {
            using (var inputStream = new MemoryStream(data))
            using (var bitmap = new Bitmap(inputStream))
            using (var outputStream = new MemoryStream())
            using (var codecParams = new EncoderParameters(1))
            using (codecParams.Param[0] = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, compression))
            {
                var encoders = ImageCodecInfo.GetImageEncoders();
                var encoder = encoders.Single(e => e.FormatID == format.Guid);

                bitmap.Save(outputStream, encoder, codecParams);

                var result = outputStream.ToArray();
                return result;
            }
        }

        public static byte[] Resize(this byte[] data, int maxSize)
        {
            using (var inputStream = new MemoryStream(data))
            using (var bitmap = new Bitmap(inputStream))
            {
                var scaleFrom = Math.Max(bitmap.Width, bitmap.Height);

                if (scaleFrom <= maxSize)
                    return data;

                var scalar = (double)maxSize / (double)scaleFrom;
                var newHeight = (int)Math.Ceiling(scalar * bitmap.Height);
                var newWidth = (int)Math.Ceiling(scalar * bitmap.Width);

                using (var outputStream = new MemoryStream())
                using (var scaledBitmap = new Bitmap(newWidth, newHeight, bitmap.PixelFormat))
                using (var resized = Graphics.FromImage(scaledBitmap))
                {
                    resized.Clear(Color.Transparent);
                    resized.InterpolationMode = InterpolationMode.HighQualityBicubic;
                    resized.DrawImage(
                        bitmap,
                        new Rectangle(new Point(0, 0), scaledBitmap.Size),
                        new Rectangle(new Point(0, 0), bitmap.Size),
                        GraphicsUnit.Pixel
                        );

                    scaledBitmap.Save(outputStream, bitmap.RawFormat);

                    var result = outputStream.ToArray();
                    return result;
                }
            }
        }

        public static byte[] AutoRotate(this byte[] data)
        {
            using (var inputStream = new MemoryStream(data))
            using (var bitmap = new Bitmap(inputStream))
            {
                var exif = ExifData.CreateInstance(bitmap);

                if (exif != null &&
                             exif.Orientation.HasValue &&
                             exif.Orientation.Value !=
                                     OrientationType.LeftTop &&
                             bitmap.Width > bitmap.Height
                             )
                {
                    var format = bitmap.RawFormat;

                    if (exif.Orientation.Value == OrientationType.LeftBottom)
                        bitmap.RotateFlip(RotateFlipType.Rotate270FlipNone);
                    else if (exif.Orientation.Value == OrientationType.RightTop)
                        bitmap.RotateFlip(RotateFlipType.Rotate90FlipNone);

                    using (var outputStream = new MemoryStream())
                    {
                        bitmap.Save(outputStream, format);
                        return outputStream.ToArray();
                    }
                }

                return data;
            }
        }

        public static ExifData GetExifData(this byte[] data)
        {
               using (var inputStream = new MemoryStream(data))
               using (var bitmap = new Bitmap(inputStream))
               {
                   return ExifData.CreateInstance(bitmap);
               }
        }
    }
}

//using (Bitmap scaledBitmap = new Bitmap(scaleWidth, scaleHeight, existing.PixelFormat))
//                                 {
//                                     Graphics resizeGraphic = Graphics.FromImage(scaledBitmap);
//                                     resizeGraphic.Clear(Color.Transparent);
//                                     resizeGraphic.InterpolationMode = InterpolationMode.HighQualityBicubic;
//                                     resizeGraphic.DrawImage(
//                                         existing,
//                                         new Rectangle(0, 0, scaleWidth, scaleHeight),
//                                         new Rectangle(0, 0, existing.Width, existing.Height),
//                                         GraphicsUnit.Pixel
//                                         );
