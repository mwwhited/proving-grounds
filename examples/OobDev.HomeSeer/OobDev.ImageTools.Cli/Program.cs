using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using OobDev.ImageTools.MultiScaleImages;
using System.IO;
using System.Drawing;
using OobDev.ImageTools.Barcodes;
using System.Drawing.Imaging;
using OobDev.ImageTools.PngPacker;

namespace OobDev.ImageTools.Cli
{
    class Program
    {
        static void Main(string[] args)
        {
            Program.PngPackTest();
        }

        private static void PngPackTest()
        {
            var testFile = @"DSC_4668.jpg";
            var testBuffer = File.ReadAllBytes(testFile);
            var pngPack = new PngPack();

            var outBuffer = pngPack.Pack(testBuffer);
            var outFile = Path.ChangeExtension(testFile, ".png");
            File.WriteAllBytes(outFile, outBuffer);

            var outBuffer2 = pngPack.Unpack(outBuffer);
            var outFile2 = Path.ChangeExtension(testFile, ".jpeg");
            File.WriteAllBytes(outFile2, outBuffer2);
        }

        private static void CreateBarcode()
        {
            var code39 = new Code39();
            using (var bmp = code39.EncodeStandard("HELLO"))
            {
                bmp.Save("code39.EncodeStandard.png", ImageFormat.Png);
            }
            using (var bmp = code39.EncodeFullAscii("Hello World!"))
            {
                bmp.Save("code39.EncodeFullAscii.png", ImageFormat.Png);
            }

            {
                var codes = new[] {
                "ABCDEFGHIJ",
                "KLMNOPQRST",
                "UVWXYZ0123",
                "456789 -$%",
                "./+",
            };
                using (var set = new Bitmap((codes[0].Length + 2) * 16, codes.Length * 16))
                using (var graph = Graphics.FromImage(set))
                {
                    foreach (var item in codes.Select((v, i) => new { v, i }))
                        using (var bmp = code39.EncodeStandard(item.v))
                        {
                            graph.DrawImage(bmp, new Point(0, item.i * 16));
                        }
                    set.Save("code39.Test.png", ImageFormat.Png);
                }
            }
            {
                var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -$%./+";
                var codes = alphabet.Select(c => "" + c).ToArray();
                using (var set = new Bitmap(((codes[0].Length + 2) * 16) + 32, codes.Length * 16))
                using (var graph = Graphics.FromImage(set))
                {
                    graph.FillRectangle(Brushes.White, 0, 0, set.Width, set.Height);
                    foreach (var item in codes.Select((v, i) => new { v, i }))
                        using (var bmp = code39.EncodeStandard(item.v))
                        {
                            graph.DrawString(item.v, SystemFonts.DefaultFont, Brushes.Black, new Point(0, item.i * 16));
                            graph.DrawImage(bmp, new Point(32, item.i * 16));
                        }
                    set.Save("code39.Test2.png", ImageFormat.Png);
                }
            }
        }

        public static void TestTileCreate()
        {
            var sourceFile = "DSC_4668.JPG";

            using (var bitmap = new Bitmap(sourceFile))
            {
                var maxLevel = bitmap.GetMaxLevel();

                for (var level = 0; level <= maxLevel; level++)
                {
                    var dir = level.ToString();
                    if (!Directory.Exists(dir))
                        Directory.CreateDirectory(dir);

                    var tileCounts = bitmap.GetTileCount(level);

                    for (var x = 0; x < tileCounts.Width; x++)
                        for (var y = 0; y < tileCounts.Height; y++)
                        {
                            var file = Path.Combine(dir, $"{x:0000}_{y:0000}.jpg");
                            Console.Write(file);

                            if (!File.Exists(file))
                            {
                                Console.WriteLine(" Create");
                                var buffer = bitmap.GetTileAsBytes(level, x, y);
                                File.WriteAllBytes(file, buffer);
                            }
                            else
                            {
                                Console.WriteLine(" Skip");
                            }
                        }
                }
            }
        }
    }
}
