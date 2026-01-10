using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace OobDev.Tools.Csv.Tests
{
    [TestClass]
    public class CsvWriterTest
    {
        [TestMethod]
        public void WriteTo_Test()
        {
            var source = Enumerable.Range(0, 5)
                                   .Select(r => new
                                   {
                                       Col0 = r,
                                       Col1 = r * 2,
                                       Col2 = r * r,
                                   });

            using (var stream = new MemoryStream())
            {
                source.WriteAsCsvTo(stream);
                stream.Position = 0;
                using (var reader = new StreamReader(stream))
                {
                    var result = reader.ReadToEnd();

                    var expected = @"""Col0"",""Col1"",""Col2""
""0"",""0"",""0""
""1"",""2"",""1""
""2"",""4"",""4""
""3"",""6"",""9""
""4"",""8"",""16""
";
                    Assert.AreEqual(result, expected);
                }
            }
        }
        [TestMethod]
        public void WriteTo_Test_FixUnderscore()
        {
            var source = new[] {
                new {
                    Col_0 = 0,
                    Col_1 = 0 * 2,
                    Col_2 = 0 * 0,
                }
            }.Skip(1);

            using (var stream = new MemoryStream())
            {
                source.WriteAsCsvTo(stream);
                stream.Position = 0;
                using (var reader = new StreamReader(stream))
                {
                    var result = reader.ReadToEnd();

                    var expected = @"""Col 0"",""Col 1"",""Col 2""
";
                    Assert.AreEqual(result, expected);
                }
            }
        }
        [TestMethod]
        public void WriteTo_Test_NoHeader()
        {
            var source = Enumerable.Range(0, 5)
                                   .Select(r => new
                                   {
                                       Col0 = r,
                                       Col1 = r * 2,
                                       Col2 = r * r,
                                   });

            using (var stream = new MemoryStream())
            {
                source.WriteAsCsvTo(stream, includeHeader: false);
                stream.Position = 0;
                using (var reader = new StreamReader(stream))
                {
                    var result = reader.ReadToEnd();

                    var expected = @"""0"",""0"",""0""
""1"",""2"",""1""
""2"",""4"",""4""
""3"",""6"",""9""
""4"",""8"",""16""
";
                    Assert.AreEqual(result, expected);
                }
            }
        }
        [TestMethod]
        public async Task WriteToAsync_Test()
        {
            var source = Enumerable.Range(0, 5)
                                   .Select(r => new
                                   {
                                       Col0 = r,
                                       Col1 = r * 2,
                                       Col2 = r * r,
                                   });

            using (var stream = new MemoryStream())
            {
                await source.WriteAsCsvToAsync(stream);
                stream.Position = 0;
                using (var reader = new StreamReader(stream))
                {
                    var result = reader.ReadToEnd();

                    var expected = @"""Col0"",""Col1"",""Col2""
""0"",""0"",""0""
""1"",""2"",""1""
""2"",""4"",""4""
""3"",""6"",""9""
""4"",""8"",""16""
";
                    Assert.AreEqual(result, expected);
                }
            }
        }
        [TestMethod]
        public async Task WriteToAsync_Test_NoHeader()
        {
            var source = Enumerable.Range(0, 5)
                                   .Select(r => new
                                   {
                                       Col0 = r,
                                       Col1 = r * 2,
                                       Col2 = r * r,
                                   });

            using (var stream = new MemoryStream())
            {
                await source.WriteAsCsvToAsync(stream, includeHeader: false);
                stream.Position = 0;
                using (var reader = new StreamReader(stream))
                {
                    var result = reader.ReadToEnd();

                    var expected = @"""0"",""0"",""0""
""1"",""2"",""1""
""2"",""4"",""4""
""3"",""6"",""9""
""4"",""8"",""16""
";
                    Assert.AreEqual(result, expected);
                }
            }
        }
        [TestMethod]
        public async Task WriteToAsync_Test_FixUnderscore()
        {
            var source = new[] {
                new {
                    Col_0 = 0,
                    Col_1 = 0 * 2,
                    Col_2 = 0 * 0,
                }
            }.Skip(1);

            using (var stream = new MemoryStream())
            {
                await source.WriteAsCsvToAsync(stream);
                stream.Position = 0;
                using (var reader = new StreamReader(stream))
                {
                    var result = reader.ReadToEnd();

                    var expected = @"""Col 0"",""Col 1"",""Col 2""
";
                    Assert.AreEqual(result, expected);
                }
            }
        }
    }
}
