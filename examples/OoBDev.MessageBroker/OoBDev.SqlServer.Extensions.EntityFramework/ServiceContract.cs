using System.Collections.Generic;

namespace OoBDev.SqlServer.Extensions.EntityFramework
{
    internal class SsbContract : IServiceContract
    {
        public string Name { get; internal set; }
        public IEnumerable<(IMessageType MessageType, SentBy SendType)> MessageTypes { get; internal set; }
    }
}