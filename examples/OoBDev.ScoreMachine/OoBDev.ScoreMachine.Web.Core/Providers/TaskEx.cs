using System.Threading;
using System.Threading.Tasks;

namespace OoBDev.ScoreMachine.Web.Core.Providers
{
    public static class TaskEx
    {
        public static Task Delay(int millisecondsDelay, CancellationTokenSource cancellationTokenSource)
        {
            return Delay(millisecondsDelay, cancellationTokenSource.Token);
        }
        public static Task Delay(int millisecondsDelay, CancellationToken cancellationToken)
        {
            if (millisecondsDelay <= 0) return Task.FromResult(0);
            return Task.Delay(millisecondsDelay).ContinueWith(_ => 0);
        }
    }
}
