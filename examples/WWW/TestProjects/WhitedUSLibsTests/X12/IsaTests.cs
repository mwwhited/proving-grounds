using System;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using WhitedUS.Libs.X12;

namespace WhitedUSLibsTests.X12
{
    /// <summary>
    /// Summary description for IsaTests
    /// </summary>
    [TestClass]
    public class IsaTests
    {
        public IsaTests()
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

        /// <summary>
        ///A test for Isa Constructor
        ///</summary>
        [TestMethod()]
        public void IsaConstructorTest()
        {
            string isaSegment = "ISA*00*1234567890*00*0987654321*ZZ*123456789012345*ZZ*098765432109876*YYMMDD*HHMM*U*00401*123456789*1*1*>~";
            Isa target = new Isa(isaSegment);

            Assert.AreEqual(target.Seperators.Element, '*');
            Assert.AreEqual(target.Seperators.Segment, '~');
            Assert.AreEqual(target.Seperators.SubElement, '>');
            Assert.AreEqual(target.ToString(), isaSegment);
        }
    }
}
