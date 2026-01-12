using System;
using System.Net.Sockets;
using WhitedUS.Runtime.Definitions;
using WhitedUS.Services.Telnet;

namespace WhitedUS.Runtime.Addons
{
    public class TelnetServer : IRuntimeModule
    {
        #region IRuntimeModule Members

        public void Start()
        {
            TelnetService.ServerStart();
        }

        #endregion
    }
}
