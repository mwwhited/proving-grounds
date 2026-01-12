using System.Collections.Generic;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using WhitedUS.Common.Linq;

namespace WhitedUSCommonTests.Linq
{
    /// <summary>
    ///This is a test class for LogicToolsTest and is intended
    ///to contain all LogicToolsTest Unit Tests
    ///</summary>
    [TestClass()]
    public class LogicToolsTest
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
        ///A test for XOR
        ///</summary>
        [TestMethod()]
        public void XORTestInt()
        {
            unchecked
            {
                var left = new int[] { (int)0xffffffff, 0x00000000, 0x00ffFf00, (int)0xff0000ff };
                var right = new int[] { 0xaaaa, 0xbbbb, 0xcccc, 0xdddd };
                var expected = new int[] { (int)0xffff5555, 0x0000bbbb, 0x00ff33cc, (int)0xff00dd22 };
                var actual = left.XOR(right);

                Assert.IsFalse(actual.DoesntMatch(expected));
            }
        }

        /// <summary>
        ///A test for XOR
        ///</summary>
        [TestMethod()]
        public void XORTestLong()
        {
            unchecked
            {
                var left = new long[] { (long)0xffffffff, 0x00000000, 0x00ffFf00, (long)0xff0000ff };
                var right = new long[] { 0xaaaa, 0xbbbb, 0xcccc, 0xdddd };
                var expected = new long[] { (long)0xffff5555, 0x0000bbbb, 0x00ff33cc, (long)0xff00dd22 };
                var actual = left.XOR(right);

                Assert.IsFalse(actual.DoesntMatch(expected));
            }
        }

        /// <summary>
        ///A test for XOR
        ///</summary>
        [TestMethod()]
        public void XORTestUint()
        {
            unchecked
            {
                var left = new uint[] { (uint)0xffffffff, 0x00000000, 0x00ffFf00, (uint)0xff0000ff };
                var right = new uint[] { 0xaaaa, 0xbbbb, 0xcccc, 0xdddd };
                var expected = new uint[] { (uint)0xffff5555, 0x0000bbbb, 0x00ff33cc, (uint)0xff00dd22 };
                var actual = left.XOR(right);

                Assert.IsFalse(actual.DoesntMatch(expected));
            }
        }

        /// <summary>
        ///A test for XOR
        ///</summary>
        [TestMethod()]
        public void XORTestSByte()
        {
            unchecked
            {
                var left = new sbyte[] { (sbyte)0xff, (sbyte)0x00, (sbyte)0xf0, (sbyte)0x0f };
                var right = new sbyte[] { (sbyte)0xaa, (sbyte)0xbb, (sbyte)0xcc, (sbyte)0xdd };
                var expected = new sbyte[] { (sbyte)0x55, (sbyte)0xbb, (sbyte)0x3c, (sbyte)0xd2 };
                var actual = left.XOR(right);

                Assert.IsFalse(actual.DoesntMatch(expected));
            }
        }

        /// <summary>
        ///A test for XOR
        ///</summary>
        [TestMethod()]
        public void XORTestByte()
        {
            unchecked
            {
                var left = new byte[] { (byte)0xff, (byte)0x00, (byte)0xf0, (byte)0x0f };
                var right = new byte[] { (byte)0xaa, (byte)0xbb, (byte)0xcc, (byte)0xdd };
                var expected = new byte[] { (byte)0x55, (byte)0xbb, (byte)0x3c, (byte)0xd2 };
                var actual = left.XOR(right);

                Assert.IsFalse(actual.DoesntMatch(expected));
            }
        }

        /// <summary>
        ///A test for XOR
        ///</summary>
        [TestMethod()]
        public void XORTestULong()
        {
            unchecked
            {
                var left = new ulong[] { (ulong)0xffffffff, 0x00000000, 0x00ffFf00, (ulong)0xff0000ff };
                var right = new ulong[] { 0xaaaa, 0xbbbb, 0xcccc, 0xdddd };
                var expected = new ulong[] { (ulong)0xffff5555, 0x0000bbbb, 0x00ff33cc, (ulong)0xff00dd22 };
                var actual = left.XOR(right);

                Assert.IsFalse(actual.DoesntMatch(expected));
            }
        }

