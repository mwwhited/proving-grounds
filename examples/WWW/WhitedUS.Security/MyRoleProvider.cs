using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Security;
using WhitedUS.Security.Data;
using WhitedUS.Security.Configuration;
using System.Configuration.Provider;
using System.Collections.ObjectModel;
using System.Diagnostics;

//WhitedUS.Security.MyRoleProvider,WhitedUS.Security,PublicKeyToken=f78fa6828975ead6
namespace WhitedUS.Security
{
    //http://msdn.microsoft.com/en-us/library/8fw7xh74.aspx
    public class MyRoleProvider : RoleProvider
    {
        public override string ApplicationName
        {
            get { return MyProvidersConfiguration.CurrentConfig.ApplicationName; }
            set { MyProvidersConfiguration.CurrentConfig.ApplicationName = value; }
        }

        private IQueryable<MyUserRole> QueryUserRoles(DataMyAuthenticationDataContext db)
        {
            return (
                from u in db.MyUsers
                join uar in db.MyUserApplicationRoles on u.UniqueID equals uar.UserID
                join ar in db.MyApplicationRoles on uar.ApplicationRoleID equals ar.UniqueID
                join a in db.MyApplications on ar.ApplicationID equals a.UniqueID
                join r in db.MyRoles on ar.RoleID equals r.UniqueID
                where a.ApplicationName == ApplicationName
                select new MyUserRole()
                {
                    User = u,
                    Role = r
                }
                );
        }

        private IQueryable<MyRole> QueryRoles(DataMyAuthenticationDataContext db)
        {
            return (
                from ar in db.MyApplicationRoles
                join a in db.MyApplications on ar.ApplicationID equals a.UniqueID
                join r in db.MyRoles on ar.RoleID equals r.UniqueID
                where a.ApplicationName == ApplicationName
                select r
                );
        }

        private IQueryable<MyUser> QueryUsers(DataMyAuthenticationDataContext db)
        {
            return (
                from u in db.MyUsers
                join uar in db.MyUserApplicationRoles on u.UniqueID equals uar.UserID
                join ar in db.MyApplicationRoles on uar.ApplicationRoleID equals ar.UniqueID
                join a in db.MyApplications on ar.ApplicationID equals a.UniqueID
                where a.ApplicationName == ApplicationName
                select u
                );
        }

        private MyApplication GetMyApplication(DataMyAuthenticationDataContext db)
        {
            var app = db.MyApplications.Where(a => a.ApplicationName == ApplicationName).SingleOrDefault();
            if (app == null)
            {
                app = new MyApplication()
                {
                    ApplicationName = ApplicationName,
                    IsEnabled = true
                };
                db.MyApplications.InsertOnSubmit(app);
                db.SubmitChanges();
            }
            return app;
        }

        public override void CreateRole(string roleName)
        {
            if (string.IsNullOrEmpty(roleName))
                throw new ArgumentNullException("RoleName can not be null");

            using (DataMyAuthenticationDataContext db = new DataMyAuthenticationDataContext())
            {
                var role = QueryRoles(db).Where(r => r.RoleName == roleName).SingleOrDefault();

                if (role == null)
                {
                    role = db.MyRoles.Where(r => r.RoleName == roleName).SingleOrDefault();
                    if (role == null)
                    {
                        role = new MyRole() { RoleName = roleName };
                        db.MyRoles.InsertOnSubmit(role);
                        db.SubmitChanges();
                    }

                    var app = GetMyApplication(db);

                    var appRole = app.MyApplicationRoles.Where(r => r.RoleID == role.UniqueID).SingleOrDefault();
                    if (appRole == null)
                    {
                        appRole = new MyApplicationRole()
                        {
                            ApplicationID = app.UniqueID,
                            RoleID = role.UniqueID
                        };
                        db.MyApplicationRoles.InsertOnSubmit(appRole);
                        db.SubmitChanges();
                    }
                }
                else
                    throw new ProviderException("Role already exists");
            }
        }

