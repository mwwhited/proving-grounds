using System;
using System.ComponentModel;
using System.IO;
using System.Linq;
using System.ServiceModel.Web;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Xsl;
using WhitedUS.Common;
using WhitedUS.Libs.Xml.Linq;
using System.Configuration;

namespace WhitedUS.ServiceModel.Linq
{
    /// <summary>
    /// Object/Xml Extension Methods
    /// </summary>
    public static class XmlLinq
    {
        /// <summary>
        /// Get Restful Services on 
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        public static XElement GetWebGetServices(this object input)
        {
            return new XElement("services",
                from method in input.GetType().GetMethods()
                let webInvoke = method.GetAttribute<WebInvokeAttribute>()
                let webGet = method.GetAttribute<WebGetAttribute>()
                where ((Attribute)webInvoke ?? webGet) != null
                let webInvokeXml = webInvoke != null ? new XAttribute[]{
                        new XAttribute("uriTemplate", webInvoke.UriTemplate),
                        new XAttribute("bodyStyle", webInvoke.BodyStyle),
                        new XAttribute("requestFormat", 
                                       webInvoke.RequestFormat),
                        new XAttribute("method", webInvoke.Method)                               
                    } : null
                let webGetXml = (webInvoke == null && webGet != null)
                    ? new XAttribute[]{
                        new XAttribute("uriTemplate", webGet.UriTemplate),
                        new XAttribute("bodyStyle", webGet.BodyStyle),
                        new XAttribute("requestFormat", webGet.RequestFormat),
                        new XAttribute("method", "GET")
                    } : null
                let contentType = method.GetAttribute<ContentTypeAttribute>()
                let description = method.GetAttribute<DescriptionAttribute>()
                select new XElement("service",
                    new XAttribute("name", method.Name),
                    new XAttribute("returnType", method.ReturnType),
                    new XElement("invoke", webInvokeXml ?? webGetXml),
                    new XAttribute("contentType",
                                contentType != null ? contentType.ContentType
                                                    : ContentTypes.Text_XML),
                    new XAttribute("description",
                                description != null ? description.Description
                                                    : string.Empty),
                    new XElement("Parameters",
                        from parameter in method.GetParameters()
                        select new XElement("parameter",
                            new XAttribute("name", parameter.Name),
                            new XAttribute("type", parameter.ParameterType),
                            new XAttribute("position", parameter.Position)
                        )
                    )
                )
            );
        }

        /// <summary>
        /// XML/XSLT transformer
        /// </summary>
        /// <param name="styleSheet">XSLT</param>
        /// <param name="inputXml">XML Input</param>
        /// <param name="outputXml">XmlOutput</param>
        public static void TransformXML(this string styleSheet,
                                        Stream inputXml,
                                        XmlWriter outputXml)
        {
            var basePath = ConfigurationManager.AppSettings["BaseTransformPath"];
            var filePath = Path.Combine(basePath, styleSheet);
            var xr = XmlReader.Create(inputXml);
            var xslt = new XslCompiledTransform(); ;
            xslt.Load(filePath, null, null);
            xslt.Transform(xr, outputXml);

            //string service = string.Empty;
            ////this causes a limting factor there the asystem must be able to resolve it's own address
            //if (WebOperationContext.Current != null)
            //    service = WebOperationContext.Current.IncomingRequest.UriTemplateMatch.BaseUri.ToString();

            //var xr = XmlReader.Create(inputXml);
            //var xslt = new XslCompiledTransform(); ;
            //xslt.Load(service.GetParent() + "/" + styleSheet, null, null);
            //xslt.Transform(xr, outputXml);
        }

        /// <remarks />
        public static string GetParent(this string input)
        {
            if (string.IsNullOrEmpty(input))
                return string.Empty;
            var end = input.LastIndexOf("\\");
            if (end <= 0)
                end = input.LastIndexOf("/");
            string parent = string.Empty;
            if (end > 0)
                parent = input.Substring(0, end);
            return parent;
        }
    }
}
