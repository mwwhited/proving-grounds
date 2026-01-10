using Originations.DataProviders.SecurityManagement.LdapFilters;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.DirectoryServices;
using System.Linq;
using System.Reflection;

namespace Originations.DataProviders.SecurityManagement
{
    public class LdapConnector : ILdapConnector
    {
        private readonly ILdapConfigProvider _config;
        private readonly ILdapContextMapper _mapper;

        public LdapConnector(
            ILdapConfigProvider configProvider,
            ILdapContextMapper mapper
            )
        {
            _config = configProvider;
            _mapper = mapper;
        }

        // https://msdn.microsoft.com/en-us/library/windows/desktop/ms697760%28v=vs.100%29.aspx
        public void SetPassword(string username, string newPassword)
        {
            SetPassword(username, newPassword, true);
        }
        public void SetPassword(string username, string newPassword, bool expirePassword)
        {
            if (string.IsNullOrWhiteSpace(username))
            {
                throw new ArgumentNullException("username");
            }
            if (string.IsNullOrWhiteSpace(newPassword))
            {
                throw new ArgumentNullException("newPassword");
            }

            var userPath = GetDnForUser(username, ensureExists: true);
            _mapper.EnsureNotAdmin(userPath);

            var userUrl = _mapper.BuildUrl(userPath);
            using (var entry = _mapper.AdminBinding(userUrl))
            {
                try
                {
                    if (!_config.IsSecure)
                    {
                        entry.Invoke("SetOption", 6/*ADS_OPTION_PASSWORD_PORTNUMBER*/, _config.HostPort);
                        entry.Invoke("SetOption", 7/*ADS_OPTION_PASSWORD_METHOD*/, 1/*ADS_PASSWORD_ENCODE_CLEAR*/);
                    }
                    entry.Invoke("SetPassword", newPassword);

                    //reset site minder status, GPSM-6649
                    entry.Properties[_config.SiteMinderStatusAttribute].Value = 0;

                    if (expirePassword)
                    {
                        //do this always for AD LDS.. doesn't matter if configured for AD or siteminder
                        //force AD password expired
                        entry.Properties[_config.LastPasswordChangedAttribute].Value = 0;
                    }

                    entry.CommitChanges();
                }
                catch (TargetInvocationException ex)
                {
                    throw ex.InnerException;
                }
            }
        }

        public void ChangePassword(string username, string oldPassword, string newPassword)
        {
            if (string.IsNullOrWhiteSpace(username))
            {
                throw new ArgumentNullException("username");
            }
            if (string.IsNullOrWhiteSpace(oldPassword))
            {
                throw new ArgumentNullException("oldPassword");
            }
            if (string.IsNullOrWhiteSpace(newPassword))
            {
                throw new ArgumentNullException("newPassword");
            }

            if (string.Equals(oldPassword, newPassword, StringComparison.InvariantCultureIgnoreCase))
            {
                throw new InvalidOperationException("Password must be different by more than case");
            }

            var userPath = GetDnForUser(username, ensureExists: true);
            _mapper.EnsureNotAdmin(userPath);
            var userUrl = _mapper.BuildUrl(userPath);
            using (var entry = _mapper.UserBinding(userUrl, userPath, oldPassword))
            {
                try
                {
                    if (!_config.IsSecure)
                    {
                        entry.Invoke("SetOption", 6/*ADS_OPTION_PASSWORD_PORTNUMBER*/, _config.HostPort);
                        entry.Invoke("SetOption", 7/*ADS_OPTION_PASSWORD_METHOD*/, 1/*ADS_PASSWORD_ENCODE_CLEAR*/);
                    }
                    entry.Invoke("ChangePassword", oldPassword, newPassword);

                    entry.CommitChanges();
                }
                catch (TargetInvocationException ex)
                {
                    throw ex.InnerException;
                }
            }
        }

        public bool CheckPassword(string username, string password)
        {
            if (string.IsNullOrWhiteSpace(username))
            {
                throw new ArgumentNullException("username");
            }
            if (string.IsNullOrWhiteSpace(password))
            {
                throw new ArgumentNullException("password");
            }
            var userPath = GetDnForUser(username, ensureExists: true);
            _mapper.EnsureNotAdmin(userPath);

            var userUrl = _mapper.BuildUrl(userPath);
            using (var entry = _mapper.UserBinding(userUrl, userPath, password))
            {
                try
                {
                    entry.RefreshCache();
                    return true;
                }
                catch (DirectoryServicesCOMException dsce)
                {
                    Debug.WriteLine("CheckPassword: {0}", dsce);
                    return false;
                }
            }
        }

