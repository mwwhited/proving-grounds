using Microsoft.VisualStudio.TestTools.UnitTesting;
using OoBDev.ScoreMachine.Common;
using OoBDev.ScoreMachine.SG;
using System;
using System.Text;

namespace OoBDev.ScoreMachine.Tests
{
    [TestClass]
    public class SgScoreMachineStateTests
    {
        [TestMethod]
        public void CreateSgState_ScoreTimeTest()
        {
            var payload = ((char)0x13) + string.Join(new string(new[] { (char)0x02 }),
                "ST",
                "005:010",
                "0100",
                "0201",
                "3",
                "00"
                );
            var frame = Encoding.ASCII.GetBytes(payload);

            var s = SgState.Create(null, frame);

            Assert.AreEqual(s.Green.Score, 5);
            Assert.AreEqual(s.Red.Score, 10);
            Assert.AreEqual(s.Clock, TimeSpan.Zero);
            Assert.AreEqual(s.Green.Lights, Lights.None);
            Assert.AreEqual(s.Red.Lights, Lights.None);
            Assert.AreEqual(s.Green.Cards, Cards.Yellow);
            Assert.AreEqual(s.Red.Cards, Cards.Red);
        }

        [TestMethod]
        public void CreateSgState_LightsTest()
        {
            var payload = ((char)0x13) + "LR0G1W1w1";
            var frame = Encoding.ASCII.GetBytes(payload);

            var s = SgState.Create(null, frame);

            Assert.AreEqual(s.Green.Score, 0);
            Assert.AreEqual(s.Red.Score, 0);
            Assert.AreEqual(s.Clock, TimeSpan.Zero);
            Assert.AreEqual(s.Green.Lights, Lights.Touch | Lights.White);
            Assert.AreEqual(s.Red.Lights, Lights.White);
            Assert.AreEqual(s.Green.Cards, Cards.None);
            Assert.AreEqual(s.Red.Cards, Cards.None);
        }

        [TestMethod]
        public void CreateSgState_ClockTest()
        {
            var payload = ((char)0x13) + "R_F$" + (char)0x02 + (char)0x16 + "0000__:20:00.___";
            var frame = Encoding.ASCII.GetBytes(payload);

            var s = SgState.Create(null, frame);

            Assert.AreEqual(s.Green.Score, 0);
            Assert.AreEqual(s.Red.Score, 0);
            Assert.AreEqual(s.Clock, new TimeSpan(0,20,0));
            Assert.AreEqual(s.Green.Lights, Lights.None);
            Assert.AreEqual(s.Red.Lights, Lights.None);
            Assert.AreEqual(s.Green.Cards, Cards.None);
            Assert.AreEqual(s.Red.Cards, Cards.None);
        }


        [TestMethod]
        public void CreateSgState_PriorityTest()
        {
            var payload = ((char)0x13) + "P1" + (char)0x0D + (char)0xA;
            var frame = Encoding.ASCII.GetBytes(payload);

            var s = SgState.Create(null, frame);

            Assert.AreEqual(s.Green.Score, 0);
            Assert.AreEqual(s.Red.Score, 0);
            Assert.AreEqual(s.Clock, new TimeSpan(0, 0, 0));
            Assert.AreEqual(s.Green.Lights, Lights.None);
            Assert.AreEqual(s.Red.Lights, Lights.None);
            Assert.AreEqual(s.Green.Cards, Cards.None);
            Assert.AreEqual(s.Red.Cards, Cards.None);
            Assert.AreEqual(s.Green.Priority, true);
            Assert.AreEqual(s.Red.Priority, false);
        }
    }
}
