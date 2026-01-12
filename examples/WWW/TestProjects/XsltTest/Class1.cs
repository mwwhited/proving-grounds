using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.Xml.Xsl;
using System.IO;
using System.Xml.XPath;

namespace XsltTest
{
    public static class Class1
    {
        public static void Main(string[] args)
        {
            var xslt = new XslCompiledTransform(); ;
            xslt.Load(new FileInfo("photoAlbums.xslt").FullName, null, null);
            var xw = XmlWriter.Create("outfile.xml");

            xslt.Transform("http://www.whited.us/AlphaSite/Services/PhotoRest.svc/list/", xw);
        }
    }
}
