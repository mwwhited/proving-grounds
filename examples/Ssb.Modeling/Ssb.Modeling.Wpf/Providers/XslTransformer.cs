using Ssb.Modeling.Models.Providers;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Xsl;

namespace Ssb.Modeling.Wpf.Providers
{
    public class XslTransformer : IXslTransform
    {
        public Task<Stream> Transform(Stream stylesheet, Stream source)
        {
            return Task.Run(() =>
            {
                var xslTransformer = new XslCompiledTransform();
                var readerSettings = new XmlReaderSettings
                {
                    DtdProcessing = DtdProcessing.Parse,
                };
                using (var stylesheetReader = XmlReader.Create(stylesheet, readerSettings))
                using (var sourceReader = XmlReader.Create(source))
                {
                    xslTransformer.Load(stylesheetReader);

                    Stream result = new MemoryStream();
                    var arguments = new XsltArgumentList();

                    xslTransformer.Transform(sourceReader, arguments, result);
                    result.Position = 0;
                    return result;
                }
            });
        }
    }
}
