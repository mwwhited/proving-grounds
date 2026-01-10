using Newtonsoft.Json.Linq;
using OobDev.Common.Net;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace OobDev.Adapter.HolidayApi.Client
{
    // https://github.com/joshtronic/holidayapi.com
    public class HolidayApiClient : HttpClientBase
    {
        /// <summary>
        /// ReadConsoleRetry in miliseconds
        /// </summary>
        private static int RetryDelayInMilliseconds { get; } = 1 * 1000;
        private static int MaxRetryCount { get; } = 5;

        private static Uri BaseUri { get; } = new Uri("http://holidayapi.com/");

        public HolidayApiClient(HttpMessageHandler httpMessageHandler = null)
            : base(HolidayApiClient.BaseUri, httpMessageHandler)
        {
        }

        public async Task<IEnumerable<HolidayModel>> HolidaysAsync(string country, int year, int? month = null, int? day = null, bool? previous = null, bool? upcoming = null)
        {
            var json = await this.HolidaysRawAsync(country, year, month, day, previous, upcoming);

            var status = (int)json["status"];
            if (status != 200)
                throw new HolidayApiException(status, json);

            var holidays = from hs in (json["holidays"] as JObject).Values()
                           from h in (hs as JArray)
                           select new HolidayModel(h);

            var ret = holidays.ToArray();

            return ret;
        }

        public async Task<JToken> HolidaysRawAsync(string country, int year, int? month = null, int? day = null, bool? previous = null, bool? upcoming = null)
        {
            var result = await this.GetAsync("/v1/holidays", new Dictionary<string, object>
            {
                {"country",country },
                {"year",year },
                {"month",month },
                {"day",day },
                {"previous",previous },
                {"upcoming",upcoming },
            }.Where(v => v.Value != null));
            var resultJson = JToken.Parse(result);
            return resultJson;
        }
    }
}

