using System.Net;
using System.Net.Http;

namespace OobDev.Common.Net
{
    public static class HttpMessageHandlerEx
    {
        public static CookieContainer GetCookieContainer(this HttpMessageHandler httpMessageHandler)
        {
            var httpClientHandler = httpMessageHandler as HttpClientHandler;
            if (httpClientHandler != null)
                return httpClientHandler.CookieContainer;
            var delgatedHandler = httpMessageHandler as DelegatingHandler;
            if (httpClientHandler != null)
                return delgatedHandler.GetCookieContainer();

            return null;
        }
    }
}
