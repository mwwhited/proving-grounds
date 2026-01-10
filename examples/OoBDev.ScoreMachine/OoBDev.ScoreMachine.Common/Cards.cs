using System;
using System.Collections.Generic;
using System.Text;

namespace OoBDev.ScoreMachine.Common
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
