using System;

namespace OoBDev.ScoreMachine.Web.Core.Providers.ScoreMachine
{
    [Flags]
    public enum Cards
    {
        None = 0x0,
        Yellow = 0x1,
        Red = 0x2,
        Black = 0x4,
    }
}
