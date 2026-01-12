using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using WhitedUS.PhotoStore.Services;

namespace WhitedUS.PhotoStore.TestHarnes
{
    class Program
    {
        static void Main(string[] args)
        {
            var filename = @"C:\ServerBackup\HomeServerBackup\Photos\2006\05112006_ducks\DSC_3262.NEF";
            var outFileFormatter = @"outfile_{0}.jpg";
            var scaler = new ImageScaler();
            var decoder = new NikonRawConverter();

            for (var factor = (byte)0; factor <= 13; factor++)
            {
                var c = (byte?)factor;
                using (var stream = new FileStream(filename, FileMode.Open))
                using (var converted = decoder.ToJpeg(stream))
                using (var scaled = scaler.Resize(converted, "image/jpeg", ref c))
                using (var outStream = new FileStream(string.Format(outFileFormatter, factor), FileMode.Create, FileAccess.Write))
                    scaled.CopyTo(outStream);
            }
        }
    }
}
