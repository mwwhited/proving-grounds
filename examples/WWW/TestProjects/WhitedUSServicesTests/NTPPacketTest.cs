using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using WhitedUS.Services.SNTP;

namespace WhitedUSServicesTests
{
    
    
    /// <summary>
    ///This is a test class for NTPPacketTest and is intended
    ///to contain all NTPPacketTest Unit Tests
    ///</summary>
    [TestClass()]
    public class NTPPacketTest
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
        ///A test for ToBinary
        ///</summary>
        [TestMethod()]
        public void ToBinaryTest()
        {
            NTPPacket target = NTPPacket.Create(Convert.FromBase64String("2QAK+gAAI6gACTSAAAAAAM05qdo///+2AAAAAAAAAAAAAAAAAAAAAM05r9Frxqdz"));
            var expected                                               = "2QAK+gAAI6gACTSAAAAAAM05qdo///+2AAAAAAAAAAAAAAAAAAAAAM05r9Frxqdz";
            byte[] actual;
            actual = target.ToBinary();
            var result = Convert.ToBase64String(actual);
            Assert.AreEqual(expected, result);
        }

        /// <summary>
        ///A test for Create
        ///</summary>
        [TestMethod()]
        public void CreateTest()
        {
            byte[] packet = Convert.FromBase64String("2QAK+gAAI6gACTSAAAAAAM05qdpAF5fMAAAAAAAAAAAAAAAAAAAAAM05r9Fr7BcU");
            NTPPacket expected = null; // TODO: Initialize to an appropriate value
            NTPPacket actual;
            actual = NTPPacket.Create(packet);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }
    }
}
