using System.Threading.Tasks;

namespace CarMaintenanceLog.Abstractions
{
    public interface IObjectSerializer
    {
        Task<string> GetAsSerializedAsync<T>(T payload);
        Task<(string contentType, byte[] data)> SerializeAsync<T>(T payload);
    }
}
