using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Security
{
    internal class Constants
    {
        internal static readonly string AUTHENTICATION_TYPE = 
                                    "MyAuthentication";
        internal static readonly DateTime SQL_MINIMUM_VALUE = 
                                    DateTime.Parse("1/1/1753 12:00:00 AM");
        internal static readonly string DEFAULT_ROLE = "AllUsers";
    }
}
