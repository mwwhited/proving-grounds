using Originations.DataProviders.SecurityManagement.LdapFilters;
using System;
using System.Collections.Generic;
using System.DirectoryServices;
using System.Linq;

namespace Originations.DataProviders.SecurityManagement
{
    public class LdapContextMapper : ILdapContextMapper
    {
        private readonly ILdapConfigProvider _config;
        private readonly IDictionary<SecurityProviderTypes, Func<SearchResult, ISecurityLockoutInfo>> _lockoutMapper;

        public LdapContextMapper(ILdapConfigProvider configProvider)
        {
            this._config = configProvider;

            _lockoutMapper = new Dictionary<SecurityProviderTypes, Func<SearchResult, ISecurityLockoutInfo>>
            {
                {SecurityProviderTypes.SiteMinder, GetSiteMinderLockout },
                {SecurityProviderTypes.ActiveDirectory, GetActiveDirectoryLockout },
            };
        }

        public DirectoryEntry UserBinding(string url, string userName, string password)
        {
            if (_config.IsSecure)
            {
                return new DirectoryEntry(url, userName, password);
            }
            else
            {
                return new DirectoryEntry(url, userName, password, AuthenticationTypes.None);
            }
        }

        public DirectoryEntry AdminBinding(string url)
        {
            return UserBinding(url, _config.AdminUserName, _config.AdminPassword);
        }

        public string BuildPath(string container, string objectName)
        {
            if (!string.IsNullOrWhiteSpace(objectName) && string.IsNullOrWhiteSpace(container))
            {
                throw new ArgumentNullException("container", "if objectName is provided then container is required");
            }

            var path = string.Join(",", new[]
                    {
                       string.IsNullOrWhiteSpace(objectName) ? null :string.Format("{0}={1}", _config.CommonNameAttribute,  objectName),
                       string.IsNullOrWhiteSpace(container) ? null :string.Format("{0}={1}", _config.OrganizationUnitAttribute,  container),
                       string.IsNullOrWhiteSpace(_config.Container) ? null : _config.Container,
                       _config.RootDN,
                    }.Where(p => p != null));
            return path;
        }

        public string BuildUrl(string dn)
        {
            return string.Format("{0}://{1}:{2}/{3}", _config.Schema, _config.HostName, _config.HostPort, dn);
        }

        public void SetProperty<T>(string container, string objectName, string propertyName, T value)
        {
            if (string.IsNullOrWhiteSpace(container))
            {
                throw new ArgumentNullException("container");
            }
            if (string.IsNullOrWhiteSpace(objectName))
            {
                throw new ArgumentNullException("objectName");
            }
            if (string.IsNullOrWhiteSpace(propertyName))
            {
                throw new ArgumentNullException("propertyName");
            }

            var objectPath = BuildPath(container, objectName);
            EnsureNotAdmin(objectPath);
            var objectUrl = this.BuildUrl(objectPath);

            using (var entry = this.AdminBinding(objectUrl))
            {
                entry.Properties[propertyName].Value = value;
                entry.CommitChanges();
            }
        }

        public void SetProperties(string container, string objectName, IEnumerable<KeyValuePair<string, object>> propertValues)
        {
            if (string.IsNullOrWhiteSpace(container))
            {
                throw new ArgumentNullException("container");
            }
            if (string.IsNullOrWhiteSpace(objectName))
            {
                throw new ArgumentNullException("objectName");
            }

            var objectPath = BuildPath(container, objectName);
            EnsureNotAdmin(objectPath);
            var objectUrl = this.BuildUrl(objectPath);

            using (var entry = this.AdminBinding(objectUrl))
            {
                foreach (var propertValue in propertValues.Where(k => !string.IsNullOrWhiteSpace(k.Key)))
                {
                    entry.Properties[propertValue.Key].Value = propertValue.Value;
                }
                entry.CommitChanges();
            }
        }

        public T GetProperty<T>(string container, string objectName, string propertyName)
        {
            if (string.IsNullOrWhiteSpace(container))
            {
                throw new ArgumentNullException("container");
            }
            if (string.IsNullOrWhiteSpace(objectName))
            {
                throw new ArgumentNullException("objectName");
            }
            if (string.IsNullOrWhiteSpace(propertyName))
            {
                throw new ArgumentNullException("propertyName");
            }

            var objectPath = BuildPath(container, objectName);
            EnsureNotAdmin(objectPath);
            var objectUrl = this.BuildUrl(objectPath);

            using (var entry = this.AdminBinding(objectUrl))
            {
                var value = entry.Properties[propertyName].Value;
                var result = (T)value;
                return result;
            }
        }

