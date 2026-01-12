using System;
using System.Threading.Tasks;

namespace Mobile.Abstractions
{
    public interface IAppLogger
    {
        Task InfoLine(string line);
        Task DetailLine(string line);
        Task ErrorLine(string line);
        Task CriticalLine(string line);
    }
}
