using System.Threading;
using System.Threading.Tasks;

namespace OoBDev.ScoreMachine.Web.Core.Providers.IO
{
    public interface IDeviceHandler<T>
    {
        Task Poll(T input, CancellationTokenSource cts);
        Task Received(byte[] readBuffer, T input, CancellationTokenSource cts);
    }
}
