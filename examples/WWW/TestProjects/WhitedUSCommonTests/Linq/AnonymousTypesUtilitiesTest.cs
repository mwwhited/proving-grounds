using WhitedUS.Common.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace WhitedUSCommonTests.Linq
{   
    /// <summary>
    ///This is a test class for AnonymousTypesUtilitiesTest and is intended
    ///to contain all AnonymousTypesUtilitiesTest Unit Tests
    ///</summary>
    [TestClass()]
    public class AnonymousTypesUtilitiesTest
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
        ///A test for IsAnonymous
        ///</summary>
        [TestMethod()]
        public void IsAnonymousTest()
        {
            Assert.IsTrue(new { Test = "" }.IsAnonymous(), "Anonymous Type with Property");
            Assert.IsTrue(new { }.IsAnonymous(), "Anonymous Type without Properties");
            Assert.IsFalse(((object)null).IsAnonymous(), "Null Object");
            Assert.IsFalse(((int?)null).IsAnonymous(), "Nullable Int as null");
            Assert.IsFalse(((string)null).IsAnonymous(), "Null string");
            Assert.IsFalse("".IsAnonymous(), "empty string");
            Assert.IsFalse(((int?)5).IsAnonymous(), "Nullable Int with value");
            Assert.IsFalse(1.IsAnonymous(), "Int");
        }
    }
}
