using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.IO.IsolatedStorage;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.Configuration;
using System.Web.SessionState;
using WhitedUS.Common;

namespace WhitedUS.Web.Controls
{
    public class ImageStore : IHttpHandler, IReadOnlySessionState
    {
        public const int SLEEP_LENGTH = 100;
        public const int RETRY_COUNT = 20;

        private static string _imageUrl;
        public static string ImageUrl
        {
            get
            {
                try
                {
                    if (string.IsNullOrEmpty(_imageUrl))
                    {
                        var config = WebConfigurationManager.OpenWebConfiguration(HttpContext.Current.Request.ApplicationPath);
                        var httpHandlers = config.GetSection("system.web/httpHandlers") as HttpHandlersSection;

                        if (httpHandlers != null)
                        {
                            var imageStoreHandler = httpHandlers.Handlers.OfType<HttpHandlerAction>()
                                .Where(h => string.Compare(h.Verb, "GET", true) == 0)
                                .Where(h => Type.GetType(h.Type, false, true) == typeof(ImageStore))
                                .FirstOrDefault();
                            if (imageStoreHandler != null)
                                _imageUrl = string.Format("~/image{0}?id={{0}}", imageStoreHandler.Path.Replace("*", ""));
                        }

                        if (string.IsNullOrEmpty(_imageUrl))
                            throw new ApplicationException("Application is missconfigured. \r\n" +
                                "Please add the following to the \"system.web/httpHandlers\" section of your web.config\r\n" +
                                "<add verb=\"GET\" path=\"*.jpegx\" type=\"W" + typeof(ImageStore).AssemblyQualifiedName + "\"/> "
                                );
                    }
                    return _imageUrl;
                }
                catch (Exception e)
                {
                    EventLogger.LogEvent(e);
                    throw;
                }
            }
        }

        private const string CACHE_STORE_NAME = "___ImageViewCache";
        private static BetterDictionary<string, ImageData> _imgCache;
        private static Dictionary<string, ImageData> ImageViewCache
        {
            get
            {
                try
                {
                    if (_imgCache == null)
                        _imgCache = new BetterDictionary<string, ImageData>();
                    return _imgCache;
                }
                catch (Exception e)
                {
                    EventLogger.LogEvent(e);
                    throw;
                }
            }
        }

        private static bool ContainsKey(string key)
        {
            lock (typeof(ImageStore))
            {
                if (ImageViewCache == null)
                    return false;
                else
                    return ImageViewCache.ContainsKey(key);
            }
        }

        public static void AddImageView(ImageData image)
        {
            AddImageView(image, null);
        }

        public static void AddImageView(ImageData image, string key)
        {
            try
            {
                if (image != null)
                {
                    if (string.IsNullOrEmpty(key))
                        key = Guid.NewGuid().ToString();

                    lock (typeof(ImageStore))
                    {
                        if (ImageViewCache == null)
                            throw new InvalidOperationException(
                                "Something is wrong with the cache");
                        ImageViewCache.Add(key, image);
                    }
                    image.Key = key;
                }
                else
                    image.Key = null;
            }
            catch (Exception e)
            {
                EventLogger.LogEvent(e);
                throw;
            }

        }

        #region IHttpHandler Members

        public bool IsReusable { get { return false; } }

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                if (string.IsNullOrEmpty(context.Request.QueryString["id"]))
                    context.Response.Write("QueryString[\"id\"] is null");
                else
                {
                    string key = context.Request.QueryString["id"];
                    if (ContainsKey(key))
                    {
                        ImageData image = null;
                        lock (typeof(ImageStore))
                        {
                            image = ImageViewCache[key];
                        }

                        if (image != null)
                        {
                            int keyCount = 0;
                        RetryKey:
                            if (image.Buffer != null &&
                                image.Buffer.Length > 0)
                            {
                                context.Response.ContentType = image.MimeType;
                                context.Response.OutputStream.Write(
                                                        image.Buffer, 
                                                        0, 
                                                        image.Buffer.Length);
                                context.Response.Flush();
                            }
                            else
                            {
                                if (keyCount > RETRY_COUNT)
                                {
                                    EventLogger.LogEvent(string.Format(
                                        "Not Content found for Key \"{0}\"",
                                        key
                                        ));
                                }
                                else
                                {
                                    keyCount++;
                                    Thread.Sleep(SLEEP_LENGTH);
                                    goto RetryKey;
                                }
                            }
                        }
                    }
                    else
                        EventLogger.LogEvent(string.Format(
                            "Key \"{0}\" not found",
                            key
                            ));
                }
            }
            catch (Exception e)
            {
                EventLogger.LogEvent(e);
                throw;
            }
        }

        #endregion
    }
}
