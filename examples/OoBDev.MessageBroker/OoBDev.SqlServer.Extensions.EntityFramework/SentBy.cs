using System;

namespace OoBDev.SqlServer.Extensions.EntityFramework
{
    [Flags]
    public enum SentBy
    {
        Initiator = 1,
        Target = 2,
        Any = 3,
    }
}