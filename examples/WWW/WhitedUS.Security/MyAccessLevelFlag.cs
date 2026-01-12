using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Security
{
    [Flags]
    public enum MyAccessLevelFlag
    {
/*
 * 1
 * 2
 * 4
 * 8
 */
        Anonymous = 0x0001,
        Patron = 0x0002,
        Friend = 0x0004,
        Family = 0x0008,

        Monitor = 0x0100,
        PowerUser = 0x0200,
        SuperUser = 0x0400,
        Admin = 0x0800,

        Owner = -1,
    }
}
