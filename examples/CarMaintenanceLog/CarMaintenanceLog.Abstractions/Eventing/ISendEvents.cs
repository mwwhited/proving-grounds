using System.Runtime.CompilerServices;
using System.Threading.Tasks;

namespace CarMaintenanceLog.Abstractions.Eventing
{
    public interface ISendEvents
    {
        Task SendAsync<TEvent>(
            TEvent evnt,
            [CallerMemberName] string caller = null,
            [CallerLineNumber] int lineNumber = 0,
            [CallerFilePath] string callerPath = null
            );
    }
}
