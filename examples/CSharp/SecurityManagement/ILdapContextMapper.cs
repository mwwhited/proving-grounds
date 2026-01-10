using Originations.DataProviders.SecurityManagement.LdapFilters;
using System;
using System.Collections.Generic;
using System.DirectoryServices;

namespace Originations.DataProviders.SecurityManagement
{
    public interface ILdapContextMapper
    {
        DirectoryEntry AdminBinding(string url);
        string BuildPath(string container, string objectName);
        string BuildPath(string container);
        string BuildUrl(string dn);
        void EnsureNotAdmin(string dn);
        IEnumerable<ILdapGroupDetailed> FindGroups(string container, ILdapFilter ldapFilter);
        IEnumerable<T> FindObjects<T>(string objectClass, Func<SearchResult, T> mapper, string container, ILdapFilter ldapFilter, string[] propertyToLoad);
        IEnumerable<ILdapUserDetailed> FindUsers(string container, ILdapFilter ldapFilter);
        T GetProperty<T>(string container, string objectName, string propertyName);
        DirectorySearcher GetSearcher(DirectoryEntry entry, string objectClass, ILdapFilter ldapFilter, string[] propertiesToLoad);
        ILdapGroupDetailed MapGroupAccount(SearchResult entry);
        ILdapUserDetailed MapUserAccount(SearchResult entry);
        void SetProperties(string container, string objectName, IEnumerable<KeyValuePair<string, object>> propertValues);
        void SetProperty<T>(string container, string objectName, string propertyName, T value);
        DirectoryEntry UserBinding(string url, string userName, string password);

        void UpdateSiteMinderStatus(PropertyCollection properties, SiteMinderStatus value);
        void UpdateSiteMinderStatus(string container, string username, SiteMinderStatus value);
    }
}