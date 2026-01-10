using Microsoft.SqlServer.Server;
using System.Data.SqlTypes;
using System.IO;
using System.Text;
using System.Xml;
using System.Xml.Xsl;

namespace OoBDev.MessageBroker.DB
{
    public class XsltProcessor
    {
        //https://blogs.msdn.microsoft.com/mrorke/2005/06/28/performing-xslt-transforms-on-xml-data-stored-in-sql-server-2005/
        public static SqlXml Transform(SqlXml inputDataXML, SqlXml inputTransformXML)
        {
            var args = new XsltArgumentList();
            args.XsltMessageEncountered += (s, e) =>
            {
                var pipe = SqlContext.Pipe;
                if (string.IsNullOrWhiteSpace(e?.Message) && (pipe?.IsSendingResults ?? false))
                {
                    pipe.Send(e.Message);
                }
            };
            var xslt = new XslCompiledTransform();
            xslt.Load(inputTransformXML.CreateReader());
            // Output the newly constructed XML
            using (var memoryXml = new MemoryStream())
            using (var outputWriter = new XmlTextWriter(memoryXml, Encoding.Default))
            {
                xslt.Transform(inputDataXML.CreateReader(), args, outputWriter, null);
                memoryXml.Position = 0;

                using (var output = new XmlTextReader(memoryXml))
                {
                    return new SqlXml(output);
                }
            }
        }
    }
}