        public override string[] GetAllRoles()
        {
            using (DataMyAuthenticationDataContext db = new DataMyAuthenticationDataContext())
            {
                return QueryRoles(db).Select(r => r.RoleName).ToArray();
            }
        }

        public override string[] GetRolesForUser(string username)
        {
            if (string.IsNullOrEmpty(username))
                throw new ArgumentNullException("UserName can not be null");

            using (DataMyAuthenticationDataContext db = new DataMyAuthenticationDataContext())
            {
                return QueryUserRoles(db).Where(ur => ur.User.UserName == username).Select(ur => ur.Role.RoleName).ToArray();
            }
        }

        public override string[] GetUsersInRole(string roleName)
        {
            if (string.IsNullOrEmpty(roleName))
                throw new ArgumentNullException("RoleName can not be null");

            using (DataMyAuthenticationDataContext db = new DataMyAuthenticationDataContext())
            {
                return QueryUserRoles(db).Where(ur => ur.Role.RoleName == roleName).Select(ur => ur.User.UserName).ToArray();
            }
        }

        public override bool IsUserInRole(string username, string roleName)
        {
            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(roleName))
                throw new ArgumentNullException("UserName and RoleName can not be null");

            using (DataMyAuthenticationDataContext db = new DataMyAuthenticationDataContext())
            {
                var user = QueryUsers(db).Where(u => u.UserName == username).SingleOrDefault();
                if (user == null)
                    return false;
                //throw new ProviderException("User does not exist");

                var role = QueryRoles(db).Where(r => r.RoleName == roleName).SingleOrDefault();
                if (user == null)
                    return false;
                //throw new ProviderException("Role does not exist");

                return QueryUserRoles(db).Where(ur => ur.Role.RoleName == roleName && ur.User.UserName == username).SingleOrDefault() != null;
                //QueryUserRoles(db).Where(ur => ur.Role.RoleName == roleName && ur.User.UserName == username).Select(ur => ur.User.UserName).ToArray();
            }
        }

        public override void RemoveUsersFromRoles(string[] usernames, string[] roleNames)
        {
            if (usernames.Where(u => string.IsNullOrEmpty(u)).Count() > 0 ||
                roleNames.Where(r => string.IsNullOrEmpty(r)).Count() > 0
                )
                throw new ArgumentNullException("user names and role names not not be null");

            using (DataMyAuthenticationDataContext db = new DataMyAuthenticationDataContext())
            {
                foreach (var role in roleNames)
                {
                    foreach (var user in usernames)
                    {
                        var urs =
                            from qu in db.MyUsers
                            join uar in db.MyUserApplicationRoles on qu.UniqueID equals uar.UserID
                            join ar in db.MyApplicationRoles on uar.ApplicationRoleID equals ar.UniqueID
                            join qr in db.MyRoles on ar.RoleID equals qr.UniqueID
                            join a in db.MyApplications on ar.ApplicationID equals a.UniqueID
                            where a.ApplicationName == ApplicationName
                                  && qu.UserName == user
                                  && qr.RoleName == role                                    
                            select uar;
                        db.MyUserApplicationRoles.DeleteAllOnSubmit(urs);
                    }
                }

                db.SubmitChanges();
            }
        }

        public override bool RoleExists(string roleName)
        {
            if (string.IsNullOrEmpty(roleName))
                throw new ArgumentNullException("RoleName can not be null");

            using (DataMyAuthenticationDataContext db = new DataMyAuthenticationDataContext())
            {
                return QueryRoles(db).Where(r => r.RoleName == roleName).SingleOrDefault() != null;
            }
        }

