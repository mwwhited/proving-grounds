using System;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using WhitedUS.Services.SNTP;

namespace WhitedUSServicesTests
{


    /// <summary>
    ///This is a test class for SNTPServiceTest and is intended
    ///to contain all SNTPServiceTest Unit Tests
    ///</summary>
    [TestClass()]
    public class SNTPServiceTest
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


        ///// <summary>
        /////A test for ServerStart
        /////</summary>
        //[TestMethod()]
        //public void ServerStartTest()
        //{
        //    SNTPService.ServerStart();
        //    Assert.Inconclusive("A method that does not return a value cannot be verified.");
        //}

        [TestMethod()]
        public void TestConversions()
        {
            //http://www.faqs.org/rfcs/rfc958.html

            var ntpReq = Convert.FromBase64String("2QAK+gAAI6gACTSAAAAAAM05qdpAF5fMAAAAAAAAAAAAAAAAAAAAAM05r9Fr7BcU");
            var timeStampBa = new byte[8];
            Array.Copy(ntpReq, 40, timeStampBa, 0, 8);            
            Array.Reverse(timeStampBa);

            var fracPart = (BitConverter.ToUInt32(timeStampBa, 0)) / 0x418937;
            var intPart = BitConverter.ToUInt32(timeStampBa, 4);
            var nTime2 = new DateTime(1900, 1, 1).AddSeconds(intPart);
            var nTime3 = nTime2.AddMilliseconds(fracPart);    
        }
    }
}
