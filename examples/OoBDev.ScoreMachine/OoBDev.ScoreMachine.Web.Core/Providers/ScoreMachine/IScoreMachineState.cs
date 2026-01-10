using System;

namespace OoBDev.ScoreMachine.Web.Core.Providers.ScoreMachine
{
    public interface IScoreMachineState
    {
        Fencer Red { get; }
        Fencer Green { get; }
        TimeSpan Clock { get; }
    }
}