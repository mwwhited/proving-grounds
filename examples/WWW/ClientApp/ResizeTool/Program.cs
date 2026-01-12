using System;
using System.Collections.Generic;
using System.Linq;
//using System.Text;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;

namespace ResizeTool
{
    class Program
    {
        static void Main(string[] args)
        {
            string outDir = "outbound";
            string inDir = @"\\trojan\photos\Favorites";

            var outDirInfo = new DirectoryInfo(outDir);
            if (!outDirInfo.Exists)
                outDirInfo.Create();

            var inDirInfo = new DirectoryInfo(inDir);

            foreach (var fileInfo in inDirInfo.GetFiles())
            {
                try
                {
                    using (var bmp = Bitmap.FromFile(fileInfo.FullName))
                        bmp.Save(
                            Path.Combine(outDirInfo.FullName, 
                                         Path.GetFileName(fileInfo.FullName)
                                ), 
                            ImageFormat.Jpeg);
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }

        }
    }
}
