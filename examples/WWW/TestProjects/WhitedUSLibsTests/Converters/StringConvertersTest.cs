using WhitedUS.Libs.Converters;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Text;

namespace WhitedUSLibsTests.Converters
{
    
    
    /// <summary>
    ///This is a test class for StringConvertersTest and is intended
    ///to contain all StringConvertersTest Unit Tests
    ///</summary>
    [TestClass()]
    public class StringConvertersTest
    {


        private TestContext testContextInstance;

        /// <summary>
        ///Gets or sets the test context which provides
        ///information about and functionality for the current test run.
        ///</summary>
        public TestContext TestContext
        {
            get
            {
                return testContextInstance;
            }
            set
            {
                testContextInstance = value;
            }
        }

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
        ///A test for ToByteArray
        ///</summary>
        [TestMethod()]
        public void ToByteArrayTest1()
        {
            string _String = string.Empty; // TODO: Initialize to an appropriate value
            Encoding _Encoding = null; // TODO: Initialize to an appropriate value
            byte[] expected = null; // TODO: Initialize to an appropriate value
            byte[] actual;
            actual = StringConverters.ToByteArray(_String, _Encoding);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for ToByteArray
        ///</summary>
        [TestMethod()]
        public void ToByteArrayTest()
        {
            string _String = string.Empty; // TODO: Initialize to an appropriate value
            byte[] expected = null; // TODO: Initialize to an appropriate value
            byte[] actual;
            actual = StringConverters.ToByteArray(_String);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for SpeakAsync
        ///</summary>
        [TestMethod()]
        public void SpeakAsyncTest()
        {
            string _String = string.Empty; // TODO: Initialize to an appropriate value
            StringConverters.SpeakAsync(_String);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for Speak
        ///</summary>
        [TestMethod()]
        public void SpeakTest()
        {
            StringConverters.Speak("I am a computer hear me roar");
        }

        /// <summary>
        ///A test for RemoveAllWhitespace
        ///</summary>
        [TestMethod()]
        public void RemoveAllWhitespaceTest()
        {
            string _Input = string.Empty; // TODO: Initialize to an appropriate value
            string expected = string.Empty; // TODO: Initialize to an appropriate value
            string actual;
            actual = StringConverters.RemoveAllWhitespace(_Input);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for IsHexString
        ///</summary>
        [TestMethod()]
        public void IsHexStringTest()
        {
            string _Input = string.Empty; // TODO: Initialize to an appropriate value
            bool expected = false; // TODO: Initialize to an appropriate value
            bool actual;
            actual = StringConverters.IsHexString(_Input);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for IsBase64
        ///</summary>
        [TestMethod()]
        public void IsBase64Test()
        {
            string _Input = string.Empty; // TODO: Initialize to an appropriate value
            bool expected = false; // TODO: Initialize to an appropriate value
            bool actual;
            actual = StringConverters.IsBase64(_Input);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for HasWhitespace
        ///</summary>
        [TestMethod()]
        public void HasWhitespaceTest()
        {
            string _Input = string.Empty; // TODO: Initialize to an appropriate value
            bool expected = false; // TODO: Initialize to an appropriate value
            bool actual;
            actual = StringConverters.HasWhitespace(_Input);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for GetMD5HashBytes
        ///</summary>
        [TestMethod()]
        public void GetMD5HashBytesTest()
        {
            string buffer = string.Empty; // TODO: Initialize to an appropriate value
            byte[] expected = null; // TODO: Initialize to an appropriate value
            byte[] actual;
            actual = StringConverters.GetMD5HashBytes(buffer);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for GetMD5Hash
        ///</summary>
        [TestMethod()]
        public void GetMD5HashTest()
        {
            string buffer = string.Empty; // TODO: Initialize to an appropriate value
            string expected = string.Empty; // TODO: Initialize to an appropriate value
            string actual;
            actual = StringConverters.GetMD5Hash(buffer);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for FromHexString
        ///</summary>
        [TestMethod()]
        public void FromHexStringTest()
        {
            string _String = string.Empty; // TODO: Initialize to an appropriate value
            byte[] expected = null; // TODO: Initialize to an appropriate value
            byte[] actual;
            actual = StringConverters.FromHexString(_String);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for FromBase64
        ///</summary>
        [TestMethod()]
        public void FromBase64Test()
        {
            string _String = string.Empty; // TODO: Initialize to an appropriate value
            byte[] expected = null; // TODO: Initialize to an appropriate value
            byte[] actual;
            actual = StringConverters.FromBase64(_String);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }
    }
}
