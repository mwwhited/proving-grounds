using System;

namespace OoBDev.ScoreMachine.Web.Core.Providers.ScoreMachine
{
    [Flags]
    public enum Lights
    {
        None = 0x0,
        White = 0x1,
        Touch = 0x2,
        Yellow = 0x3,
    }
}
