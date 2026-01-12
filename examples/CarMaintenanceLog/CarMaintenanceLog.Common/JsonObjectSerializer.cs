using CarMaintenanceLog.Abstractions;
using Newtonsoft.Json;
using System.Text;
using System.Threading.Tasks;

namespace CarMaintenanceLog.Common
{
    public class JsonObjectSerializer : IObjectSerializer
    {
        private readonly JsonConverter[] _converters;

        public JsonObjectSerializer(
            JsonConverter[] converters
            )
        {
            _converters = converters;
        }

        public Task<string> GetAsSerializedAsync<T>(T payload)
        {
            var json = JsonConvert.SerializeObject(payload, _converters);
            return Task.FromResult(json);
        }

        public async Task<(string contentType, byte[] data)> SerializeAsync<T>(T payload)
        {
            var json = await GetAsSerializedAsync(payload);
            var data = Encoding.UTF8.GetBytes(json);

            return ($"application/json; Class={payload.GetType().FullName}", data);
        }
    }
}
