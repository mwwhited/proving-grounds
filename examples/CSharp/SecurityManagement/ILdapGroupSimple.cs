namespace Originations.DataProviders.SecurityManagement
{
    public interface ILdapGroupSimple
    {
        /// <summary>
        /// Group Name
        /// </summary>
        string GroupName { get; }

        /// <summary>
        /// MarketCode & CountryCode
        /// </summary>
        /// <remarks>ldap: parent name</remarks>
        string Container { get; }

        /// <summary>
        /// distinguishedName
        /// </summary>
        /// <remarks>ldap: attribute = distinguishedName</remarks>
        string FullPath { get; }
    }
}