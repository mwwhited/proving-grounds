using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using System.Web.Routing;

namespace WhitedUS.Web.Mvc
{
    public static class ImageHelper
    {
        public static MvcHtmlString Image(this HtmlHelper html, object route, object attributes = null)
        {
            var builder = new TagBuilder("img");

            var path = html.GetRoute(route);
            builder.MergeAttributes(new RouteValueDictionary(attributes));
            builder.MergeAttribute("src", path.VirtualPath);
            return MvcHtmlString.Create(builder.ToString(TagRenderMode.SelfClosing));
        }
    }
}