        /// <summary>
        ///A test for OR
        ///</summary>
        [TestMethod()]
        public void ORTestInt()
        {
            unchecked
            {
                var left = new int[] { (int)0xffffffff, 0x00000000, 0x00ffFf00, (int)0xff0000ff };
                var right = new int[] { 0xaaaa, 0xbbbb, 0xcccc, 0xdddd };
                var expected = new int[] { (int)0xffffffff, 0xbbbb, 0x00ffffcc, (int)0xff00ddff };
                var actual = left.OR(right);

                Assert.IsFalse(actual.DoesntMatch(expected));
            }
        }

        /// <summary>
        ///A test for OR
        ///</summary>
        [TestMethod()]
        public void ORTestLong()
        {
            unchecked
            {
                var left = new long[] { (long)0xffffffff, 0x00000000, 0x00ffFf00, (long)0xff0000ff };
                var right = new long[] { 0xaaaa, 0xbbbb, 0xcccc, 0xdddd };
                var expected = new long[] { (long)0xffffffff, 0xbbbb, 0x00ffffcc, (long)0xff00ddff };
                var actual = left.OR(right);

                Assert.IsFalse(actual.DoesntMatch(expected));
            }
        }

        /// <summary>
        ///A test for OR
        ///</summary>
        [TestMethod()]
        public void ORTestUInt()
        {
            unchecked
            {
                var left = new uint[] { (uint)0xffffffff, 0x00000000, 0x00ffFf00, (uint)0xff0000ff };
                var right = new uint[] { 0xaaaa, 0xbbbb, 0xcccc, 0xdddd };
                var expected = new uint[] { (uint)0xffffffff, 0xbbbb, 0x00ffffcc, (uint)0xff00ddff };
                var actual = left.OR(right);

                Assert.IsFalse(actual.DoesntMatch(expected));
            }
        }

        /// <summary>
        ///A test for OR
        ///</summary>
        [TestMethod()]
        public void ORTestSByte()
        {
            unchecked
            {
                var left = new sbyte[] { (sbyte)0xff, (sbyte)0x00, (sbyte)0xf0, (sbyte)0x0f };
                var right = new sbyte[] { (sbyte)0xaa, (sbyte)0xbb, (sbyte)0xcc, (sbyte)0xdd };
                var expected = new sbyte[] { (sbyte)0xff, (sbyte)0xbb, (sbyte)0xfc, (sbyte)0xdf };
                var actual = left.OR(right);

                Assert.IsFalse(actual.DoesntMatch(expected));
            }
        }

        /// <summary>
        ///A test for OR
        ///</summary>
        [TestMethod()]
        public void ORTestByte()
        {
            unchecked
            {
                var left = new byte[] { (byte)0xff, (byte)0x00, (byte)0xf0, (byte)0x0f };
                var right = new byte[] { (byte)0xaa, (byte)0xbb, (byte)0xcc, (byte)0xdd };
                var expected = new byte[] { (byte)0xff, (byte)0xbb, (byte)0xfc, (byte)0xdf };
                var actual = left.OR(right);

                Assert.IsFalse(actual.DoesntMatch(expected));
            }
        }

        /// <summary>
        ///A test for OR
        ///</summary>
        [TestMethod()]
        public void ORTestULong()
        {
            unchecked
            {
                var left = new ulong[] { (ulong)0xffffffff, 0x00000000, 0x00ffFf00, (ulong)0xff0000ff };
                var right = new ulong[] { 0xaaaa, 0xbbbb, 0xcccc, 0xdddd };
                var expected = new ulong[] { (ulong)0xffffffff, 0xbbbb, 0x00ffffcc, (ulong)0xff00ddff };
                var actual = left.OR(right);

                Assert.IsFalse(actual.DoesntMatch(expected));
            }
        }

