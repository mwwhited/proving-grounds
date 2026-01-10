using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using OobDev.Common;
using Microsoft.VisualStudio.TestTools.UnitTesting;
namespace OobDev.Common.Tests
{
    [TestClass()]
    public class Base32EncodingTests
    {
        [TestMethod()]
        public void ToBytesTest()
        {
            var tests = new[]{
                new {encoded="", decoded = "",},
                new {encoded="MY======", decoded ="f",},
                new {encoded="MZXQ====", decoded = "fo",},
                new {encoded="MZXW6===", decoded = "foo",},
                new {encoded="MZXW6YQ=", decoded = "foob",},
                new {encoded="MZXW6YTB", decoded = "fooba",},
                new {encoded="MZXW6YTBOI======", decoded = "foobar",},
            };

            foreach (var test in tests)
            {
                var bytes = Base32Encoding.ToBytes(test.encoded);
                var decoded = Encoding.ASCII.GetString(bytes);
                Assert.AreEqual(test.decoded, decoded);
            }
        }

        [TestMethod()]
        public void ToStringTest()
        {
            var tests = new[]{
                new {encoded="", decoded = "",},
                new {encoded="MY======", decoded ="f",},
                new {encoded="MZXQ====", decoded = "fo",},
                new {encoded="MZXW6===", decoded = "foo",},
                new {encoded="MZXW6YQ=", decoded = "foob",},
                new {encoded="MZXW6YTB", decoded = "fooba",},
                new {encoded="MZXW6YTBOI======", decoded = "foobar",},
            };

            foreach (var test in tests)
            {
                var buffer = Encoding.ASCII.GetBytes(test.decoded);
                var encoded = Base32Encoding.ToString(buffer);
                Assert.AreEqual(test.encoded, encoded);
            }
        }
    }
}
