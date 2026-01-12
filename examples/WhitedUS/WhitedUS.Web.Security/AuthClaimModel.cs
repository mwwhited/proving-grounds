using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Web.Security
{
    public class AuthClaimModel
    {
        public Guid UserID { get; set; }
        public string ClaimString { get; set; }
    }
}