        /// <summary>
        ///A test for AND
        ///</summary>
        [TestMethod()]
        public void ANDTestInt()
        {
            unchecked
            {
                var left = new int[] { (int)0xffffffff, 0x00000000, 0x00ffFf00, (int)0xff0000ff };
                var right = new int[] { 0xaaaa, 0xbbbb, 0xcccc, 0xdddd };
                var expected = new int[] { (int)0xaaaa, 0x00000000, 0xcc00, (int)0xdd };
                var actual = left.AND(right);

                Assert.IsFalse(actual.DoesntMatch(expected));
            }
        }

        /// <summary>
        ///A test for AND
        ///</summary>
        [TestMethod()]
        public void ANDTestLong()
        {
            unchecked
            {
                var left = new long[] { (long)0xffffffff, 0x00000000, 0x00ffFf00, (long)0xff0000ff };
                var right = new long[] { 0xaaaa, 0xbbbb, 0xcccc, 0xdddd };
                var expected = new long[] { (long)0xaaaa, 0x00000000, 0xcc00, (long)0xdd };
                var actual = left.AND(right);

                Assert.IsFalse(actual.DoesntMatch(expected));
            }
        }

        /// <summary>
        ///A test for AND
        ///</summary>
        [TestMethod()]
        public void ANDTestUInt()
        {
            unchecked
            {
                var left = new uint[] { (uint)0xffffffff, 0x00000000, 0x00ffFf00, (uint)0xff0000ff };
                var right = new uint[] { 0xaaaa, 0xbbbb, 0xcccc, 0xdddd };
                var expected = new uint[] { (uint)0xaaaa, 0x00000000, 0xcc00, (uint)0xdd };
                var actual = left.AND(right);

                Assert.IsFalse(actual.DoesntMatch(expected));
            }
        }

        /// <summary>
        ///A test for AND
        ///</summary>
        [TestMethod()]
        public void ANDTestSByte()
        {
            unchecked
            {
                var left = new sbyte[] { (sbyte)0xff, (sbyte)0x00, (sbyte)0xf0, (sbyte)0x0f };
                var right = new sbyte[] { (sbyte)0xaa, (sbyte)0xbb, (sbyte)0xcc, (sbyte)0xdd };
                var expected = new sbyte[] { (sbyte)0xaa, (sbyte)0x00, (sbyte)0xc0, (sbyte)0x0d };
                var actual = left.AND(right);

                Assert.IsFalse(actual.DoesntMatch(expected));
            }
        }

        /// <summary>
        ///A test for AND
        ///</summary>
        [TestMethod()]
        public void ANDTestByte()
        {
            unchecked
            {
                var left = new byte[] { (byte)0xff, (byte)0x00, (byte)0xf0, (byte)0x0f };
                var right = new byte[] { (byte)0xaa, (byte)0xbb, (byte)0xcc, (byte)0xdd };
                var expected = new byte[] { (byte)0xaa, (byte)0x00, (byte)0xc0, (byte)0x0d };
                var actual = left.AND(right);

                Assert.IsFalse(actual.DoesntMatch(expected));
            }
        }

        /// <summary>
        ///A test for AND
        ///</summary>
        [TestMethod()]
        public void ANDTestULong()
        {
            unchecked
            {
                var left = new ulong[] { (ulong)0xffffffff, 0x00000000, 0x00ffFf00, (ulong)0xff0000ff };
                var right = new ulong[] { 0xaaaa, 0xbbbb, 0xcccc, 0xdddd };
                var expected = new ulong[] { (ulong)0xaaaa, 0x00000000, 0xcc00, (ulong)0xdd };
                var actual = left.AND(right);

                Assert.IsFalse(actual.DoesntMatch(expected));
            }
        }

