using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Security;
using System.ComponentModel;

namespace WhitedUS.Data.MembershipRoleProvider
{
    public class MemberData
    {
        [DataObjectMethod(DataObjectMethodType.Select,true)]
        public static IEnumerable<MembershipUser> GetAllMembers()
        {
            int result = 0;
            return Membership.Provider.GetAllUsers(0, 100, out result)
                                      .OfType<MembershipUser>();
        }
    }
}
