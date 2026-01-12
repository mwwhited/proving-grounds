using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WhitedUS.Runtime.Definitions;
using System.Net.Sockets;
using System.Web.Security;
using System.Diagnostics;
using WhitedUS.Services.LDAP;

namespace WhitedUS.Runtime.Addons
{
    public class LdapProvider: IRuntimeModule
    {
     
        #region IRuntimeModule Members

        public void Start()
        {
            LdapService.ServerStart();
        }

        #endregion
    }
}