        public ILdapUserDetailed CreateUser(string container, string username)
        {
            if (string.IsNullOrWhiteSpace(container))
            {
                throw new ArgumentNullException("container");
            }
            if (string.IsNullOrWhiteSpace(username))
            {
                throw new ArgumentNullException("username");
            }

            var userPath = _mapper.BuildPath(container, username);
            _mapper.EnsureNotAdmin(userPath);

            var containerPath = _mapper.BuildPath(container);
            var containerUrl = _mapper.BuildUrl(containerPath);
            using (var entry = _mapper.AdminBinding(containerUrl))
            {
                var newUser = entry.Children.Add(string.Format("{0}={1}", _config.CommonNameAttribute, username), _config.UserSchemaClass);
                newUser.CommitChanges();

                var found = FindUserByGuid(new Guid((byte[])newUser.Properties[_config.ObjectGuidAttribute].Value));
                return found;
            }
        }

        public ILdapUserDetailed SaveUser(ILdapUserEditable user, string password)
        {
            if (user == null)
            {
                throw new ArgumentNullException("user");
            }

            var lookup = FindUserByGuid(user.ObjectGuid);
            if (lookup == null)
            {
                if (user.ObjectGuid != Guid.Empty)
                {
                    throw new InvalidOperationException(string.Format("User \"{0}\" ({1}) not found", user.Username, user.ObjectGuid));
                }
                else //create
                {
                    lookup = CreateUser(user.Container, user.Username);
                    user.ObjectGuid = lookup.ObjectGuid;
                    user.Username = lookup.Username;
                }
            }

            //reset provided username and contrainer to ensure they match found version
            user.Container = lookup.Container;
            user.Username = lookup.Username;

            if (!string.IsNullOrWhiteSpace(password)) //if pasword is provided that set the password to _mapper value
            {
                SetPassword(user.Username, password);
            }

            _mapper.SetProperties(user.Container, user.Username, new Dictionary<string, object>
            {
                { _config.FirstNameAttribute, user.FirstName },
                { _config.LastNameAttribute, user.LastName },
                { _config.EmailAttribute, user.Email },
                { _config.DisabledUserAttribute, !user.IsEnabled },
                //{ _config.DisplayNameAttribute, string.Join(" ",  user.FirstName , user.LastName) },
            });

            var found = FindUserByGuid(user.ObjectGuid); //ensure latest data
            if (user.Groups != null)
            {
                var paths = new[] { found.FullPath };

                var existing = (from g in found.Groups ?? Enumerable.Empty<ILdapGroupDetailed>()
                                select new
                                {
                                    Container = g.Container.ToUpperInvariant(),
                                    GroupName = g.GroupName.ToUpperInvariant(),
                                }).ToList();

                var toAdd = from g in user.Groups ?? Enumerable.Empty<ILdapGroupEditable>()
                            where g.OperationType == 1  //INSERT
                            let add = new
                            {
                                Container = g.Container.ToUpperInvariant(),
                                GroupName = g.GroupName.ToUpperInvariant(),
                            }
                            where !existing.Contains(add) //only need to remove groups that don't exist
                            select add;

                var toRemove = from g in user.Groups ?? Enumerable.Empty<ILdapGroupEditable>()
                               where g.OperationType == 2  //DELETE
                               let remove = new
                               {
                                   Container = g.Container.ToUpperInvariant(),
                                   GroupName = g.GroupName.ToUpperInvariant(),
                               }
                               where existing.Contains(remove) //only need to remove groups that exist
                               select remove;

                foreach (var group in toAdd)
                {
                    AddGroupMembers(group.Container, group.GroupName, paths);
                }
                foreach (var group in toRemove)
                {
                    RemoveGroupMembers(group.Container, group.GroupName, paths);
                }

                found = FindUserByGuid(user.ObjectGuid); //ensure lastest after group updates
            }
            return found;
        }

        public ILdapGroupDetailed CreateGroup(string container, string groupName)
        {
            if (string.IsNullOrWhiteSpace(container))
            {
                throw new ArgumentNullException("container");
            }
            if (string.IsNullOrWhiteSpace(groupName))
            {
                throw new ArgumentNullException("groupName");
            }

            var groupPath = _mapper.BuildPath(container, groupName);
            _mapper.EnsureNotAdmin(groupPath);

            var containerPath = _mapper.BuildPath(container);
            var containerUrl = _mapper.BuildUrl(containerPath);
            using (var entry = _mapper.AdminBinding(containerUrl))
            {
                var newGroup = entry.Children.Add(string.Format("{0}={1}", _config.CommonNameAttribute, groupName), _config.GroupSchemaClass);
                newGroup.CommitChanges();

                var found = FindGroupByGuid(new Guid((byte[])newGroup.Properties[_config.ObjectGuidAttribute].Value));
                return found;
            }
        }