        public override void AddUsersToRoles(string[] usernames, string[] roleNames)
        {
            if (roleNames == null || usernames == null)
                return;

            foreach (var role in roleNames.Where(u => !this.RoleExists(u)))
                this.CreateRole(role);

            using (DataMyAuthenticationDataContext db = new DataMyAuthenticationDataContext())
            {
                var app = GetMyApplication(db);

                var users = db.MyUsers.Where(u => usernames.Contains(u.UserName));
                var roles = db.MyApplicationRoles.Where(ar => roleNames.Contains(ar.MyRole.RoleName));

                var appRoles = from uar in db.MyUserApplicationRoles
                               join u in users on uar.UserID equals u.UniqueID
                               join r in roles on uar.ApplicationRoleID equals r.RoleID
                               select uar;

                var missingUserNames = usernames.Except(appRoles.Select(ar => ar.MyUser.UserName));

                var missingUsers = users.Where(u => missingUserNames.Contains(u.UserName));

                var newUsers = new List<MyUserApplicationRole>();
                foreach (var missingUser in missingUsers)
                {
                    newUsers.AddRange(
                        roles.AsEnumerable().Select(r => new MyUserApplicationRole()
                        {
                            ApplicationRoleID = r.UniqueID,
                            UserID = missingUser.UniqueID
                        }
                    ));
                }

                if (newUsers.Count() > 0)
                {
                    db.MyUserApplicationRoles.InsertAllOnSubmit(newUsers);
                    db.SubmitChanges();
                }

                //Takes as input a list of user names and a list of role names, and associates the specified users with the specified roles at the data source for the configured ApplicationName. 
                //You should throw a ProviderException if any of the role names or user names specified do not exist for the configured ApplicationName. 
                //You should throw an ArgumentException if any of the specified user names or role names is an empty string and an ArgumentNullException if any of the specified user names or role names is null (Nothing in Visual Basic). 
                //If your data source supports transactions, you should include each add operation in a transaction and roll back the transaction and throw an exception if any add operation fails. 
            }
        }

        public override bool DeleteRole(string roleName, bool throwOnPopulatedRole)
        {
            if (string.IsNullOrEmpty(roleName))
                throw new ArgumentNullException("RoleName can not be null");

            using (DataMyAuthenticationDataContext db = new DataMyAuthenticationDataContext())
            {
                var role = QueryRoles(db).Where(r => r.RoleName == roleName).SingleOrDefault();

                if (role == null)
                    throw new ArgumentException("RoleName can not be found");

                //TODO: delete role is not supported at this time
                throw new NotImplementedException();
                //    if (throwOnPopulatedRole)
                //    {
                //        if (db.MyUserApplicationRoles.Where(uar => uar.RoleID == role.UniqueID).Count() > 0)
                //            throw new ProviderException("Role has members");
                //    }
                //    else
                //    {
                //        var uars = db.MyUserApplicationRoles.Where(uar => uar.RoleID == role.UniqueID);
                //        db.MyUserApplicationRoles.DeleteAllOnSubmit(uars);
                //    }

                //    db.MyRoles.DeleteOnSubmit(role);
                //    db.SubmitChanges();
            }
        }

        public override string[] FindUsersInRole(string roleName, string usernameToMatch)
        {
            //if (string.IsNullOrEmpty(roleName))
            //    throw new ArgumentNullException("RoleName can not be null");

            //using (DataMyAuthenticationDataContext db = new DataMyAuthenticationDataContext())
            //{
            //    var role = db.MyRoles.Where(r => r.RoleName == roleName);

            //    var users = db.MyUsers.Where(u => u.UserName.Contains(usernameToMatch));

            //    var appid = db.MyApplications.Where(a => a.ApplicationName == ApplicationName).Single().UniqueID;

            //    var uars = from uar in db.MyUserApplicationRoles
            //               join r in role on uar.RoleID equals r.UniqueID
            //               join u in users on uar.UserID equals u.UniqueID
            //               where uar.ApplicationID == appid
            //               select u.UserName;

            //    return uars.ToArray();
            //}

            //TODO: FindUsersInRole  NotImplementedException
            throw new NotImplementedException();
        }
    }
}