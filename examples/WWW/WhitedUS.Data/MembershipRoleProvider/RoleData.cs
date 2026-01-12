using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Security;
using System.ComponentModel;

namespace WhitedUS.Data.MembershipRoleProvider
{

    public class RoleData
    {
        public RoleData()
        {
        }

        [DataObjectMethod(DataObjectMethodType.Select, true)]
        public static string[] GetAllRoles()
        {
            return Roles.Provider.GetAllRoles();
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public static string[] GetUsersInRole(string roleName)
        {
            return Roles.Provider.GetUsersInRole(roleName);
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public static string[] FindUsersInRole(string roleName, 
                                               string usernamePattern)
        {
            return Roles.Provider.FindUsersInRole(roleName, usernamePattern);
        }

        [DataObjectMethod(DataObjectMethodType.Insert, true)]
        public static void CreateRole(string roleName)
        {
            Roles.Provider.CreateRole(roleName);
        }

        [DataObjectMethod(DataObjectMethodType.Delete, true)]
        public static void DeleteRole(string roleName)
        {
            Roles.Provider.DeleteRole(roleName, true);
        }

        [DataObjectMethod(DataObjectMethodType.Delete, false)]
        public static void DeleteRole(string roleName, bool throwOnPopulated)
        {
            Roles.Provider.DeleteRole(roleName, throwOnPopulated);
        }
    }
}