        public void DeleteGroup(string container, string groupName)
        {
            if (string.IsNullOrWhiteSpace(container))
            {
                throw new ArgumentNullException("container");
            }
            if (string.IsNullOrWhiteSpace(groupName))
            {
                throw new ArgumentNullException("groupName");
            }

            var groupPath = _mapper.BuildPath(container, groupName);
            _mapper.EnsureNotAdmin(groupPath);

            if (!GroupExists(container, groupName))
            {
                return; //group doesn't exist so move on
            }

            var containerPath = _mapper.BuildPath(container);
            var containerUrl = _mapper.BuildUrl(containerPath);
            using (var entry = _mapper.AdminBinding(containerUrl))
            {
                var item = entry.Children.Find(string.Format("{0}={1}", _config.CommonNameAttribute, groupName), _config.GroupSchemaClass);
                entry.Children.Remove(item);
                item.CommitChanges();
            }
        }

        public bool GroupExists(string container, string groupName)
        {
            if (string.IsNullOrWhiteSpace(container))
            {
                throw new ArgumentNullException("container");
            }
            if (string.IsNullOrWhiteSpace(groupName))
            {
                throw new ArgumentNullException("groupName");
            }

            var path = _mapper.BuildPath(container, groupName);
            var item = _mapper.FindGroups(container, new LdapEqualsFilter(_config.DistinguishedNameAttribute, path)).FirstOrDefault();
            return item != null;
        }

        public void AddGroupMembers(string container, string groupName, IEnumerable<string> memberDns)
        {
            if (string.IsNullOrWhiteSpace(container))
            {
                throw new ArgumentNullException("container");
            }
            if (string.IsNullOrWhiteSpace(groupName))
            {
                throw new ArgumentNullException("groupName");
            }
            if (memberDns == null)
            {
                throw new ArgumentNullException("memberDns");
            }

            if (!GroupExists(container, groupName))
            {
                CreateGroup(container, groupName);
            }

            var groupPath = _mapper.BuildPath(container, groupName);
            var groupUrl = _mapper.BuildUrl(groupPath);
            using (var entry = _mapper.AdminBinding(groupUrl))
            {
                var members = entry.Properties[_config.MemberAttribute];

                var existing = members.Cast<string>().Select(i => i.ToUpperInvariant());
                var newMembers = memberDns.Select(i => i.ToUpperInvariant()).Except(existing).Cast<object>().ToArray();
                if (newMembers.Any())
                {
                    members.AddRange(newMembers);
                    entry.CommitChanges();
                }
            }
        }

        public void RemoveGroupMembers(string container, string groupName, IEnumerable<string> memberDns)
        {
            if (string.IsNullOrWhiteSpace(container))
            {
                throw new ArgumentNullException("container");
            }
            if (string.IsNullOrWhiteSpace(groupName))
            {
                throw new ArgumentNullException("groupName");
            }
            if (memberDns == null)
            {
                throw new ArgumentNullException("memberDns");
            }

            if (!GroupExists(container, groupName))
            {
                return; //Group doesn't exist so there is not reason to try to remove users
            }

            var groupPath = _mapper.BuildPath(container, groupName);
            var groupUrl = _mapper.BuildUrl(groupPath);
            using (var entry = _mapper.AdminBinding(groupUrl))
            {
                var members = entry.Properties[_config.MemberAttribute];

                var existing = members.Cast<string>().Select(i => i.ToUpperInvariant());
                var removeMembers = memberDns.Select(i => i.ToUpperInvariant()).Intersect(existing).Cast<object>().ToArray();

                if (removeMembers.Any())
                {
                    foreach (var removeMember in removeMembers)
                    {
                        members.Remove(removeMember);
                    }
                    entry.CommitChanges();
                }

                entry.RefreshCache();
                if (entry.Properties[_config.MemberAttribute].Count == 0)
                {
                    DeleteGroup(container, groupName);
                }
            }
        }

        public void DeleteUser(string container, string username)
        {
            if (string.IsNullOrWhiteSpace(container))
            {
                throw new ArgumentNullException("container");
            }
            if (string.IsNullOrWhiteSpace(username))
            {
                throw new ArgumentNullException("username");
            }

            var userPath = GetDnForUser(username, ensureExists: true);
            _mapper.EnsureNotAdmin(userPath);

            if (!UserExists(username))
            {
                return; //User doesn't exist so move on
            }

            var containerPath = _mapper.BuildPath(container);
            var containerUrl = _mapper.BuildUrl(containerPath);
            using (var entry = _mapper.AdminBinding(containerUrl))
            {
                var user = entry.Children.Find(string.Format("{0}={1}", _config.CommonNameAttribute, username), _config.UserSchemaClass);
                entry.Children.Remove(user);
                user.CommitChanges();
            }
        }

