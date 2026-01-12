using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using WhitedUS.Common.Graphics.Exif;

namespace WhitedUS.PhotoStore.Services
{
    public class ImageScaler
    {
        public Stream Resize(Stream stream, string mimeType, ref byte? factor)
        {
            var ms = new MemoryStream();
            int width, height;

            using (var bitmap = new Bitmap(stream))
            {
                this.AutoRotate(bitmap);
                //Note: Auto Rotate

                var maxSize = Math.Max(bitmap.Width, bitmap.Height);
                var currentFactor = (byte)Math.Ceiling(Math.Log(maxSize, 2));
                factor = Math.Min(factor ?? 255, currentFactor);

                var offset = Math.Min(Math.Max(currentFactor - (factor ?? currentFactor), 0), currentFactor);
                width = Math.Max(bitmap.Width >> offset, 1);
                height = Math.Max(bitmap.Height >> offset, 1);

                using (var resized = new Bitmap(width, height, PixelFormat.Format32bppArgb))
                {
                    resized.SetResolution(bitmap.HorizontalResolution, bitmap.VerticalResolution);
                    using (var graphic = Graphics.FromImage(resized))
                    {
                        graphic.InterpolationMode = InterpolationMode.HighQualityBicubic;
                        graphic.DrawImage(bitmap,
                            new Rectangle(0, 0, resized.Width, resized.Height),
                            new Rectangle(0, 0, bitmap.Width, bitmap.Height),
                            GraphicsUnit.Pixel);
                    }
                    resized.Save(ms, this.GetCodec(this.GetFormat(mimeType)), this.GetParameters());
                }
            }

            ms.Position = 0;
            return ms;
        }

        private void AutoRotate(Bitmap bitmap)
        {
            var exifData = ExifData.CreateInstance(bitmap);
            if (exifData != null &&
                exifData.Orientation.HasValue &&
                exifData.Orientation.Value !=
                        OrientationType.LeftTop &&
                bitmap.Width > bitmap.Height
                )
            {
                if (exifData.Orientation.Value == OrientationType.LeftBottom)
                    bitmap.RotateFlip(RotateFlipType.Rotate270FlipNone);
                else if (exifData.Orientation.Value == OrientationType.RightTop)
                    bitmap.RotateFlip(RotateFlipType.Rotate90FlipNone);
            }
        }

        private ImageFormat GetFormat(string mimeType)
        {
            switch (mimeType)
            {
                case "image/png":
                    return ImageFormat.Png;

                case "image/x-raw":
                case "image/jpeg":
                default:
                    return ImageFormat.Jpeg;
            }
        }

        private ImageCodecInfo GetCodec(ImageFormat imageFormat)
        {
            return ImageCodecInfo.GetImageEncoders()
                                 .FirstOrDefault(c => c.FormatID == (imageFormat ?? ImageFormat.Jpeg).Guid);
        }
        private EncoderParameters GetParameters(long quality = 85L)
        {
            var encoderParameters = new EncoderParameters(1);
            encoderParameters.Param[0] = new EncoderParameter(Encoder.Quality, quality);
            return encoderParameters;
        }
    }
}
