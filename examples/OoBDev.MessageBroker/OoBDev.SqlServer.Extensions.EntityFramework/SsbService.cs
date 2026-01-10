using Microsoft.EntityFrameworkCore;

namespace OoBDev.SqlServer.Extensions.EntityFramework
{
    internal class SsbService : IService
    {
        public string Name { get; internal set; }
        public DbSet<QueueItem> Queue { get; internal set; }
        public IServiceContract[] Contracts { get; internal set; }
    }
}