using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
using System.Text;
using System.Web.Security;
using WhitedUS.Security;
using WhitedUS.Security.Configuration;
using WhitedUS.Security.Data;
using WhitedUS.Libs.Security.Crypt;

namespace MyMembershipProviderTest
{
    class Program
    {
        static void Main(string[] args)
        {
            //Guid guid = Guid.NewGuid();
            MyMembershipProvider userProvider = new MyMembershipProvider();
            //MembershipCreateStatus status;

            //var user = userProvider.CreateUser("mwhited", "password1", "matt@whited.us", "What is your favorite thing in all the world?", "answer1", true, guid, out status);
            //bool changed = userProvider.ChangePasswordQuestionAndAnswer("mwhited", "password1", "new questions", "newAnswer");
            //bool changed2 = userProvider.ChangePassword("mwhited", "password1", "password2");

            //string resultVal = UnixCrypt.Hash<MyCrypt>("oldpassword");

            //int myInt;
            //var users = userProvider.FindUsersByEmail("m", 0, 10, out myInt);

            //object test1 = MyProvidersConfiguration.CurrentConfig.MyMembershipProvider;
            //string password1 = MyProvidersConfiguration.CurrentConfig.MyMembershipProvider.GetPassword();
            //string password2 = MyProvidersConfiguration.CurrentConfig.MyMembershipProvider.GetPassword();
            //string password3 = MyProvidersConfiguration.CurrentConfig.MyMembershipProvider.GetPassword();

            //MyRoleProvider roleProvider = new MyRoleProvider();
            //roleProvider.AddUsersToRoles(new string[] { "mwhited" }, new string[] { "Admin" });

            //========================

            //DataMyAuthenticationDataContext db = new DataMyAuthenticationDataContext();
            //var app = db.MyApplications.Where(a => a.ApplicationName == "Alphasite").SingleOrDefault();

            //var role = new MyRole() { RoleName = "Admin" };
            //db.MyRoles.InsertOnSubmit(role);

            //var appRole = new MyApplicationRole()
            //{
            //    ApplicationID= app.UniqueID,
            //    RoleID= role.UniqueID
            //};
            //db.MyApplicationRoles.InsertOnSubmit(appRole);

            //var usrAppRole = new MyUserApplicationRole()
            //{
            //     ApplicationRoleID= appRole.
            //};

            //db.SubmitChanges();
        }

        //private IQueryable<MyUser> QueryUsers(DataMyAuthenticationDataContext db)
        //{
        //    return (from u in db.MyUsers
        //            join uar in db.MyUserApplicationRoles on u.UniqueID equals uar.UserID
        //            join ar in db.MyApplicationRoles on uar.ApplicationRoleID equals ar.UniqueID
        //            join a in db.MyApplications on ar.ApplicationID equals a.UniqueID
        //            where a.ApplicationName == ApplicationName && a.IsEnabled
        //            select u); //.Where(predicate);
        //}
    }
}
