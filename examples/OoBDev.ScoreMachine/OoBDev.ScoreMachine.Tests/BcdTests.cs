using Microsoft.VisualStudio.TestTools.UnitTesting;
using OoBDev.ScoreMachine.Common.Extensions;

namespace OoBDev.ScoreMachine.Tests
{
    [TestClass]
    public class BcdTests
    {
        [TestMethod]
        public void TestBCD()
        {
            var input = ((byte)0x10).AsBCD();
            Assert.AreEqual(input, 10);

            var input2 = ((byte)0x15).AsBCD();
            Assert.AreEqual(input2, 15);

            var input3 = ((byte)0x05).AsBCD();
            Assert.AreEqual(input3, 5);
        }
    }
}