        public IEnumerable<ILdapUserDetailed> FindUsers(string container, ILdapFilter ldapFilter)
        {
            return FindObjects(_config.UserSchemaClass, MapUserAccount, container, ldapFilter, new[] {
                _config.NameAttribute,
                _config.DistinguishedNameAttribute,
                _config.DisabledUserAttribute,
                _config.ObjectGuidAttribute,

                _config.EmailAttribute,
                _config.FirstNameAttribute,
                _config.LastNameAttribute,

                _config.CreatedAttribute,
                _config.LastLoginAttribute,
                _config.LastModifiedAttribute,
                _config.LastPasswordChangedAttribute,

                _config.MemberOfAttribute,

                _config.LockoutTimeAttribute,
                _config.UserPasswordExpiredAttribute,
                _config.UserAccountControlComputedAttribute,

                _config.SiteMinderStatusAttribute,
            });
        }

        public IEnumerable<ILdapGroupDetailed> FindGroups(string container, ILdapFilter ldapFilter)
        {
            return FindObjects(_config.GroupSchemaClass, MapGroupAccount, container, ldapFilter, new[] {
                    _config.NameAttribute,
                    _config.DistinguishedNameAttribute,
                    _config.ObjectGuidAttribute,

                    _config.CreatedAttribute,
                    _config.LastModifiedAttribute,
                    _config.MemberAttribute,
                });
        }

        public IEnumerable<T> FindObjects<T>(string objectClass, Func<SearchResult, T> mapper, string container, ILdapFilter ldapFilter, string[] propertyToLoad)
        {
            if (string.IsNullOrWhiteSpace(objectClass))
            {
                throw new ArgumentNullException("objectClass", "Missing Object Class Type");
            }
            if (mapper == null)
            {
                throw new ArgumentNullException("mapper");
            }

            var containerPath = BuildPath(container);
            var containerUrl = BuildUrl(containerPath);
            using (var entry = this.AdminBinding(containerUrl))
            using (var searcher = GetSearcher(entry, objectClass, ldapFilter, propertyToLoad))
            {
                var results = from r in searcher.FindAll().Cast<SearchResult>()
                                  //resolve DN for object
                              let dn = r.Properties[_config.DistinguishedNameAttribute].Cast<string>().First()
                              //exclude object if matches configured admin
                              where !_config.AdminUserName.Equals(dn, StringComparison.InvariantCultureIgnoreCase)
                              select r;
                foreach (var result in results)
                {
                    yield return mapper(result);
                }
            }
        }


        public DirectorySearcher GetSearcher(DirectoryEntry entry, string objectClass, ILdapFilter ldapFilter, string[] propertiesToLoad)
        {
            if (string.IsNullOrWhiteSpace(objectClass))
            {
                throw new ArgumentNullException("objectClass", "Missing Object Class");
            }

            ILdapFilter realFilter = new LdapEqualsFilter(_config.ObjectClassAttribute, objectClass);
            if (ldapFilter != null)
            {
                realFilter = new LdapAndFilter(realFilter, ldapFilter);
            }
            var builder = new LdapFilterBuilder();
            var searchBy = builder.Build(realFilter);
            var searcher = new DirectorySearcher(entry, searchBy, propertiesToLoad);
            return searcher;
        }

        public ILdapUserDetailed MapUserAccount(SearchResult entry)
        {
            if (entry == null) return null;

            var dn = entry.Properties[_config.DistinguishedNameAttribute].Cast<string>().FirstOrDefault();
            var container = dn.Split(',').Skip(1).First().Split('=')[1]; //get the parent container from the DN

            var lockoutMap = _lockoutMapper[_config.ProviderType](entry);

            var mapped = new LdapUserDetailed
            {
                Container = container,
                Username = entry.Properties[_config.NameAttribute].Cast<string>().FirstOrDefault(),
                FullPath = dn,
                IsEnabled = !(entry.Properties[_config.DisabledUserAttribute].Cast<bool?>().FirstOrDefault() ?? false),
                ObjectGuid = new Guid((byte[])entry.Properties[_config.ObjectGuidAttribute][0]),

                Email = entry.Properties[_config.EmailAttribute].Cast<string>().FirstOrDefault(),
                FirstName = entry.Properties[_config.FirstNameAttribute].Cast<string>().FirstOrDefault(),
                LastName = entry.Properties[_config.LastNameAttribute].Cast<string>().FirstOrDefault(),

                Created = entry.Properties[_config.CreatedAttribute].Cast<DateTime?>().FirstOrDefault() ?? DateTime.MinValue,
                LastModified = entry.Properties[_config.LastModifiedAttribute].Cast<DateTime?>().FirstOrDefault() ?? DateTime.MinValue,

                LastLogin = DateTime.FromFileTimeUtc(entry.Properties[_config.LastLoginAttribute].Cast<long?>().FirstOrDefault() ?? 0L),
                LastPasswordChanged = DateTime.FromFileTimeUtc(entry.Properties[_config.LastPasswordChangedAttribute].Cast<long?>().FirstOrDefault() ?? 0L),

                IsLockedOut = lockoutMap.IsLockedout,
                LockoutTime = lockoutMap.LockoutTime,
                IsPasswordExpired = lockoutMap.IsPasswordExpired,

                Groups = (from memberOf in entry.Properties[_config.MemberOfAttribute].Cast<string>()
                          let parts = memberOf.Split(',').Select(i => i.Split('=')[1]).ToArray()
                          select new LdapGroupDetailed
                          {
                              FullPath = memberOf,
                              GroupName = parts[0],
                              Container = parts[1],
                          }).ToArray(),
            };

            return mapped;
        }

