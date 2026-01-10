using Newtonsoft.Json.Linq;
using System;

namespace OobDev.Adapter.HolidayApi.Client
{
    public class HolidayApiException : Exception
    {
        public int Status { get; }
        public JToken Json { get; }
        
        public HolidayApiException(int status, JToken json)
            :base($"An error occured: {status}")
        {
            this.Status =  status;
            this.Json = json;
        }
    }
}