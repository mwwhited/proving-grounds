//using System;
//using System.Collections.Generic;
//using System.IO;
//using System.Linq;
//using System.Text;
//using System.Xml;
//using System.Xml.Linq;

//namespace WhitedUS.StackBoard.Models
//{
//    public class XmlDoc
//    {
//        public XDocument Document { get; set; }

//        public static implicit operator XmlDoc(string xml)
//        {
//            var xdocument = XDocument.Parse(xml);
//            var xdoc = new XmlDoc { Document = xdocument, };
//            return xdoc;
//        }
//        public static implicit operator XmlDoc(XDocument xdocument)
//        {
//            var xdoc = new XmlDoc { Document = xdocument, };
//            return xdoc;
//        }

//        public static implicit operator string(XmlDoc xdoc)
//        {
//            if (xdoc.Document == null)
//                return null;

//            var settings = new XmlWriterSettings
//            {
//                Encoding = Encoding.Unicode,
//            };
//            using (var ms = new MemoryStream())
//            {
//                using (var xmlWriter = XmlWriter.Create(ms, settings))
//                    xdoc.Document.Save(xmlWriter);
//                ms.Position = 0;
//                using (var reader = new StreamReader(ms, Encoding.Unicode))
//                {
//                    var result = reader.ReadToEnd();
//                    return result;
//                }
//            }
//        }
//        public static implicit operator XDocument(XmlDoc xdoc)
//        {
//            return xdoc.Document;
//        }
//    }
//}
