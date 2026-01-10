using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace OoBDev.ScoreMachine.Tests
{
    [TestClass]
    public class FaveroScoreMachineStateTests
    {
        [TestMethod]
        public void DecodeTest()
        {
            var input = new byte[]
            {
                0xff, 0x06, 0x12, 0x56, 0x02, 0x14, 0x0a, 0x00, 0x38, 0x56,
            };

            //var score = new ScoreModel(input);

            //Assert.AreEqual(score.RightScore, 6);
            //Assert.AreEqual(score.LeftScore, 12);
            //Assert.AreEqual(score.Clock, new TimeSpan(0, 2, 56));
            //Assert.AreEqual(score.LeftLamp, LampValues.Touch);
            //Assert.AreEqual(score.RightLamp, LampValues.Yellow);
            //Assert.AreEqual(score.Match, 2);
            //Assert.AreEqual(score.Priority, PriorityValues.Left);
            //Assert.AreEqual(score.RightCard, PenaltyCards.None);
            //Assert.AreEqual(score.LeftCard, PenaltyCards.Yellow);

            throw new NotImplementedException();
        }
    }
}
