using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using WhitedUS.Libs.CompressedFiles.TarGZip;
using System.IO;
using System.Linq;

namespace WhitedUSLibsTests.CompressedFiles.TarGZip
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void TestMethod1()
        {
            var path = @"C:\Users\mwhited\Downloads";
            var files = Directory.EnumerateFiles(path, "*.tar.gz");
            var items = files.Select(f => new { file = f, path = Path.ChangeExtension(f, null) });
            foreach (var item in items)
                item.file.UnTarGZ(item.path);
        }
    }
}
