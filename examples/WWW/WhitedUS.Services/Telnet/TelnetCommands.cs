using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Services.Telnet
{
    public enum TelnetCommands : byte
    {
        ECHO = 1,

        SE = 240,
        NOP = 241,
        DM = 242,
        BRK = 243,
        IP = 244,
        AO = 245,
        AYT = 246,
        EC = 247,
        EL = 248,
        GA = 249,
        SB = 250,
        WILL = 251,
        WONT = 252,
        DO = 253,
        DONT = 254,
        IAC = 255
    }
}
