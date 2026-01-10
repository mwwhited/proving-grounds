using OoBDev.ScoreMachine.Common;
using System;
using System.Collections.Generic;
using System.Text;

namespace OoBDev.ScoreMachine.Favero
{
    public class FaveroState : IScoreMachineState
    {
        private byte[] Frame { get; }
        private FaveroState Last { get; }

        public Fencer Red { get; }
        public Fencer Green { get; }
        public TimeSpan Clock { get; }

        public override string ToString()
        {
            return $"R:{Red} G:{Green} T:{Clock}";
        }

        private FaveroState(byte[] frame, FaveroState last, Fencer red, Fencer green, TimeSpan clock)
        {
            this.Frame = frame;
            this.Last = last;

            this.Red = red;
            this.Green = green;
            this.Clock = clock;
        }

        public static FaveroState Create(FaveroState last, byte[] frame)
        {
            if (frame == null || frame.Length == 0 || frame[0] != 0x13) return last;
            
            if (frame[0] != 0xff)
                throw new ArgumentException("invalid prefix", nameof(frame));

            ////TODO: Fix the CRC
            ////var crc = (((int)message.Take(9).Select(b => (int)b).Sum()) & 0xff);
            ////var crc = message.Take(9).Aggregate(0, (p, i) => (((p & 0x0f) + (i & 0x0f)) & 0x0f) | (((p & 0x0f0) + (i & 0xf0)) & 0xf0));
            ////var crc = message.Take(9).Aggregate(0, (p, i) => p ^ i);
            ////var crc = message.Take(9).Aggregate(0, (p, i) => (p + i) & 0xff);
            ////if (message[9] != crc)
            ////    throw new InvalidOperationException("invalid CRC");

            //var state = new FaveroState(frame, last, new Fencer( frame[2].AsBCD(), )

            //this.RightScore = frame[1].AsBCD();
            //this.LeftScore = frame[2].AsBCD();
            //this.Clock = new TimeSpan(0, message[4].AsBCD(), frame[3].AsBCD());

            //this.LeftLamp = (LampValues)((frame[5] & 0x5) | (frame[5] >> 4 & 0x2));
            //this.RightLamp = (LampValues)(((frame[5] >> 1) & 0x5) | (frame[5] >> 3 & 0x2));

            //this.Match = (int)(frame[6] & 0x3);
            //this.Priority = (PriorityValues)(frame[6] >> 2 & 0x3);

            //this.RightCard = (PenaltyCards)(frame[8] & 0x5);
            //this.LeftCard = (PenaltyCards)(frame[8] >> 1 & 0x5);


            throw new NotImplementedException();

            //if (frame.Length >= 4 &&
            //    frame[1] == (byte)'S' &&
            //    frame[2] == (byte)'T' &&
            //    frame[3] == 0x02)
            //{

            //    //i19	ST	i2	000:000	i2	0	i2	0	i2	3	i2	0
            //    var parts = Encoding.ASCII.GetString(frame).Split((char)0x02);
            //    var scores = parts[1].Split(':');
            //    var greenCards = (Cards)(parts[2][1] - '0');
            //    var redCards = (Cards)(parts[3][1] - '0');

            //    var red = new Fencer(byte.Parse(scores[1]), redCards, last?.Red.Lights ?? Lights.None, last?.Red.Priority ?? false);
            //    var green = new Fencer(byte.Parse(scores[0]), greenCards, last?.Green.Lights ?? Lights.None, last?.Green.Priority ?? false);

            //    return new SgState(frame, last, red, green, last?.Clock ?? TimeSpan.Zero);
            //}
            //else if (frame.Length >= 9 &&
            //         frame[1] == (byte)'L' &&
            //         frame[2] == (byte)'R' &&
            //         frame[4] == (byte)'G' &&
            //         frame[6] == (byte)'W' &&
            //         frame[8] == (byte)'w')
            //{
            //    // i19 LR1G0W0w1
            //    var redLights = (Lights)((frame[3] - '0') << 1 | (frame[7] - '0'));
            //    var red = new Fencer(last?.Red.Score ?? 0, last?.Red.Cards ?? Cards.None, redLights, last?.Red.Priority ?? false);

            //    var greenLights = (Lights)((frame[5] - '0') << 1 | (frame[9] - '0'));
            //    var green = new Fencer(last?.Green.Score ?? 0, last?.Green.Cards ?? Cards.None, greenLights, last?.Green.Priority ?? false);
            //    return new SgState(frame, last, red, green, last?.Clock ?? TimeSpan.Zero);
            //}
            ////i19	R_F$	i2	i16	0000__:20:00.___
            //else if (frame.Length >= 6 &&
            //         frame[1] == (byte)'R' &&
            //         frame[2] == (byte)'_' &&
            //         frame[3] == (byte)'F' &&
            //         frame[4] == (byte)'$' &&
            //         frame[5] == 0x02)
            //{
            //    var timeString = "00:" + Encoding.ASCII.GetString(frame).Split(new[] { ':' }, 2)[1].Replace('_', '0');
            //    var time = TimeSpan.Parse(timeString);

            //    return new SgState(frame, last, last?.Red ?? new Fencer(), last?.Green ?? new Fencer(), time);
            //}
            //else if (frame.Length >= 3 &&
            //         frame[1] == 'P' &&
            //         (frame[2] & 0xfc) == 0x30
            //         )
            //{
            //    var redPriority = (frame[2] & 0x03) == 0x02;
            //    var greenPriority = (frame[2] & 0x03) == 0x01;

            //    var red = new Fencer(last?.Red.Score ?? 0, last?.Red.Cards ?? Cards.None, last?.Red.Lights ?? Lights.None, redPriority);
            //    var green = new Fencer(last?.Green.Score ?? 0, last?.Green.Cards ?? Cards.None, last?.Green.Lights ?? Lights.None, greenPriority);

            //    return new SgState(frame, last, red, green, last?.Clock ?? new TimeSpan());
            //}

            //return last;
        }


