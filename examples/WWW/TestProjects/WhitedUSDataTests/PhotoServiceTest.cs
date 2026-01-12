using WhitedUS.Data.PhotoService;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Collections.Generic;
namespace WhitedUSDataTests
{


    /// <summary>
    ///This is a test class for PhotoServiceTest and is intended
    ///to contain all PhotoServiceTest Unit Tests
    ///</summary>
    [TestClass()]
    public class PhotoServiceTest
    {
        private TestContext testContextInstance;

        /// <summary>
        ///Gets or sets the test context which provides
        ///information about and functionality for the current test run.
        ///</summary>
        public TestContext TestContext
        {
            get { return testContextInstance; }
            set { testContextInstance = value; }
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
        ///A test for GetPhotoNames
        ///</summary>
        [TestMethod()]
        public void GetPhotoNamesTest()
        {
            PhotoService target = new PhotoService();
            string path = @"2008\11022008_Blacklick";
            KeyValuePair<string, string>[] actual;
            actual = target.GetPhotoNames(path);
            Assert.IsTrue(actual.Length > 0);
        }

        /// <summary>
        ///A test for GetDirectories
        ///</summary>
        [TestMethod()]
        public void GetDirectoriesTest()
        {
            PhotoService target = new PhotoService();
            string basePath = "2008";
            string[] actual;
            actual = target.GetDirectories(basePath);
            Assert.IsTrue(actual.Length > 0);
        }

        /// <summary>
        ///A test for GetImageResized
        ///</summary>
        [TestMethod()]
        public void GetImageResizedTest()
        {
            //bfe4a713131c3b877eb6990c5c652e88
            PhotoService target = new PhotoService();
            string hashKey = "bfe4a713131c3b877eb6990c5c652e88";
            string path = @"2008\11022008_Blacklick";
            byte[] actual;
            actual = target.GetImageResized(hashKey, path, 200, 200);
            Assert.IsTrue(actual.Length > 0);
        }

        /// <summary>
        ///A test for GetImage
        ///</summary>
        [TestMethod()]
        public void GetImageTest()
        {
            PhotoService target = new PhotoService();
            string hashKey = "bfe4a713131c3b877eb6990c5c652e88";
            string path = @"2008\11022008_Blacklick";
            byte[] actual;
            actual = target.GetImage(hashKey, path);
            Assert.IsTrue(actual.Length > 0);
        }

        ///// <summary>
        /////A test for PhotoService Constructor
        /////</summary>
        //[TestMethod()]
        //public void PhotoServiceConstructorTest()
        //{
        //    PhotoService target = new PhotoService();
        //    Assert.Inconclusive("TODO: Implement code to verify target");
        //}
    }
}
