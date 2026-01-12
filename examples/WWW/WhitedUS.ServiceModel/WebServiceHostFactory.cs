using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ServiceModel.Web;
using System.Net;

namespace WhitedUS.ServiceModel
{
    /// <summary>
    /// Custom WebServiceHostFactory
    /// </summary>
    public static class WebServiceHostFactory
    {
        /// <summary>
        /// Create a WebServiceHost for Type T
        /// </summary>
        /// <typeparam name="T">Type to create WebServiceHost for</typeparam>
        /// <returns>WebServiceHost</returns>
        public static WebServiceHost Create<T>() where T : class
        {
            return typeof(T).Create();
        }

        /// <summary>
        /// Create a WebServiceHost for Type T
        /// </summary>
        /// <typeparam name="T">Type to create WebServiceHost for</typeparam>
        /// <param name="port">Post Number</param>
        /// <returns>WebServiceHost</returns>
        public static WebServiceHost Create<T>(int port) where T : class
        {
            return typeof(T).Create(port);
        }

        /// <summary>
        /// Create a WebServiceHost for Type T
        /// </summary>
        /// <param name="service">Type to create WebServiceHost for</param>
        /// <returns>WebServiceHost</returns>
        public static WebServiceHost Create(this Type service)
        {
            return service.Create(8080);
        }

        /// <summary>
        /// Create a WebServiceHost for Type T
        /// </summary>
        /// <param name="service">Type to create WebServiceHost for</param>
        /// <param name="port">Post Number</param>
        /// <returns>WebServiceHost</returns>
        public static WebServiceHost Create(this Type service, int port)
        {
            if (service == null)
                throw new ArgumentNullException("service");

            string address = string.Format("http://{0}:{1}/{2}/",
            Dns.GetHostName(),
            8080,
            service.Name.ToLower()
                .Replace("services", "")
                .Replace("rest", "")
            );
            return new WebServiceHost(service, new Uri(address));
        }
    }
}