        public bool UserExists(string username)
        {
            if (string.IsNullOrWhiteSpace(username))
            {
                throw new ArgumentNullException("username");
            }

            var item = _mapper.FindUsers(null, new LdapEqualsFilter(_config.CommonNameAttribute, username)).FirstOrDefault();
            return item != null;
        }

        public void RenameUser(string container, string existingUsername, string newUsername)
        {
            if (string.IsNullOrWhiteSpace(container))
            {
                throw new ArgumentNullException("container");
            }
            if (string.IsNullOrWhiteSpace(existingUsername))
            {
                throw new ArgumentNullException("existingUsername");
            }
            if (string.IsNullOrWhiteSpace(newUsername))
            {
                throw new ArgumentNullException("newUsername");
            }

            var existingUserPath = _mapper.BuildPath(container, existingUsername);
            var newUserPath = _mapper.BuildPath(container, newUsername);

            if (_config.AdminUserName.Equals(existingUserPath, StringComparison.InvariantCultureIgnoreCase) ||
                 _config.AdminUserName.Equals(newUserPath, StringComparison.InvariantCultureIgnoreCase))
            {
                throw new InvalidOperationException("Function not allowed for admin account");
            }

            var containerPath = _mapper.BuildPath(container);
            var containerUrl = _mapper.BuildUrl(containerPath);
            using (var entry = _mapper.AdminBinding(containerUrl))
            {
                var existingEntry = entry.Children.Find("cn=" + existingUsername);
                existingEntry.MoveTo(entry, "cn=" + newUsername);
            }
        }

        public void EnableUser(string username, string container)
        {
            if (string.IsNullOrWhiteSpace(container))
            {
                var user = FindUser(username, ensureExists: true);
                container = user.Container;
            }
            _mapper.SetProperty(container, username, _config.DisabledUserAttribute, false);
        }

        public void DisableUser(string username, string container)
        {
            if (string.IsNullOrWhiteSpace(container))
            {
                var user = FindUser(username, ensureExists: false);
                if (user == null)
                {
                    return; //User not found so nothing to disable
                }
                container = user.Container;
            }
            _mapper.SetProperty(container, username, _config.DisabledUserAttribute, true);
        }

        public bool IsUserEnabled(string username, string container)
        {
            if (string.IsNullOrWhiteSpace(container))
            {
                var user = FindUser(username, ensureExists: false);
                if (user == null)
                {
                    return false; //User not found so disabled
                }
                container = user.Container;
            }
            //the property is "disabled" value and should be considered "not" disabled if not set
            return !(_mapper.GetProperty<bool?>(container, username, propertyName: _config.DisabledUserAttribute) ?? false);
        }

        public IEnumerable<ILdapUserDetailed> ListUsers(string container)
        {
            if (string.IsNullOrWhiteSpace(container))
            {
                container = null;
            }
            return _mapper.FindUsers(container: container, ldapFilter: null);
        }

        public IEnumerable<ILdapUserDetailed> ListEnabledUsers(string container)
        {
            if (string.IsNullOrWhiteSpace(container))
            {
                container = null;
            }
            return _mapper.FindUsers(container, new LdapNotFilter(new LdapEqualsFilter(_config.DisabledUserAttribute, "TRUE")));
        }

        public IEnumerable<ILdapUserDetailed> ListDisabledUsers(string container)
        {
            return _mapper.FindUsers(container, new LdapEqualsFilter(_config.DisabledUserAttribute, "TRUE"));
        }

        public IEnumerable<ILdapUserDetailed> ListUsersByLoginDates(string container, DateTime start, DateTime end)
        {
            return _mapper.FindUsers(container,
                new LdapAndFilter(
                    new LdapSimpleFilter(_config.LastLoginAttribute, LdapFilterTypes.GreaterThanOrEqualTo, start),
                    new LdapSimpleFilter(_config.LastLoginAttribute, LdapFilterTypes.LessThanOrEqualTo, end)
                    )
                );
        }

        public IEnumerable<ILdapGroupDetailed> ListAllGroups()
        {
            var groups = _mapper.FindGroups(null, null);
            return groups;
        }

