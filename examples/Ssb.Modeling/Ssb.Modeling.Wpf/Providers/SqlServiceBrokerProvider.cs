using Ssb.Modeling.Models.Providers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace Ssb.Modeling.Wpf.Providers
{
    public class SqlServiceBrokerProvider
    {
        public static async Task<XElement> GetXml(string connectionString, IResourceLoader resourceLoader)
        {
            using (var scriptStream = await resourceLoader.GetResource("Ssb.Modeling.Models.Scripts.ProjectExport.sql"))
            using (var scriptReader = new StreamReader(scriptStream))
            using (var connection = new SqlConnection(connectionString))
            {
                await connection.OpenAsync();

                var commandScript = scriptReader.ReadToEnd();
                using (var command = new SqlCommand(commandScript, connection) { CommandType = CommandType.Text, })
                using (var xmlReader = await command.ExecuteXmlReaderAsync())
                {
                    return XElement.Load(xmlReader);
                }
            }
        }
    }
}
