using System;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using WcfPhotoServicesTest.PhotoServiceReference;

namespace WcfPhotoServicesTest
{
    /// <summary>
    /// Summary description for PhotoServiceTests
    /// </summary>
    [TestClass]
    public class PhotoServiceTests
    {
        public PhotoServiceTests()
        {
            //
            // TODO: Add constructor logic here
            //
        }

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
        // You can use the following additional attributes as you write your tests:
        //
        // Use ClassInitialize to run code before running the first test in the class
        // [ClassInitialize()]
        // public static void MyClassInitialize(TestContext testContext) { }
        //
        // Use ClassCleanup to run code after all tests in a class have run
        // [ClassCleanup()]
        // public static void MyClassCleanup() { }
        //
        // Use TestInitialize to run code before running each test 
        // [TestInitialize()]
        // public void MyTestInitialize() { }
        //
        // Use TestCleanup to run code after each test has run
        // [TestCleanup()]
        // public void MyTestCleanup() { }
        //
        #endregion

        [TestMethod]
        public void TestMethod1()
        {
            var client = new PhotoServiceContractClient();
            Assert.IsTrue(client.GetDirectories(null).Length > 0, "Root is Empty");
            Assert.IsTrue(client.GetDirectories("2008").Length > 0, "2008 is Empty");
            Assert.IsTrue(client.GetPhotoNames(@"2008\11022008_Blacklick").Length > 0, "Blacklick is Empty");
            Assert.IsTrue(client.GetImageResized("508f54d361619cc46d33968f8eac9a11", @"2008\11022008_Blacklick", 200, 200).Length > 0, "Photo Missing");           
        }
    }
}
