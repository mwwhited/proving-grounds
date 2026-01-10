namespace OoBDev.SqlServer.Extensions.EntityFramework
{
    public interface IMessageType
    {
        string Name { get; }
        MessageValidationType ValidationType { get; }
    }
}