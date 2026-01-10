using Ssb.Modeling.Models.Tools;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace Ssb.Modeling.Models.Providers
{
    public class ProjectProvider
    {
        private static int _id;
        private static XNamespace ns = "mwtm://ServiceBroker/Project/v1";
        public static ProjectModel New()
        {
            var model = new ProjectModel()
            {
                ProjectName = string.Format("Project{0}", ++ProjectProvider._id),
            };
            return model;
        }

        public static XElement ToXml(ProjectModel model)
        {
            var xml = new XElement(ns + "Project",
                new XAttribute("Name", model.ProjectName)
                );

            xml.Add(
                from xsc in model.XmlSchemaCollections
                select new XElement(ns + "Xml-Schema-Collection",
                        new XAttribute("Schema", xsc.SchemaName ?? "dbo"),
                        new XAttribute("Name", xsc.XmlSchemaCollectionName),
                        from xs in xsc.XmlSchemas
                        where !string.IsNullOrWhiteSpace(xs.XmlSchema)
                        select new XElement(ns + "XmlSchema", new XCData(xs.XmlSchema))
                    )
                );
            xml.Add(
                from mt in model.MessageTypes
                select new XElement(ns + "Message-Type",
                    new XAttribute("Name", mt.MessageTypeName),
                    new XAttribute("Validation", mt.Validation),
                    mt.XmlSchemaCollection == null ? (XNode)new XComment("No Schema Defined") : new XElement(ns + "Xml-Schema.Ref",
                        new XAttribute("Schema", mt.XmlSchemaCollection.SchemaName ?? "dbo"),
                        new XAttribute("Name", mt.XmlSchemaCollection.XmlSchemaCollectionName)
                        )
                    )
                );
            xml.Add(
                from c in model.Contracts
                select new XElement(ns + "Contract",
                    new XAttribute("Name", c.ContractName),
                    from cmt in c.ContractMessageTypes
                    let mt = cmt.MessageType
                    where mt != null && !string.IsNullOrWhiteSpace(mt.MessageTypeName)
                    select new XElement(ns + "Message-Type.Ref",
                        new XAttribute("Name", mt.MessageTypeName),
                        new XAttribute("Sent-By", cmt.SentBy)
                        )
                    )
                );
            xml.Add(
                from q in model.Queues
                select new XElement(ns + "Queue",
                        new XAttribute("Schema", q.SchemaName ?? "dbo"),
                        new XAttribute("Name", q.QueueName),
                        new XAttribute("Status", q.Status),
                        new XAttribute("Retention", q.Retention),
                        new XAttribute("Poison-Message-Handling", q.PoisonMessageHandling),
                        q.Activator == null ? (XNode)new XComment("No Activator Defined") : new XElement(ns + "Activator",
                            new XAttribute("Schema", q.Activator.SchemaName ?? "dbo"),
                            new XAttribute("Name", q.Activator.ProcedureName),
                            new XAttribute("Status", q.Activator.Status),
                            new XAttribute("Max-Queue-Readers", q.Activator.MaxQueueReaders)
                            )
                    )
                );
            xml.Add(
                from s in model.Services
                select new XElement(ns + "Service",
                    new XAttribute("Name", s.ServiceName),
                    s.Queue == null ? (XNode)new XComment("No Queue Defined") : new XElement(ns + "Queue.Ref",
                            new XAttribute("Schema", s.Queue.SchemaName ?? "dbo"),
                            new XAttribute("Name", s.Queue.QueueName)
                        ),
                    from c in s.Contracts
                    select new XElement(ns + "Contract.Ref",
                            new XAttribute("Name", c.ContractName)
                        )
                    )
                );
            xml.Add(
                from c in model.Conversations
                select new XElement(ns + "Conversation",
                    new XAttribute("Name", c.ConversationName),
                    new XAttribute("Initiator.Ref", (c.Initiator != null ? c.Initiator.ServiceName : null) ?? ""),
                    new XAttribute("Target.Ref", (c.Target != null ? c.Target.ServiceName : null) ?? "")
                    )
                );
            xml.Add(
                from cg in model.ConversationGroups
                select new XElement(ns + "Conversation-Group",
                    new XAttribute("Name", cg.ConversationGroupName),
                    from c in cg.Conversations
                    select new XElement(ns + "Conversation.Ref",
                        new XAttribute("Name", c.ConversationName)
                        )
                    )
                );
            xml.Add(
                new XComment(string.Format("Date Generated: {0}", DateTime.Now))
            );
            return xml;
        }

        public static ProjectModel Parse(XElement xml)
        {
            if (xml.Name != ns + "Project")
                throw new InvalidOperationException("Invalid XML Schema");

            var model = new ProjectModel { };
            model.ProjectName = (string)xml.Attribute("Name");

            model.XmlSchemaCollections.Add(from xsc in xml.Elements(ns + "Xml-Schema-Collection")
                                           select new XmlSchemaCollectionModel
                                           {
                                               SchemaName = (string)xsc.Attribute("Schema"),
                                               XmlSchemaCollectionName = (string)xsc.Attribute("Name"),
                                           }.AddTo(m => m.XmlSchemas, from xsx in xsc.Elements(ns + "XmlSchema")
                                                                      let xs = xsx.Elements().FirstOrDefault()
                                                                      let xsv = xs == null ? xsx.Value : xs.ToString()
                                                                      where !string.IsNullOrWhiteSpace(xsv)
                                                                      select new XmlSchemaModel
                                                                      {
                                                                          XmlSchema = xsv,
                                                                      }));

            model.MessageTypes.Add(from mt in xml.Elements(ns + "Message-Type")
                                   select new MessageTypeModel
                                   {
                                       MessageTypeName = (string)mt.Attribute("Name"),
                                       Validation = mt.Attribute("Validation").GetOrDefault<ValidationType>(),
                                       XmlSchemaCollection = (from e in mt.Elements(ns + "Xml-Schema.Ref")
                                                              let s = (string)e.Attribute("Schema")
                                                              let n = (string)e.Attribute("Name")
                                                              join xs in model.XmlSchemaCollections on new { s, n } equals new { s = xs.SchemaName, n = xs.XmlSchemaCollectionName }
                                                              select xs
                                                          ).FirstOrDefault(),
                                   });

            model.Contracts.Add(from c in xml.Elements(ns + "Contract")
                                select new ContractModel
                                {
                                    ContractName = (string)c.Attribute("Name"),
                                }.AddTo(m => m.ContractMessageTypes,
                                            from cmx in c.Elements(ns + "Message-Type.Ref")
                                            let n = (string)cmx.Attribute("Name")
                                            join mt in model.MessageTypes on n equals mt.MessageTypeName
                                            select new ContractMessageTypeModel
                                            {
                                                MessageType = mt,
                                                SentBy = cmx.Attribute("Sent-By").GetOrDefault<MessageSender>(),
                                            }));

            model.Queues.Add(from qx in xml.Elements(ns + "Queue")
                             select new QueueModel
                             {
                                 SchemaName = (string)qx.Attribute("Schema"),
                                 QueueName = (string)qx.Attribute("Name"),
                                 Status = (bool)qx.Attribute("Status"),
                                 Retention = (bool)qx.Attribute("Retention"),
                                 PoisonMessageHandling = (bool)qx.Attribute("Poison-Message-Handling"),
                                 Activator = (from ax in qx.Elements(ns + "Activator")
                                              select new InternalActivatorModel
                                              {
                                                  SchemaName = (string)ax.Attribute("Schema"),
                                                  ProcedureName = (string)ax.Attribute("Name"),
                                                  Status = (bool)ax.Attribute("Status"),
                                                  MaxQueueReaders = (int)ax.Attribute("Max-Queue-Readers"),
                                              }).FirstOrDefault(),
                             });

            model.Services.Add(from sx in xml.Elements(ns + "Service")
                               select new ServiceModel
                               {
                                   ServiceName = (string)sx.Attribute("Name"),
                                   Queue = (from qx in sx.Elements(ns + "Queue.Ref")
                                            let s = (string)qx.Attribute("Schema")
                                            let n = (string)qx.Attribute("Name")
                                            join q in model.Queues on new { s, n } equals new { s = q.SchemaName, n = q.QueueName }
                                            select q).FirstOrDefault(),
                               }.AddTo(m => m.Contracts, from cx in sx.Elements(ns + "Contract.Ref")
                                                         let n = (string)cx.Attribute("Name")
                                                         join c in model.Contracts on n equals c.ContractName
                                                         select c));

            model.Conversations.Add(from cx in xml.Elements(ns + "Conversation")
                                    let initiator = (string)cx.Attribute("Initiator.Ref")
                                    let target = (string)cx.Attribute("Target.Ref")
                                    select new ConversationModel
                                    {
                                        ConversationName = (string)cx.Attribute("Name"),
                                        Initiator = model.Services.FirstOrDefault(m => m.ServiceName == initiator),
                                        Target = model.Services.FirstOrDefault(m => m.ServiceName == target),
                                    });

            model.ConversationGroups.Add(from cgx in xml.Elements(ns + "Conversation-Group")
                                         select new ConversationGroupModel
                                         {
                                             ConversationGroupName = (string)cgx.Attribute("Name"),
                                         }.AddTo(m => m.Conversations, from cx in cgx.Elements(ns + "Conversation.Ref")
                                                                       let n = (string)cx.Attribute("Name")
                                                                       join c in model.Conversations on n equals c.ConversationName
                                                                       select c));

            return model;
        }
    }
}
