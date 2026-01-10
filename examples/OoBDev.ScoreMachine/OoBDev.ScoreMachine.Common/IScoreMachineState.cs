using System;

namespace OoBDev.ScoreMachine.Common
{
    public interface IScoreMachineState
    {
        Fencer Red { get; }
        Fencer Green { get; }
        TimeSpan Clock { get; }
    }
}