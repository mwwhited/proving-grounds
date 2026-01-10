using System;

namespace OoBDev.ScoreMachine.Web.Core.Providers.ZoomH4N
{
    [Flags]
    public enum H4nStatus : byte
    {
        Record = 0x01,
        Peak = 0x02,
        Mic = 0x10,
        Led1 = 0x20,
        Led2 = 0x40,
    }
}
