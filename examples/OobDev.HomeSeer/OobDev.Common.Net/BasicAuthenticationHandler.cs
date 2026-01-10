using System;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading;
using System.Threading.Tasks;

namespace OobDev.Common.Net
{
    public class BasicAuthenticationHandler : DelegatingHandler
    {
        private readonly string username;
        private readonly string password;

        public BasicAuthenticationHandler(string username, string password)
            : this(username, password, null)
        {
        }

        public BasicAuthenticationHandler(string username, string password, HttpMessageHandler innerHandler)
            : base(innerHandler ?? new HttpClientHandler())
        {
            this.username = username;
            this.password = password;
        }

        protected async override Task<HttpResponseMessage> SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
        {
            request.Headers.Authorization = this.CreateBasicHeader();

            var response = await base.SendAsync(request, cancellationToken).ConfigureAwait(false);

            return response;
        }

        public AuthenticationHeaderValue CreateBasicHeader()
        {
            var byteArray = System.Text.Encoding.UTF8.GetBytes($"{username}:{password}");
            var base64String = Convert.ToBase64String(byteArray);
            return new AuthenticationHeaderValue("Basic", base64String);
        }
    }

}
