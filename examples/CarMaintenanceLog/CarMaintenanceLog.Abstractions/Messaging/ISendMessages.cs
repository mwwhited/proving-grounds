using System.Threading.Tasks;

namespace CarMaintenanceLog.Abstractions.Messaging
{
    public interface ISendMessages
    {
        Task<string> SendAsync<TMessage>(TMessage message);
    }
}
