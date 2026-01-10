using OoBDev.ScoreMachine.Web.Core.Providers.ScoreMachine;
using System;
using System.Linq;
using System.Text;
using PlayGround;

namespace OoBDev.ScoreMachine.Web.Core.Providers.SaintGeorge
{
    public class SgState : IScoreMachineState
    {
        public static readonly SgState Empty = new SgState(default(byte[]), default(SgState), default(Fencer), default(Fencer), default(TimeSpan));

        private byte[] Frame { get; }
        private SgState Last { get; }

        public Fencer Red { get; }
        public Fencer Green { get; }
        public TimeSpan Clock { get; }

        public override string ToString()
        {
            return $"R:{Red} G:{Green} T:{Clock}";
        }

        private SgState(byte[] frame, SgState last, Fencer red, Fencer green, TimeSpan clock)
        {
            this.Frame = frame;
            this.Last = last;

            this.Red = red;
            this.Green = green;
            this.Clock = clock;
        }



        public static SgState Create(SgState last, byte[] frame)
        {
            //Console.WriteLine($"SgState::Create:: [{Convert.ToBase64String(frame)}]({frame.Length}) \"{Encoding.ASCII.GetString(frame)}\"");
            //P ad 
            // File.AppendAllLines("log.priority.bin", new[] { Encoding.ASCII.GetString(frame) });

            if (frame == null || frame.Length == 0 || frame[0] != 0x13) return last;

            if (frame.Length >= 4 &&
                frame[1] == (byte)'S' &&
                frame[2] == (byte)'T' &&
                frame[3] == 0x02)
            {
                //i19	ST	i2	000:000	i2	0	i2	0	i2	3	i2	0

                var parts = frame.Chunk(0x02, true).ToArray();
                var scores = parts[1].Select(i => (byte)(i - (byte)'0'))
                                     .Chunk(0x0a, exclude: true)
                                     .Select(i => (byte)i.Reverse().Select((v, ix) => Math.Pow(10, ix) * v).Sum())
                                     .ToArray();
                try
                {
                    var greenCards = (Cards)(parts[2][1] - (byte)'0');
                    var redCards = (Cards)(parts[3][1] - (byte)'0');

                    var red = new Fencer(scores[1], redCards, last?.Red.Lights ?? Lights.None, last?.Red.Priority ?? false);
                    var green = new Fencer(scores[0], greenCards, last?.Green.Lights ?? Lights.None, last?.Green.Priority ?? false);

                    return new SgState(frame, last, red, green, last?.Clock ?? TimeSpan.Zero);
                }
                catch (Exception ex)
                {
                    Console.Error.WriteLine($"SgState::Create::ST:ERROR: \"{ex.Message}\" [{Encoding.ASCII.GetString(frame)}]-[{Convert.ToBase64String(frame)}]");
                    //throw;
                }
            }
            else if (frame.Length >= 9 &&
                     frame[1] == (byte)'L' &&
                     frame[2] == (byte)'R' &&
                     frame[4] == (byte)'G' &&
                     frame[6] == (byte)'W' &&
                     frame[8] == (byte)'w')
            {
                // i19 LR1G0W0w1
                var redLights = (Lights)((frame[3] - '0') << 1 | (frame[7] - '0'));
                var red = new Fencer(last?.Red.Score ?? 0, last?.Red.Cards ?? Cards.None, redLights, last?.Red.Priority ?? false);

                var greenLights = (Lights)((frame[5] - '0') << 1 | (frame[9] - '0'));
                var green = new Fencer(last?.Green.Score ?? 0, last?.Green.Cards ?? Cards.None, greenLights, last?.Green.Priority ?? false);
                return new SgState(frame, last, red, green, last?.Clock ?? TimeSpan.Zero);
            }
            //i19	R_F$	i2	i16	0000__:20:00.___
            else if (frame.Length >= 6 &&
                     frame[1] == (byte)'R' &&
                     frame[2] == (byte)'_' &&
                     frame[3] == (byte)'F' &&
                     frame[4] == (byte)'$' &&
                     frame[5] == 0x02)
            {
                var chunks = frame.Chunk(0x02, true)
                                  .Skip(1)
                                  .First()
                                  .Select(i => (byte)(i - (byte)'0'))
                                  .Where(i => i <= 0x0a)
                                  .Chunk(0x0a, true)
                                  .Skip(1)
                                  .Select(i => (byte)i.Reverse().Select((v, ix) => Math.Pow(10, ix) * v).Sum())
                                  .ToArray();
                try
                {
                    var time = new TimeSpan(0, chunks[0], chunks[1]);
                    return new SgState(frame, last, last?.Red ?? new Fencer(), last?.Green ?? new Fencer(), time);
                }
                catch (Exception ex)
                {
                    Console.Error.WriteLine($"SgState::Create::R_F$:ERROR: \"{ex.Message}\" [{Convert.ToBase64String(frame)}]");
                    //throw;
                }
            }
            else if (frame.Length >= 3 &&
                     frame[1] == 'P' &&
                     (frame[2] & 0xfc) == 0x30
                     )
            {
                var redPriority = (frame[2] & 0x03) == 0x02;
                var greenPriority = (frame[2] & 0x03) == 0x01;

                var red = new Fencer(last?.Red.Score ?? 0, last?.Red.Cards ?? Cards.None, last?.Red.Lights ?? Lights.None, redPriority);
                var green = new Fencer(last?.Green.Score ?? 0, last?.Green.Cards ?? Cards.None, last?.Green.Lights ?? Lights.None, greenPriority);

                return new SgState(frame, last, red, green, last?.Clock ?? new TimeSpan());
            }

            return last;
        }

        public override bool Equals(object obj)
        {
            var i = obj as SgState;
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