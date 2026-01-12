using WhitedUS.Common.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Collections.Generic;
using System;
using System.Linq;

namespace WhitedUSCommonTests.Linq
{


    /// <summary>
    ///This is a test class for EnumerableTest and is intended
    ///to contain all EnumerableTest Unit Tests
    ///</summary>
    [TestClass()]
    public class EnumerableTest
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


        [TestMethod()]
        public void SetActionTest2()
        {
            var left = new byte[] { (byte)0xf0, (byte)0x0f, (byte)0xff, (byte)0x00 }.AsEnumerable();
            var right = new byte[] { (byte)0xaa, (byte)0xbb, (byte)0xcc, (byte)0xdd }.AsEnumerable();
            Func<byte, byte, byte> merge = (byte l, byte r) => (byte)(l & r);
            var expected = new byte[] { (byte)0xa0, (byte)0x0b, (byte)0xcc, (byte)0x00 };
            var actual = left.SetAction(right, merge);
            Assert.IsFalse(actual.DoesntMatch(expected));
        }

        /// <summary>
        ///A test for SetAction
        ///</summary>
        public void SetActionTest1Helper<T, TResult>()
        {
            IEnumerable<T> left = null; // TODO: Initialize to an appropriate value
            IEnumerable<T> right = null; // TODO: Initialize to an appropriate value
            Func<T, T, TResult> merge = null; // TODO: Initialize to an appropriate value
            Func<T, TResult> single = null; // TODO: Initialize to an appropriate value
            IEnumerable<TResult> expected = null; // TODO: Initialize to an appropriate value
            IEnumerable<TResult> actual;
            actual = left.SetAction(right, merge, single);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        [TestMethod()]
        public void SetActionTest1()
        {
            SetActionTest1Helper<GenericParameterHelper, GenericParameterHelper>();
        }

        /// <summary>
        ///A test for SetAction
        ///</summary>
        public void SetActionTestHelper<TLeft, TRight, TResult>()
        {
            IEnumerable<TLeft> left = null; // TODO: Initialize to an appropriate value
            IEnumerable<TRight> right = null; // TODO: Initialize to an appropriate value
            Func<TLeft, TRight, TResult> merge = null; // TODO: Initialize to an appropriate value
            Func<TLeft, TResult> leftOnly = null; // TODO: Initialize to an appropriate value
            Func<TRight, TResult> rightOnly = null; // TODO: Initialize to an appropriate value
            IEnumerable<TResult> expected = null; // TODO: Initialize to an appropriate value
            IEnumerable<TResult> actual;
            actual = left.SetAction(right, merge, leftOnly, rightOnly);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        [TestMethod()]
        public void SetActionTest()
        {
            SetActionTestHelper<GenericParameterHelper, GenericParameterHelper, GenericParameterHelper>();
        }

        /// <summary>
        ///A test for Pages
        ///</summary>
        public void PagesTestHelper<T>()
        {
            IEnumerable<T> input = null; // TODO: Initialize to an appropriate value
            Func<T, bool> first = null; // TODO: Initialize to an appropriate value
            Func<T, bool> last = null; // TODO: Initialize to an appropriate value
            IEnumerable<IEnumerable<T>> expected = null; // TODO: Initialize to an appropriate value
            IEnumerable<IEnumerable<T>> actual;
            actual = input.Pages(first, last);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        [TestMethod()]
        public void PagesTest()
        {
            PagesTestHelper<GenericParameterHelper>();
        }
    }
}
