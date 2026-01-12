using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI;
using System.Web;

namespace WhitedUS.Web.Controls
{
    /// <summary>
    /// Be warned.  This control will eat your Response Buffer and 
    /// return only the content for it.
    /// </summary>
    public class ImageViewLite : ImageView
    {
        protected override void Render(HtmlTextWriter writer)
        {
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.ClearHeaders();
            HttpContext.Current.Response.ClearContent();
            HttpContext.Current.Response.ContentType = this.MimeType;
            HttpContext.Current.Response.OutputStream.Write(
                                                        ImageContent, 
                                                        0, 
                                                        ImageContent.Length);
            HttpContext.Current.Response.Flush();
        }
    }
}
