using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WhitedUS.Runtime.Definitions;
using WhitedUS.Services.SNTP;

namespace WhitedUS.Runtime.Addons
{
    public class SNTPServer : IRuntimeModule
    {
        #region IRuntimeModule Members

        public void Start()
        {
            SNTPService.ServerStart();
        }

        #endregion
    }
}
