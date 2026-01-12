using System;
using System.Collections;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.Xml;
using System.Xml.Linq;

namespace WhitedUS.Libs.Xml.Linq
{
    /// <summary>
    /// Object/Xml Extension Methods
    /// </summary>
    public static class XmlLinq
    {
        /// <summary>
        /// XElement Conversion
        /// </summary>
        /// <param name="input">object graph</param>
        /// <returns>XElement</returns>
        public static XElement ToXml(this object input)
        {
            try
            {
                if (input == null)
                    return null;

                var t = input.GetType();
                var x = new XElement(XmlConvert.EncodeName(t.Name));
                var ba = input as byte[];
                var e = input as IEnumerable;
                var bmp = input as Bitmap;

                if (ba != null)
                    x.Add(Convert.ToBase64String(ba));
                else if ( input is Enum)
                    x.Add(input.ToString());
                else if (input is string)
                {
                    x.Add(input.ToString().Replace("\0","").Trim());
                }
                else if (bmp != null)
                {
                    using (var ms = new MemoryStream())
                    {
                        bmp.Save(ms, bmp.RawFormat);
                        ms.Seek(0, SeekOrigin.Begin);

                        var xbmp = ms.ToArray().ToXml();
                        if (xbmp != null)
                            x.Add(xbmp);
                    }
                }
                else if (e != null)
                {
                    foreach (var i in e)
                    {
                        var xi = i.ToXml();
                        if (xi != null)
                            x.Add(xi);
                    }
                }
                else if (t.FullName.StartsWith("System.") || t.FullName.StartsWith("Microsoft."))
                    x.Add(input.ToString());
                else
                {
                    foreach (var pi in t.GetProperties())
                    {
                        var prm = pi.GetIndexParameters();
                        if (prm != null && prm.Length > 0)
                            continue;

                        //Debug.WriteLine(pi.Name);

                        var val = pi.GetValue(input, null);
                        if (val == null)
                            continue;

                        var xval = val.ToXml();
                        if (xval != null)
                            x.Add(new XElement(pi.Name, xval));
                    }
                }

                return x;
            }
            catch (Exception ex)
            {
                return new XElement("exception", ex.ToString());
            }
        }

        /// <summary>
        /// Convert WebHeaderCollection to XML
        /// </summary>
        /// <param name="input">WebHeaderCollection</param>
        /// <returns>XElement</returns>
        public static XElement ToXml(this WebHeaderCollection input)
        {
            if (input == null)
                return null;

            return new XElement("headers",
                from h in input.AllKeys
                select new XElement("header",
                   new XAttribute("name", h),
                   from vs in input.GetValues(h)
                   select new XElement("item",
                       new XAttribute("value", vs)
                   )));
        }
    }
}
