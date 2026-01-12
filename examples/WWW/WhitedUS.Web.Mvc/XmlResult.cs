using System;
using System.Diagnostics;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Serialization;
using WhitedUS.Common;
using WhitedUS.Common.Linq;
using WhitedUS.Libs.Converters;

namespace WhitedUS.Web.Mvc
{
    public class XmlResult : ActionResult
    {
        //public XmlResult() { }
        public XmlResult(object data) { this.Data = data; }

        public string ContentType { get; set; }
        public Encoding ContentEncoding { get; set; }
        public object Data { get; set; }

        public override void ExecuteResult(ControllerContext context)
        {
            if (context == null)
                throw new ArgumentNullException("context");

            HttpResponseBase response = context.HttpContext.Response;
            if (!string.IsNullOrEmpty(this.ContentType))
                response.ContentType = this.ContentType;
            else
                response.ContentType = ContentTypes.Text_XML;

            if (this.ContentEncoding != null)
                response.ContentEncoding = this.ContentEncoding;

            if (this.Data != null)
                this.Data.WriteXml(response.OutputStream);
        }
    }
}
