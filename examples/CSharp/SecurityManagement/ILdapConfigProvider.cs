namespace Originations.DataProviders.SecurityManagement
{
    public interface ILdapConfigProvider
    {
        string AdminPassword { get; }
        string AdminUserName { get; }
        string Container { get; }
        string HostName { get; }
        int HostPort { get; }
        bool IsSecure { get; }
        string Schema { get; }
        string RootDN { get; }
        string UserSchemaClass { get; }
        string DisabledUserAttribute { get; }
        string ObjectGuidAttribute { get; }
        string EmailAttribute { get; }
        string FirstNameAttribute { get; }
        string LastNameAttribute { get; }
        string DistinguishedNameAttribute { get; }
        string CreatedAttribute { get; }
        string LastLoginAttribute { get; }
        string LastModifiedAttribute { get; }
        string LastPasswordChangedAttribute { get; }
        string NameAttribute { get; }
        string MemberOfAttribute { get; }
        string GroupSchemaClass { get; }
        string MemberAttribute { get; }
        string FsContainerName { get; }
        string CommonNameAttribute { get; }
        string OrganizationUnitAttribute { get; }
        string ObjectClassAttribute { get; }
        string UserPasswordExpiredAttribute { get; }
        string LockoutTimeAttribute { get; }
        string UserAccountControlComputedAttribute { get; }
        string SiteMinderStatusAttribute { get; }
        SecurityProviderTypes ProviderType { get; }
    }
}