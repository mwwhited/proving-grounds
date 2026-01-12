using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Script.Serialization;
using System.Web;

namespace WhitedUS.Web.Mvc
{
    public static class JsonTools
    {
        public static HtmlString ToJson(this object obj)
        {
            var serializer = new JavaScriptSerializer();
            return new HtmlString(serializer.Serialize(obj));
        } 
    }
}
