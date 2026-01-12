using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using System.Web.Routing;

namespace WhitedUS.Web.Mvc
{
    public static class RouteHelper
    {
        public static VirtualPathData GetRoute(this HtmlHelper html, object route)
        {
            var path = RouteTable.Routes.GetVirtualPathForArea(html.ViewContext.RequestContext, new RouteValueDictionary(route));
            return path;
        }

        public static string ResolveRoute(this HtmlHelper html, object route)
        {
            return html.GetRoute(route).VirtualPath;
        }
    }
}
