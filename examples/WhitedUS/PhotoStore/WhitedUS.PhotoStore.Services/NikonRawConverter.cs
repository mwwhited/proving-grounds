using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Windows.Media.Imaging;

namespace WhitedUS.PhotoStore.Services
{
    public class NikonRawConverter
    {
        public Stream ToJpeg(Stream instream)
        {
            var decoder = BitmapDecoder.Create(instream, BitmapCreateOptions.DelayCreation, BitmapCacheOption.None);
            var encoder = new JpegBitmapEncoder();

            if (decoder.Metadata != null)
                encoder.Metadata = decoder.Metadata;

            foreach (var frame in decoder.Frames)
                encoder.Frames.Add(frame);

            var ms = new MemoryStream();
            encoder.Save(ms);
            ms.Position = 0;
            return ms;
        }
    }
}
