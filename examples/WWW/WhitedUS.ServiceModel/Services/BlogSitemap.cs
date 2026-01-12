using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Text;
using System.Xml;
using System.Xml.Linq;
using System.Net;
using WhitedUS.ServiceModel.Linq;

//WhitedUS.ServiceModel.Services.BlogSitemap
//System.ServiceModel.Activation.WebServiceHostFactory
namespace WhitedUS.ServiceModel.Services
{
    /// <summary>
    /// SiteMap Generator for RSS to Sitemap
    /// </summary>
    [ServiceContract]
    [AspNetCompatibilityRequirements(
        RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    public class BlogSitemap
    {
        /// <remarks />
        [OperationContract()]
        [WebGet(UriTemplate = "/")]
        [ContentType("text/xml")]
        [Description("list all services under this service binding")]
        public XElement ListServices()
        {
            return this.GetWebGetServices();
        }

        /// <remarks />
        [OperationContract()]
        [WebGet(UriTemplate = "/rss")]
        [ContentType("application/rss+xml")]
        public XElement GetFeed()
        {
            XDocument x = null;
            var hwr = HttpWebRequest.Create(
                                "http://hackersbasement.com/?feed=rss2");
            var wr = hwr.GetResponse();
            using (var hs = wr.GetResponseStream())
            using (var xr = XmlReader.Create(hs))
            {
                x = XDocument.Load(xr);
            }
            return x.Elements().FirstOrDefault();
        }

        /// <remarks />
        [OperationContract()]
        [WebGet(
            UriTemplate = "/sitemap",
            BodyStyle = WebMessageBodyStyle.Bare,
            ResponseFormat = WebMessageFormat.Xml
            )]
        [ContentType("text/xml")]
        public XElement GetSitemap()
        {
            const string ns = "http://www.sitemaps.org/schemas/sitemap/0.9";
            return
                new XElement(XName.Get("urlset", ns),
                    GetFeed().Elements().FirstOrDefault() //rss
                    .Elements().Where(x => x.Name == "item") //select items
                    .Select(x => new XElement(XName.Get("url", ns),
                        new XElement(XName.Get("loc", ns), 
                            x.Element(XName.Get("link")).Value),
                        new XElement(XName.Get("lastmod", ns), 
                            DateTime.Parse(
                                    x.Element(XName.Get("pubDate")).Value
                                ).ToString("s") + "+00:00"
                            ),
                        new XElement(XName.Get("changefreq", ns), "monthly"),
                        new XElement(XName.Get("priority", ns), "0.5")
                        ))
                    );
        }
    }
}
