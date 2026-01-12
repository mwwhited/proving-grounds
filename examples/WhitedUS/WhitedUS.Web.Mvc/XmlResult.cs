using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using System.Xml.Serialization;
using System.IO;

namespace WhitedUS.Web.Mvc
{
    public class XmlResult : ActionResult
    {
        private object _objectToSerialize;
        private XmlAttributeOverrides _xmlAttribueOverrides;
        private string _mimeType;

        public XmlResult(object objectToSerialize, XmlAttributeOverrides xmlAttributeOverrides = null, string mimeType = null)
        {
            this._objectToSerialize = objectToSerialize;
            this._xmlAttribueOverrides = xmlAttributeOverrides;
            this._mimeType = mimeType;
        }

        public object ObjectToSerialize
        {
            get { return _objectToSerialize; }
        }

        public override void ExecuteResult(ControllerContext context)
        {
            //try
            //{
            //    context.HttpContext.Response.AddHeader("X-1", "1");

            if (_objectToSerialize != null)
            {
                //        context.HttpContext.Response.AddHeader("X-2", "2");
                //        context.HttpContext.Response.AddHeader("X-2a", _objectToSerialize.ToString());
                //        context.HttpContext.Response.AddHeader("X-2b", _objectToSerialize.GetType().ToString());
                //        context.HttpContext.Response.AddHeader("X-2c", string.Format("[{0}]", _xmlAttribueOverrides));

                var xs = (_xmlAttribueOverrides == null) ?
                    new XmlSerializer(_objectToSerialize.GetType()) :
                    new XmlSerializer(_objectToSerialize.GetType(), _xmlAttribueOverrides);

                //        context.HttpContext.Response.AddHeader("X-3", "3");
                context.HttpContext.Response.ContentType = this._mimeType ?? "text/xml";

                //        context.HttpContext.Response.AddHeader("X-4", "4");
                using (var ms = new MemoryStream())
                {
                    //            context.HttpContext.Response.AddHeader("X-5", "5");
                    xs.Serialize(ms, _objectToSerialize);
                    //            context.HttpContext.Response.AddHeader("X-6", "6");
                    ms.Position = 0;
                    //            context.HttpContext.Response.AddHeader("X-7", "7");
                    ms.CopyTo(context.HttpContext.Response.OutputStream);
                }
            }
            //}
            //catch (Exception ex)
            //{
            //    context.HttpContext.Response.AddHeader("X-Exception-Message", ex.Message);
            //    context.HttpContext.Response.AddHeader("X-Exception", ex.ToString().Replace(Environment.NewLine, "--"));
            //}
        }
    }
}
