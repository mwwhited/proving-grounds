using OoBDev.ScoreMachine.Common;
using System;

namespace OoBDev.ScoreMachine.Emulator
{
    public class EmulatorState : IScoreMachineState
    {
        public Fencer Red { get; internal set; }

        public Fencer Green { get; internal set; }

        public TimeSpan Clock { get; internal set; }

        public override string ToString()
        {
            return $"R:{Red} G:{Green} T:{Clock}";
        }

        public override bool Equals(object obj)
        {
            var i = obj as EmulatorState;
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