        public IEnumerable<ILdapUserDetailed> ListGroupMembers(string container, string groupName)
        {
            if (string.IsNullOrWhiteSpace(container))
            {
                throw new ArgumentNullException("container");
            }
            if (string.IsNullOrWhiteSpace(groupName))
            {
                throw new ArgumentNullException("groupName");
            }

            var groupDn = _mapper.BuildPath(container, groupName);
            return ListGroupMembers(groupDn);
        }


        public IEnumerable<ILdapUserDetailed> ListGroupMembers(string groupDn)
        {
            if (string.IsNullOrWhiteSpace(groupDn))
            {
                throw new ArgumentNullException("groupDn");
            }

            return _mapper.FindUsers(container: null, ldapFilter: new LdapEqualsFilter(_config.MemberOfAttribute, groupDn));
        }

        public ILdapUserDetailed FindUserByGuid(Guid objectGuid)
        {
            return _mapper.FindUsers(container: null, ldapFilter: new LdapEqualsFilter(_config.ObjectGuidAttribute, objectGuid)).SingleOrDefault();
        }

        public ILdapUserDetailed FindUser(string username)
        {
            return FindUser(username, ensureExists: false);
        }
        public ILdapUserDetailed FindUser(string username, bool ensureExists)
        {
            if (string.IsNullOrWhiteSpace(username))
            {
                throw new ArgumentNullException("username");
            }

            var user = _mapper.FindUsers(container: null, ldapFilter: new LdapEqualsFilter(_config.CommonNameAttribute, username)).SingleOrDefault();
            if (user == null && ensureExists)
            {
                throw new InvalidOperationException(string.Format("user not found: \"{0}\"", username));
            }
            return user;
        }

        public string GetSuggestedUsername(string username)
        {
            if (string.IsNullOrWhiteSpace(username))
            {
                throw new ArgumentNullException("username");
            }

            var foundUsers = _mapper.FindUsers(container: null, ldapFilter: new LdapStartsWith(_config.CommonNameAttribute, username)).Select(u => u.Username.ToUpperInvariant()).ToArray();

            var nextNumber = 1;
            var tryUser = username;
            while (foundUsers.Contains(tryUser.ToUpperInvariant()))
            {
                tryUser = username + nextNumber;
                nextNumber++;
            }
            return tryUser;
        }

        public ILdapGroupDetailed FindGroupByGuid(Guid objectGuid)
        {
            return _mapper.FindGroups(container: null, ldapFilter: new LdapEqualsFilter(_config.ObjectGuidAttribute, objectGuid)).SingleOrDefault();
        }

        public void UnlockUser(string username, string container)
        {
            if (string.IsNullOrWhiteSpace(container))
            {
                var user = FindUser(username, ensureExists: true);
                container = user.Container;
            }

            if (_config.ProviderType == SecurityProviderTypes.SiteMinder)
            {
                //clear possibled disabled mask
                _mapper.UpdateSiteMinderStatus(container, username, SiteMinderStatus.None);
            }

            _mapper.SetProperty(container, username, _config.LockoutTimeAttribute, 0);
        }

        public void ForcePasswordChange(string username, string container)
        {
            if (string.IsNullOrWhiteSpace(container))
            {
                var user = FindUser(username, ensureExists: true);
                container = user.Container;
            }
            _mapper.SetProperty(container, username, _config.LastPasswordChangedAttribute, 0);
        }


        private string GetDnForUser(string username, bool ensureExists)
        {
            var user = this.FindUser(username, ensureExists);
            if (user == null)
            {
                return null;
            }
            return user.FullPath;
        }

        public ILdapUserDetailed SaveUser(ILdapUserEditable user)
        {
            return SaveUser(user, null);
        }

        public IEnumerable<ILdapUserDetailed> ListUsers()
        {
            return ListUsers(null);
        }

        public IEnumerable<ILdapUserDetailed> ListEnabledUsers()
        {
            return ListEnabledUsers(null);
        }

        public IEnumerable<ILdapUserDetailed> ListDisabledUsers()
        {
            return ListDisabledUsers(null);
        }
        public IEnumerable<ILdapUserDetailed> ListUsersByLoginDates(DateTime start, DateTime end)
        {
            return ListUsersByLoginDates(null, start, end);
        }

        public void EnableUser(string username)
        {
            EnableUser(username, null);
        }

        public void DisableUser(string username)
        {
            DisableUser(username, null);
        }

        public bool IsUserEnabled(string username)
        {
            return IsUserEnabled(username, null);
        }

        public void UnlockUser(string username)
        {
            UnlockUser(username, null);
        }

        public void ForcePasswordChange(string username)
        {
            ForcePasswordChange(username, null);
        }
    }
}
