namespace Originations.DataProviders.SecurityManagement
{
    public interface ILdapUserSimple
    {
        /// <summary>
        /// UserID
        /// </summary>
        string Username { get; }

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