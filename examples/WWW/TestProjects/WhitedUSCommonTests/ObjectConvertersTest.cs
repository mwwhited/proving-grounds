using WhitedUS.Libs.Converters;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Collections.ObjectModel;
using System.Xml.Linq;
using System.IO;
using System.Xml;
using System;
using System.Text;

namespace WhitedUSCommonTests
{


    /// <summary>
    ///This is a test class for ObjectConvertersTest and is intended
    ///to contain all ObjectConvertersTest Unit Tests
    ///</summary>
    [TestClass()]
    public class ObjectConvertersTest
    {
        /// <summary>
        ///Gets or sets the test context which provides
        ///information about and functionality for the current test run.
        ///</summary>
        public TestContext TestContext { get; set; }

        #region Additional test attributes
        // 
        //You can use the following additional attributes as you write your tests:
        //
        //Use ClassInitialize to run code before running the first test in the class
        //[ClassInitialize()]
        //public static void MyClassInitialize(TestContext testContext)
        //{
        //}
        //
        //Use ClassCleanup to run code after all tests in a class have run
        //[ClassCleanup()]
        //public static void MyClassCleanup()
        //{
        //}
        //
        //Use TestInitialize to run code before running each test
        //[TestInitialize()]
        //public void MyTestInitialize()
        //{
        //}
        //
        //Use TestCleanup to run code after each test has run
        //[TestCleanup()]
        //public void MyTestCleanup()
        //{
        //}
        //
        #endregion


        /// <summary>
        ///A test for WriteXml
        ///</summary>
        [TestMethod()]
        public void WriteXmlTest()
        {
            object input = new { test = "hi", test2 = new { hi = "up", there = "sdfsdfahga3", other = 5, up = DateTime.Now } };
            MemoryStream stream = new MemoryStream();
            input.WriteXml(stream, "test");

            var test = Encoding.UTF8.GetString(stream.ToArray());

            var lc1 = new LoopCheck() { Name = "Hi" };
            var lc2 = new LoopCheck() { Name = "Bye" };
            var lc3 = new LoopCheck() { Name = "Root", Child = lc1, Child2 = lc2 };
            lc1.Child = lc2;
            lc1.Child2 = lc2;
            lc2.Child2 = lc1;
            lc2.Child = lc1;
            stream = new MemoryStream();
            lc3.WriteXml(stream);

            test = Encoding.UTF8.GetString(stream.ToArray());

            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for ToXNode
        ///</summary>
        [TestMethod()]
        public void ToXNodeTest()
        {
            object input = null; // TODO: Initialize to an appropriate value
            XNode expected = null; // TODO: Initialize to an appropriate value
            XNode actual;
            actual = ObjectConverters.ToXNode(input);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for ToXml
        ///</summary>
        [TestMethod()]
        public void ToXmlTest1()
        {
            object input = null; // TODO: Initialize to an appropriate value
            string expected = string.Empty; // TODO: Initialize to an appropriate value
            string actual;
            actual = ObjectConverters.ToXml(input);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for SerializeXml
        ///</summary>
        [TestMethod()]
        public void SerializeXmlTest()
        {
            object input = null; // TODO: Initialize to an appropriate value
            Stream stream = null; // TODO: Initialize to an appropriate value
            ObjectConverters.SerializeXml(input, stream);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for SerializeDataContact
        ///</summary>
        [TestMethod()]
        public void SerializeDataContactTest()
        {
            object input = null; // TODO: Initialize to an appropriate value
            Stream stream = null; // TODO: Initialize to an appropriate value
            ObjectConverters.SerializeDataContact(input, stream);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for IsExtendedPrimitive
        ///</summary>
        [TestMethod()]
        public void IsExtendedPrimitiveTest()
        {
            object input = null; // TODO: Initialize to an appropriate value
            bool expected = false; // TODO: Initialize to an appropriate value
            bool actual;
            actual = ObjectConverters.IsExtendedPrimitive(input);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for HasDataContract
        ///</summary>
        [TestMethod()]
        public void HasDataContractTest()
        {
            object input = null; // TODO: Initialize to an appropriate value
            bool expected = false; // TODO: Initialize to an appropriate value
            bool actual;
            actual = ObjectConverters.HasDataContract(input);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for CanSerializeXml
        ///</summary>
        [TestMethod()]
        public void CanSerializeXmlTest()
        {
            object input = null; // TODO: Initialize to an appropriate value
            bool expected = false; // TODO: Initialize to an appropriate value
            bool actual;
            actual = ObjectConverters.CanSerializeXml(input);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for ToXml
        ///</summary>
        [TestMethod()]
        public void ToXmlTest()
        {
            var a = "hi".ToXml();
            var a2 = new { test = "hi" }.ToXml();
            var a4 = new { test = "hi", test2 = new { hi = "up" } }.ToXml();
            var a5 = new { test = "hi", test2 = new { hi = "up", there = "sdfsdfahga3", other = 5, up = DateTime.Now } }.ToXml();
            var a6 = new { test = "hi", test2 = new { hi = "up", there = "sdfsdfahga3", other = 5, up = DateTime.Now } }.ToXml("newRoot");

            var lc1 = new LoopCheck() { Name = "Hi" };
            var lc2 = new LoopCheck() { Name = "Bye" };
            //var a7 = lc1.ToXml();
            lc1.Child = lc1;
            lc2.Child2 = lc1;
            lc2.Child = lc2;
            lc1.Child2 = lc2;
            var a8 = lc1.ToXml();

            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        public class LoopCheck
        {
            public string Name { get; set; }
            public LoopCheck Child { get; set; }
            public LoopCheck Child2 { get; set; }
            public override string ToString()
            {
                return string.IsNullOrEmpty(this.Name) ? base.ToString() : this.Name;
            }
        }
    }
}
