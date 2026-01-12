using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using WhitedUS.Libs.Xml.Xsl;

namespace WhitedUSLibsTests.Xml.Xsl
{
    /// <summary>
    /// Summary description for ExtensionObjectToolSetTest
    /// </summary>
    [TestClass]
    public class ExtensionObjectToolSetTest
    {
        public ExtensionObjectToolSetTest() { }

        /// <summary>
        ///Gets or sets the test context which provides
        ///information about and functionality for the current test run.
        ///</summary>
        public TestContext TestContext { get; set; }

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
        public void ExtensionObjectToolSet_ResolveNamespace()
        {
            {
                var extensionObjectToolSet = new ExtensionObjectToolSet();
                var ns = extensionObjectToolSet.ResolveNamespace();

                Assert.AreEqual("http://www.whited.us/2010/XSL/ExtensionObjectToolSet", ns);
            }

            {
                var extensionObjectToolSet = new ExtensionObjectToolSet()
                {
                    Name = "Name",
                };
                var ns = extensionObjectToolSet.ResolveNamespace();

                Assert.AreEqual("http://www.whited.us/2010/XSL/ExtensionObjectToolSet/Name", ns);
            }
        }
    }
}