        /// <summary>
        ///A test for AND
        ///</summary>
        [TestMethod()]
        public void ANDTestShort()
        {
            unchecked
            {
                var left = new short[] { (short)0xffff, 0x0000, 0x0fF0, (short)0xf00f };
                var right = new short[] { (short)0xaaaa, (short)0xbbbb, (short)0xcccc, (short)0xdddd };
                var expected = new short[] { (short)0xaaaa, 0x0000, (short)0x0cc0, (short)0xd00d };
                var actual = left.AND(right);

                Assert.IsFalse(actual.DoesntMatch(expected));
            }
        }

        /// <summary>
        ///A test for AND
        ///</summary>
        [TestMethod()]
        public void ANDTestUShort()
        {
            unchecked
            {
                var left = new ushort[] { (ushort)0xffff, 0x0000, 0x0fF0, (ushort)0xf00f };
                var right = new ushort[] { (ushort)0xaaaa, (ushort)0xbbbb, (ushort)0xcccc, (ushort)0xdddd };
                var expected = new ushort[] { (ushort)0xaaaa, 0x0000, (ushort)0x0cc0, (ushort)0xd00d };
                var actual = left.AND(right);

                Assert.IsFalse(actual.DoesntMatch(expected));
            }
        }

        /// <summary>
        ///A test for OR
        ///</summary>
        [TestMethod()]
        public void ORTestShort()
        {
            unchecked
            {
                var left = new short[] { (short)0xffff, 0x0000, 0x0fF0, (short)0xf00f };
                var right = new short[] { (short)0xaaaa, (short)0xbbbb, (short)0xcccc, (short)0xdddd };
                var expected = new short[] { (short)0xffff, (short)0xbbbb, (short)0xcffc, (short)0xfddf };
                var actual = left.OR(right);

                Assert.IsFalse(actual.DoesntMatch(expected));
            }
        }

        /// <summary>
        ///A test for OR
        ///</summary>
        [TestMethod()]
        public void ORTestUShort()
        {
            unchecked
            {
                var left = new ushort[] { (ushort)0xffff, 0x0000, 0x0fF0, (ushort)0xf00f };
                var right = new ushort[] { (ushort)0xaaaa, (ushort)0xbbbb, (ushort)0xcccc, (ushort)0xdddd };
                var expected = new ushort[] { (ushort)0xffff, (ushort)0xbbbb, (ushort)0xcffc, (ushort)0xfddf };
                var actual = left.OR(right);

                Assert.IsFalse(actual.DoesntMatch(expected));
            }
        }

        /// <summary>
        ///A test for XOR
        ///</summary>
        [TestMethod()]
        public void XORTestShort()
        {
            unchecked
            {
                var left = new short[] { (short)0xffff, 0x0000, 0x0fF0, (short)0xf00f };
                var right = new short[] { (short)0xaaaa, (short)0xbbbb, (short)0xcccc, (short)0xdddd };
                var expected = new short[] { (short)0x55555, (short)0xbbbb, (short)0xc33c, (short)0x2dd2 };
                var actual = left.XOR(right);

                Assert.IsFalse(actual.DoesntMatch(expected));
            }
        }

        /// <summary>
        ///A test for XOR
        ///</summary>
        [TestMethod()]
        public void XORTestUShort()
        {
            unchecked
            {
                var left = new ushort[] { (ushort)0xffff, 0x0000, 0x0fF0, (ushort)0xf00f };
                var right = new ushort[] { (ushort)0xaaaa, (ushort)0xbbbb, (ushort)0xcccc, (ushort)0xdddd };
                var expected = new ushort[] { (ushort)0x55555, (ushort)0xbbbb, (ushort)0xc33c, (ushort)0x2dd2 };
                var actual = left.XOR(right);

                Assert.IsFalse(actual.DoesntMatch(expected));
            }
        }
    }
}