        public FaveroState Read(byte[] message)
        {
            if (message == null)
                throw new ArgumentNullException(nameof(message));
            if (message.Length != 10)
                throw new ArgumentOutOfRangeException(nameof(message));

            if (message[0] != 0xff)
                throw new ArgumentException("invalid prefix", nameof(message));

            //TODO: Fix the CRC
            //var crc = (((int)message.Take(9).Select(b => (int)b).Sum()) & 0xff);
            //var crc = message.Take(9).Aggregate(0, (p, i) => (((p & 0x0f) + (i & 0x0f)) & 0x0f) | (((p & 0x0f0) + (i & 0xf0)) & 0xf0));
            //var crc = message.Take(9).Aggregate(0, (p, i) => p ^ i);
            //var crc = message.Take(9).Aggregate(0, (p, i) => (p + i) & 0xff);
            //if (message[9] != crc)
            //    throw new InvalidOperationException("invalid CRC");

            //var state = new FaveroState( message, this.curre

            //this.RightScore = message[1].AsBCD();
            //this.LeftScore = message[2].AsBCD();
            //this.Clock = new TimeSpan(0, message[4].AsBCD(), message[3].AsBCD());

            //this.LeftLamp = (LampValues)((message[5] & 0x5) | (message[5] >> 4 & 0x2));
            //this.RightLamp = (LampValues)(((message[5] >> 1) & 0x5) | (message[5] >> 3 & 0x2));

            //this.Match = (int)(message[6] & 0x3);
            //this.Priority = (PriorityValues)(message[6] >> 2 & 0x3);

            //this.RightCard = (PenaltyCards)(message[8] & 0x5);
            //this.LeftCard = (PenaltyCards)(message[8] >> 1 & 0x5);
            throw new NotImplementedException();
        }

        //[Flags]
        //public enum LampValues
        //{
        //    Off = 0,
        //    White = 0x1,
        //    Touch = 0x4,
        //    Yellow = 0x2,
        //}
        //public enum PenaltyCards
        //{
        //    None = 0,
        //    Red = 1,
        //    Yellow = 4,
        //}
        //[Flags]
        //public enum PriorityValues
        //{
        //    None = 0,
        //    Right = 1,
        //    Left = 2,
        //}
        public override bool Equals(object obj)
        {
            var i = obj as FaveroState;
            if (obj == null) return false;

            return this.Red.Equals(i.Red)
                && this.Green.Equals(i.Green)
                && this.Clock.Equals(i.Clock);
        }

        public override int GetHashCode()
        {
            return Tuple.Create(this.Red, this.Green, this.Clock).GetHashCode();
        }
    }
}
