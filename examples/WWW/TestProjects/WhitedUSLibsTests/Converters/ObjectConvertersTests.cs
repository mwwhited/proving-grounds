//using System.Text;
//using Microsoft.VisualStudio.TestTools.UnitTesting;
//using WhitedUS.Libs.Converters;
//using System.IO;


//namespace WhitedUSLibsTests.Converters
//{
//    [TestClass()]
//    public class ObjectConvertersTests
//    {
//        public TestContext TestContext { get; set; }

//        /// <summary>
//        ///A test for IsAnonymousType
//        ///</summary>
//        [TestMethod()]
//        public void IsAnonymousTypeTest()
//        {
//            var testObj = new { };
//            var result = testObj.IsAnonymousType();
//            Assert.IsTrue(result);

//            var testObj2 = "hello";
//            var result2 = testObj2.IsAnonymousType();
//            Assert.IsFalse(result2);
//        }

//        [TestMethod()]
//        public void ToXmlTest()
//        {
//            var testObj = new { Prop1 = "Hello World!!!" };
//            var result = testObj.ToXml();
//            Assert.AreEqual(result, "<object>\r\n  <Prop1>\r\n    <string>Hello World!!!</string>\r\n  </Prop1>\r\n</object>");

//            var testObj2 = "hello";
//            var result2 = testObj2.ToXml();
//            Assert.AreEqual(result2, "<?xml version=\"1.0\"?>\r\n<string>hello</string>");

//            var testObjs = new
//            {
//                Prop = new[] {
//                new { Prop = "Hello"}
//            }
//            };
//            using (var ms = new MemoryStream())
//            {
//                testObjs.WriteXml(ms);
//                var str = Encoding.UTF8.GetString(ms.ToArray());
//            }

//        }
//    }
//}
