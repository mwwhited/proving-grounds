using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Diagnostics.Contracts;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;

namespace OobDev.Common.Net
{
    public abstract class HttpClientBase : IDisposable
    {
        protected HttpClient Client { get; private set; }
        protected HttpMessageHandler MessageHandler { get; private set; }

        protected HttpClientBase(Uri uri, HttpMessageHandler messageHandler = null)
        {
            Contract.Requires(uri != null);

            var handler = messageHandler ?? new HttpClientHandler();
            this.MessageHandler = handler;
            this.Client = new HttpClient(handler)
            {
                BaseAddress = uri,
            };
        }
        protected HttpClientBase(Uri uri, string username, string password, HttpMessageHandler messageHandler = null)
            : this(uri, new BasicAuthenticationHandler(username, password, messageHandler))
        {
            Contract.Requires(uri != null);
            Contract.Requires(!string.IsNullOrEmpty(username));
            Contract.Requires(!string.IsNullOrEmpty(password));
        }

        public Task<string> GetAsync(string path, params KeyValuePair<string, object>[] parameters)
        {
            return this.GetAsync(path, parameters.AsEnumerable());
        }
        public async Task<string> GetAsync(string path, IEnumerable<KeyValuePair<string, object>> parameters)
        {
            var formContent = new FormUrlEncodedContent(parameters.Where(kv => kv.Value != null)
                                                                  .ToDictionary(k => k.Key, v => (v.Value ?? "").ToString())
                                                                  );
            var query = await formContent.ReadAsStringAsync();
            Debug.WriteLine("GetAsync({0},{1})", path, query);
            var uriBuilder = new UriBuilder(this.Client.BaseAddress)
            {
                Path = path,
                Query = query,
            };
            var response = await this.Client.GetAsync(uriBuilder.Uri);
            response.EnsureSuccessStatusCode();
            var result = await response.Content.ReadAsStringAsync();
            return result;
        }        

        public Task<string> PostAsync(string path, params KeyValuePair<string, object>[] parameters)
        {
            return this.PostAsync(path, parameters.AsEnumerable());
        }
        public async Task<string> PostAsync(string path, IEnumerable<KeyValuePair<string, object>> parameters)
        {
            var response = await this.PostRawAsync(path, parameters);
            var result = await response.Content.ReadAsStringAsync();
            response.EnsureSuccessStatusCode();
            return result;
        }
        public Task<HttpResponseMessage> PostRawAsync(string path, params KeyValuePair<string, object>[] parameters)
        {
            return this.PostRawAsync(path, parameters.AsEnumerable());
        }
        public async Task<HttpResponseMessage> PostRawAsync(string path, IEnumerable<KeyValuePair<string, object>> parameters)
        {
            var formContent = new FormUrlEncodedContent(parameters.Where(kv => kv.Value != null)
                                                                  .ToDictionary(k => k.Key, v => (v.Value ?? "").ToString())
                                                                  );
            Debug.WriteLine("PostAsync({0})", path);
            var response = await this.Client.PostAsync(path, formContent);
            return response;
        }

        protected CookieCollection GetCookies()
        {
            var cookieContainer = this.MessageHandler.GetCookieContainer();
            if (cookieContainer == null)
                return null;
            var cookies = cookieContainer.GetCookies(this.Client.BaseAddress);
            return cookies;
        }

        public void Dispose()
        {
            if (this.Client != null)
            {
                this.Client.Dispose();
                this.Client = null;
            }
        }
    }
}