        internal ISecurityLockoutInfo GetActiveDirectoryLockout(SearchResult entry)
        {
            var lockoutValue = entry.Properties[_config.LockoutTimeAttribute].Cast<long?>().FirstOrDefault() ?? 0L;
            var lockoutTime = lockoutValue > 0L ? (DateTime?)DateTime.FromFileTimeUtc(lockoutValue) : null;

            var lockoutFlag = 0x0010;
            var userAccountControl = (int)entry.Properties[_config.UserAccountControlComputedAttribute][0];
            var isLockedout = (userAccountControl & lockoutFlag) == lockoutFlag;
            var isPasswordExpired = (entry.Properties[_config.UserPasswordExpiredAttribute].Cast<bool?>().FirstOrDefault() ?? false);

            return new SecurityLockoutInfo
            {
                IsLockedout = isLockedout,
                LockoutTime = lockoutTime,
                IsPasswordExpired = isPasswordExpired,
            };
        }

        private const int SiteMinderDisabledMask = 0x00FFFFFF;
        internal ISecurityLockoutInfo GetSiteMinderLockout(SearchResult entry)
        {
            var statusValue = entry.Properties[_config.SiteMinderStatusAttribute].OfType<string>().FirstOrDefault();

            SiteMinderStatus siteMinderStatus;
            if (!Enum.TryParse(statusValue, out siteMinderStatus))
            {
                siteMinderStatus = SiteMinderStatus.None;
            }

            //Note: filter status based on disabled mask
            siteMinderStatus = (SiteMinderStatus)((int)siteMinderStatus & SiteMinderDisabledMask);

            return new SecurityLockoutInfo
            {
                IsLockedout = siteMinderStatus != SiteMinderStatus.None,
                //Note: SiteMinder doesn't set the lockout time  LockoutTime = null
                //Note: IsPasswordExpired isn't supported on siteminder without disabling the account... instead use password age
            };
        }

        public ILdapGroupDetailed MapGroupAccount(SearchResult entry)
        {
            var dn = entry.Properties[_config.DistinguishedNameAttribute].Cast<string>().FirstOrDefault();
            var container = dn.Split(',').Skip(1).First().Split('=')[1]; //get the parent container from the DN
            var mapped = new LdapGroupDetailed
            {
                Container = container,
                GroupName = entry.Properties[_config.NameAttribute].Cast<string>().FirstOrDefault(),
                FullPath = dn,
                ObjectGuid = new Guid((byte[])entry.Properties[_config.ObjectGuidAttribute][0]),

                Created = entry.Properties[_config.CreatedAttribute].Cast<DateTime?>().FirstOrDefault() ?? DateTime.MinValue,
                LastModified = entry.Properties[_config.LastModifiedAttribute].Cast<DateTime?>().FirstOrDefault() ?? DateTime.MinValue,

                Members = (from member in entry.Properties[_config.MemberAttribute].Cast<string>()
                           let parts = member.Split(',').Select(i => i.Split('=')[1]).ToArray()
                           select new LdapUserDetailed
                           {
                               FullPath = member,
                               Username = parts[0],
                               Container = parts[1],
                           }).ToArray()
            };
            return mapped;
        }

        public void EnsureNotAdmin(string dn)
        {
            if (_config.AdminUserName.Equals(dn, StringComparison.InvariantCultureIgnoreCase))
            {
                throw new InvalidOperationException("Function not allowed for admin account");
            }
        }

        public string BuildPath(string container)
        {
            return BuildPath(container, null);
        }

        public void UpdateSiteMinderStatus(PropertyCollection properties, SiteMinderStatus value)
        {
            properties[_config.SiteMinderStatusAttribute].Value = (int)value;
        }

        public void UpdateSiteMinderStatus(string container, string username, SiteMinderStatus value)
        {
            if (string.IsNullOrWhiteSpace(container))
            {
                throw new ArgumentNullException("container");
            }
            if (string.IsNullOrWhiteSpace(username))
            {
                throw new ArgumentNullException("username");
            }

            var objectPath = BuildPath(container, username);
            EnsureNotAdmin(objectPath);
            var objectUrl = this.BuildUrl(objectPath);

            using (var entry = this.AdminBinding(objectUrl))
            {
                UpdateSiteMinderStatus(entry.Properties, value);
                entry.CommitChanges();
            }
        }
    }
}
