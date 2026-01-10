using OOBFSAM.ServiceFramework;
using System;

namespace Originations.DataProviders.SecurityManagement
{
    public class LdapConfigProvider : ILdapConfigProvider
    {
        private const string LDAP_CONFIG_GROUP = "Ldap";

        public LdapConfigProvider(IConfigurator configurator)
        {
            Schema = configurator.GetProperty(LDAP_CONFIG_GROUP, "Schema", "LDAP");

            HostName = configurator.GetProperty(LDAP_CONFIG_GROUP, "HostName", "");

            int hostPort;
            if (int.TryParse(configurator.GetProperty(LDAP_CONFIG_GROUP, "HostPort", ""), out hostPort))
            {
                HostPort = hostPort;
            }

            bool isSecure;
            if (bool.TryParse(configurator.GetProperty(LDAP_CONFIG_GROUP, "IsSecure", ""), out isSecure))
            {
                IsSecure = isSecure;
            }

            RootDN = configurator.GetProperty(LDAP_CONFIG_GROUP, "RootDN", "dc=oobfs,dc=internet") ?? "";

            var container = configurator.GetProperty(LDAP_CONFIG_GROUP, "Container", "") ?? "";
            if (container.EndsWith(RootDN, StringComparison.InvariantCultureIgnoreCase))
            {
                container = container.Substring(0, container.Length - this.RootDN.Length).Trim(',');
            }
            Container = container;

            AdminUserName = configurator.GetProperty(LDAP_CONFIG_GROUP, "AdminUserName", "");
            AdminPassword = configurator.GetProperty(LDAP_CONFIG_GROUP, "AdminPassword", "");

            UserSchemaClass = configurator.GetProperty(LDAP_CONFIG_GROUP, "UserSchemaClass", "user");
            DisabledUserAttribute = configurator.GetProperty(LDAP_CONFIG_GROUP, "DisabledUserAttribute", "msDS-UserAccountDisabled");
            ObjectGuidAttribute = configurator.GetProperty(LDAP_CONFIG_GROUP, "ObjectGuidAttribute", "objectGUID");

            EmailAttribute = configurator.GetProperty(LDAP_CONFIG_GROUP, "EmailAttribute", "mail");
            FirstNameAttribute = configurator.GetProperty(LDAP_CONFIG_GROUP, "FirstNameAttribute", "givenName");
            LastNameAttribute = configurator.GetProperty(LDAP_CONFIG_GROUP, "LastNameAttribute", "sn");
            DistinguishedNameAttribute = configurator.GetProperty(LDAP_CONFIG_GROUP, "DistinguishedNameAttribute", "distinguishedName");

            CreatedAttribute = configurator.GetProperty(LDAP_CONFIG_GROUP, "CreatedAttribute", "whenCreated");
            LastModifiedAttribute = configurator.GetProperty(LDAP_CONFIG_GROUP, "LastModifiedAttribute", "whenChanged");
            LastLoginAttribute = configurator.GetProperty(LDAP_CONFIG_GROUP, "LastLoginAttribute", "lastLogonTimestamp");
            LastPasswordChangedAttribute = configurator.GetProperty(LDAP_CONFIG_GROUP, "LastPasswordChangedAttribute", "pwdLastSet");
            NameAttribute = configurator.GetProperty(LDAP_CONFIG_GROUP, "NameAttribute", "name");
            MemberOfAttribute = configurator.GetProperty(LDAP_CONFIG_GROUP, "MemberOfAttribute", "memberOf");
            GroupSchemaClass = configurator.GetProperty(LDAP_CONFIG_GROUP, "GroupSchemaClass", "group");
            MemberAttribute = configurator.GetProperty(LDAP_CONFIG_GROUP, "MemberAttribute", "member");

            FsContainerName = configurator.GetProperty(LDAP_CONFIG_GROUP, "FsContainerName", "Internal");
            CommonNameAttribute = configurator.GetProperty(LDAP_CONFIG_GROUP, "CommonNameAttribute", "cn");
            OrganizationUnitAttribute = configurator.GetProperty(LDAP_CONFIG_GROUP, "OrganizationUnitAttribute", "ou");
            ObjectClassAttribute = configurator.GetProperty(LDAP_CONFIG_GROUP, "ObjectClassAttribute", "objectClass");

            LockoutTimeAttribute = configurator.GetProperty(LDAP_CONFIG_GROUP, "LockoutTimeAttribute", "lockoutTime");
            UserPasswordExpiredAttribute = configurator.GetProperty(LDAP_CONFIG_GROUP, "UserPasswordExpiredAttribute", "msDS-UserPasswordExpired");
            UserAccountControlComputedAttribute = configurator.GetProperty(LDAP_CONFIG_GROUP, "UserAccountControlComputedAttribute", "msDS-User-Account-Control-Computed");

            SiteMinderStatusAttribute = configurator.GetProperty(LDAP_CONFIG_GROUP, "SiteMinderStatusAttribute", "oobAccountStatus");

            SecurityProviderTypes providerType;
            var providerTypeName = configurator.GetProperty(LDAP_CONFIG_GROUP, "ProviderType", "SiteMinder");
            if (!Enum.TryParse(providerTypeName, out providerType)) providerType = SecurityProviderTypes.SiteMinder;
            ProviderType = providerType;
        }

        public string Schema { get; private set; }
        public string HostName { get; private set; }
        public int HostPort { get; private set; }
        public bool IsSecure { get; private set; }
        public string RootDN { get; private set; }
        public string Container { get; private set; }
        public string AdminUserName { get; private set; }
        public string AdminPassword { get; private set; }

        public string UserSchemaClass { get; private set; }
        public string DisabledUserAttribute { get; private set; }
        public string ObjectGuidAttribute { get; private set; }
        public string EmailAttribute { get; private set; }
        public string FirstNameAttribute { get; private set; }
        public string LastNameAttribute { get; private set; }
        public string DistinguishedNameAttribute { get; private set; }

        public string CreatedAttribute { get; private set; }
        public string LastLoginAttribute { get; private set; }
        public string LastModifiedAttribute { get; private set; }
        public string LastPasswordChangedAttribute { get; private set; }
        public string NameAttribute { get; private set; }
        public string MemberOfAttribute { get; private set; }
        public string GroupSchemaClass { get; private set; }
        public string MemberAttribute { get; private set; }

        public string FsContainerName { get; private set; }
        public string CommonNameAttribute { get; private set; }
        public string OrganizationUnitAttribute { get; private set; }
        public string ObjectClassAttribute { get; private set; }

        public string LockoutTimeAttribute { get; private set; }
        public string UserPasswordExpiredAttribute { get; private set; }
        public string UserAccountControlComputedAttribute { get; private set; }
        public string SiteMinderStatusAttribute { get; private set; }

        public SecurityProviderTypes ProviderType { get; private set; }
    }
}
