using System.Collections.Generic;

namespace OoBDev.SqlServer.Extensions.EntityFramework
{
    public interface IServiceContract
    {
        string Name { get; }
        IEnumerable<(IMessageType MessageType, SentBy SendType)> MessageTypes { get; }
    }
}