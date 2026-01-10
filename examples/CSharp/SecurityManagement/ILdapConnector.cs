using System;
using System.Collections.Generic;

namespace Originations.DataProviders.SecurityManagement
{
    /// <summary>
    /// This is an abstractions for accessing and modifying Lightweight Directory Services such as AD DS, ADAM or AD LDS
    /// </summary>
    public interface ILdapConnector
    {
        /// <summary>
        /// change password for user base on knowing the existing users password
        /// </summary>
        /// <param name="username">user to provide</param>
        /// <param name="oldPassword">current password</param>
        /// <param name="newPassword">requested password</param>
        /// 
        void ChangePassword(string username, string oldPassword, string newPassword);

        /// <summary>
        /// validate provided password for user
        /// </summary>
        /// <param name="username">user to provide</param>
        /// <param name="password">password to use</param>
        /// 
        /// <returns>true if valid, false if not valid</returns>
        bool CheckPassword(string username, string password);

        /// <summary>
        /// Create a new user in directory services
        /// </summary>
        /// <param name="user">instance of referenced</param>
        /// <param name="password">[optional] if provided password will be set to this value</param>
        /// <returns>instance of referenced user object</returns>
        ILdapUserDetailed SaveUser(ILdapUserEditable user, string password);
        ILdapUserDetailed SaveUser(ILdapUserEditable user);

        /// <summary>
        /// Create a new user in directory services
        /// </summary>
        /// <param name="container">parent container for user account ([MarketCode] | "Internal")</param>
        /// <param name="username">user to provide</param>
        /// <returns>instance of referenced user object</returns>
        ILdapUserDetailed CreateUser(string container, string username);

        /// <summary>
        /// Remove provided user from directory services
        /// </summary>
        /// <param name="container">parent container for user account ([MarketCode] | "Internal")</param>
        /// <param name="username">user to provide</param>
        void DeleteUser(string container, string username);

        /// <summary>
        /// Retreive a list of users from provided container
        /// </summary>
        /// <param name="container">parent for requred accounts ([MarketCode] | "Internal")</param>
        /// <returns>Set of ILdapUserAccount objects within the required container</returns>
        IEnumerable<ILdapUserDetailed> ListUsers(string container);
        IEnumerable<ILdapUserDetailed> ListUsers();

        /// <summary>
        /// Retreive a list of enabled users from provided container
        /// </summary>
        /// <param name="container">parent for requred accounts ([MarketCode] | "Internal")</param>
        /// <returns>Set of ILdapUserAccount objects within the required container</returns>
        IEnumerable<ILdapUserDetailed> ListEnabledUsers(string container);
        IEnumerable<ILdapUserDetailed> ListEnabledUsers();

        /// <summary>
        /// Retreive a list of disabled from provided container
        /// </summary>
        /// <param name="container">parent for requred accounts ([MarketCode] | "Internal")</param>
        /// <returns>Set of ILdapUserAccount objects within the required container</returns>
        IEnumerable<ILdapUserDetailed> ListDisabledUsers(string container);
        IEnumerable<ILdapUserDetailed> ListDisabledUsers();

        /// <summary>
        /// Retreive a list of users that were last logged in between the provided dates
        /// </summary>
        /// <param name="container">parent for requred accounts ([MarketCode] | "Internal")</param>
        /// <param name="start">start of time period to check</param>
        /// <param name="end">end of time period to check</param>
        /// <returns></returns>
        IEnumerable<ILdapUserDetailed> ListUsersByLoginDates(string container, DateTime start, DateTime end);
        IEnumerable<ILdapUserDetailed> ListUsersByLoginDates(DateTime start, DateTime end);

        /// <summary>
        /// Find user object in directory by ObjectGuidAttribute ID
        /// </summary>
        /// <param name="objectGuid">Object Guid for User</param>
        /// <returns>Matched user</returns>
        ILdapUserDetailed FindUserByGuid(Guid objectGuid);

        /// <summary>
        /// Find user object in directory by ObjectGuidAttribute ID
        /// </summary>
        /// <param name="username">user to provide</param>
        /// 
        /// <returns>Matched user</returns>
        ILdapUserDetailed FindUser(string username);
        ILdapUserDetailed FindUser(string username, bool ensureExists);

        /// <summary>
        /// Use administrative rights to change password for provided user
        /// </summary>
        /// <param name="username">user to provide</param>
        /// <param name="newPassword">value to assgin to the current user</param>
        /// <param name="expirePassword">If true the last password changed time will be set to 0</param>
        /// 
        void SetPassword(string username, string newPassword, bool expirePassword);

        /// <summary>
        /// Use administrative rights to change password for provided user
        /// this will also set the last password changed time to 0
        /// </summary>
        /// <param name="username">user to provide</param>
        /// <param name="newPassword">value to assgin to the current user</param>
        /// 
        void SetPassword(string username, string newPassword);

        /// <summary>
        /// Query directory services to see if provided user exists
        /// </summary>
        /// <param name="username">This is the Username to lookup</param>
        /// <returns>true if exists, false is doesn't exist.</returns>
        bool UserExists(string username);

        /// <summary>
        /// Rename a use within the same container
        /// </summary>
        /// <param name="container">This is the Parent container for the requested user ([MarketCode] | "Internal")</param>
        /// <param name="existingUsername">This is the Username to lookup</param>
        /// <param name="newUsername">This is the Username to target</param>
        void RenameUser(string container, string existingUsername, string newUsername);

        /// <summary>
        /// Enable object for provided user
        /// </summary>
        /// <param name="username">user to provide</param>
        /// <param name="container">parent container for user account ([MarketCode] | "Internal")</param>
        void EnableUser(string username, string container);
        void EnableUser(string username);

        /// <summary>
        /// Disable object for provided user
        /// </summary>
        /// <param name="username">user to provide</param>
        /// <param name="container">parent container for user account ([MarketCode] | "Internal")</param>
        void DisableUser(string username, string container);
        void DisableUser(string username);

        /// <summary>
        /// returns status for provided user
        /// </summary>
        /// <param name="username">user to provide</param>
        /// <param name="container">parent container for user account ([MarketCode] | "Internal")</param>
        /// <returns>status for provided user</returns>
        bool IsUserEnabled(string username, string container);
        bool IsUserEnabled(string username);


        IEnumerable<ILdapGroupDetailed> ListAllGroups();

        IEnumerable<ILdapUserDetailed> ListGroupMembers(string container, string groupName);
        IEnumerable<ILdapUserDetailed> ListGroupMembers(string groupDn);
        ILdapGroupDetailed FindGroupByGuid(Guid objectGuid);
        ILdapGroupDetailed CreateGroup(string container, string groupName);
        void AddGroupMembers(string container, string groupName, IEnumerable<string> memberDns);
        void RemoveGroupMembers(string container, string groupName, IEnumerable<string> memberDns);

        string GetSuggestedUsername(string username);
        void UnlockUser(string username, string container);
        void UnlockUser(string username);

        void ForcePasswordChange(string username, string container);
        void ForcePasswordChange(string username);
    }
}