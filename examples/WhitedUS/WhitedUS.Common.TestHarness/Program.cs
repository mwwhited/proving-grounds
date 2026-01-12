using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WhitedUS.Common.Security;
using WhitedUS.Common.Security.Crypt;
using System.Web.Security;
using System.IO;
using System.Security.Cryptography.X509Certificates;

namespace WhitedUS.Common.TestHarness
{
    class Program
    {
        static void Main(string[] args)
        {
            //var password = PasswordTools.GeneratePassword(8);
            //var crypt = UnixCrypt.Hash<Md5Crypt>(password);

            //var memberProvider = Membership.Provider;
            //MembershipCreateStatus status;
            //memberProvider.CreateUser("mwhited", "+0wn40m3!", "matt@whited.us", null, null, true, null, out status);

            //var roleProvider = Roles.Provider;
            //if (!roleProvider.RoleExists("Administrators"))
            //    roleProvider.CreateRole("Administrators");
            //roleProvider.AddUsersToRoles(new[] { "mwhited" }, new[] { "Administrators" });

            //var tool = new DigitalSignatureTools();
            //var key = tool.CreateRsaKey();
            //string sign;
            //using (var ms = new MemoryStream(Encoding.ASCII.GetBytes("Hello World!!!")))
            //{
            //    sign = tool.SignData(ms, key);
            //    ms.Position = 0;
            //    var check = tool.VerifyData(ms, key, sign);
            //}
        }
    }
}
