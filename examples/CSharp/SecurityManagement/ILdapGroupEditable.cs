namespace Originations.DataProviders.SecurityManagement
{
    public interface ILdapGroupEditable
    {
        string GroupName { get; }
        string Container { get; }
        int OperationType { get; }
    }
}