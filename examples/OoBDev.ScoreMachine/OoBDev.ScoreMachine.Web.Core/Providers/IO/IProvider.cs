using System.Threading;
using System.Threading.Tasks;

namespace OoBDev.ScoreMachine.Web.Core.Providers.IO
{
    public interface IProvider
    {
        Task Start(CancellationTokenSource cts);
    }
}
