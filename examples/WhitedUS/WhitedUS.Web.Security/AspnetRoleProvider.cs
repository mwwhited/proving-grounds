using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Web.Security;
using WhitedUS.Shared.Data;
using WhitedUS.Shared.Models.Security;

namespace WhitedUS.Web.Security
{
    public class AspnetRoleProvider : RoleProvider
    {
        public AspnetRoleProvider()
        {
        }

        public override void Initialize(string name, NameValueCollection config)
        {
            base.Initialize(name, config);

            this.Name = name;
            this.ApplicationName = config["applicationName"];
            this.ConnectionString = config["connectionString"];
        }

        private SharedEntities GetDataContext()
        {
            return SharedEntities.Factory(this.ConnectionString);
        }

        public string Name { get; private set; }
        public string ConnectionString { get; private set; }

        public override string ApplicationName { get; set; }

        private Guid _applicationId;
        private Guid ApplicationID
        {
            get
            {
                if (this._applicationId == Guid.Empty)
                {
                    using (var db = this.GetDataContext())
                        this._applicationId = db.Applications
                                                .Where(a => a.Name == this.ApplicationName)
                                                .Select(a => a.ApplicationID)
                                                .Single()
                                                ;
                }
                return _applicationId;
            }
        }

        public override void CreateRole(string roleName)
        {
            using (var db = this.GetDataContext())
            {
                var entity = new Role
                {
                    ApplicationID = this.ApplicationID,
                    Name = roleName,
                    RoleID = Guid.NewGuid(),
                };

                db.Roles.AddObject(entity);
                db.SaveChanges();
            }
        }
        public override bool DeleteRole(string roleName, bool throwOnPopulatedRole)
        {
            using (var db = this.GetDataContext())
            {
                var role = db.Roles.Where(r => r.Name == roleName && r.ApplicationID == this.ApplicationID).SingleOrDefault();

                if (role == null)
                    return true;

                if (throwOnPopulatedRole && role.Users.Any())
                    throw new ApplicationException("Role still has users assigned");

                db.Roles.DeleteObject(role);
                db.SaveChanges();

                return true;
            }
        }
        public override string[] GetAllRoles()
        {
            using (var db = this.GetDataContext())
                return db.Roles.Select(r => r.Name).ToArray();
        }
        public override bool RoleExists(string roleName)
        {
            using (var db = this.GetDataContext())
                return db.Roles.Any(r => r.Name == roleName && r.ApplicationID == this.ApplicationID);
        }
        public override bool IsUserInRole(string username, string roleName)
        {
            using (var db = this.GetDataContext())
            {
                var query = from role in db.Roles
                            where role.Name == roleName
                                && role.ApplicationID == this.ApplicationID
                                && role.Users.Any(u => u.UserName == username)
                            select role;
                return query.Any();
            }
        }

        public override string[] FindUsersInRole(string roleName, string usernameToMatch)
        {
            using (var db = this.GetDataContext())
            {
                var query = from role in db.Roles
                            where role.Name == roleName
                                && role.ApplicationID == this.ApplicationID
                            from user in role.Users
                            where user.UserName.Contains(usernameToMatch)
                            select user.UserName;

                var result = query.ToArray();

                return result;
            }
        }
        public override string[] GetRolesForUser(string username)
        {
            using (var db = this.GetDataContext())
            {
                var query = from user in db.Users
                            where user.UserName == username
                            from role in user.Roles
                            select role.Name;
                var result = query.ToArray();
                return result;
            }
        }
        public override string[] GetUsersInRole(string roleName)
        {
            using (var db = this.GetDataContext())
            {
                var query = from role in db.Roles
                            where role.Name == roleName
                            from user in role.Users
                            select user.UserName;
                var result = query.ToArray();
                return result;
            }
        }
        public override void RemoveUsersFromRoles(string[] usernames, string[] roleNames)
        {
            using (var db = this.GetDataContext())
            {
                var users = db.Users.Where(user => usernames.Contains(user.UserName)).ToList();
                var roles = db.Roles.Where(role => roleNames.Contains(role.Name)).ToList();

                foreach (var user in users)
                    foreach (var role in roles)
                        if (user.Roles.Any(r => r.Name == role.Name))
                            user.Roles.Remove(role);

                db.SaveChanges();
            }
        }

        public override void AddUsersToRoles(string[] usernames, string[] roleNames)
        {
            using (var db = this.GetDataContext())
            {
                var users = db.Users.Where(user => usernames.Contains(user.UserName)).ToList();
                var roles = db.Roles.Where(role => roleNames.Contains(role.Name)).ToList();

                foreach (var user in users)
                    foreach (var role in roles)
                        if (!user.Roles.Any(r => r.Name == role.Name))
                            user.Roles.Add(role);

                db.SaveChanges();
            }
        }
    }
}
