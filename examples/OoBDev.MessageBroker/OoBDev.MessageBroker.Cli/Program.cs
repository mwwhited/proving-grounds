using OoBDev.SqlServer.Extensions.EntityFramework;
using OoBDev.SqlServer.Sys;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;

namespace OoBDev.MessageBroker.Cli
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");

            using (var ssb = new PlaygroundContext(
               ("Server", "."),
               ("Database", "TestApplication"),
               ("Trusted_Connection", true)
            ))
            {
                //ssb.Database.BeginTransaction();
                ssb.SetContextInfo("test");
                ssb.SetSessionContext("UserValue", 1234);

                //var queues = from schema in ssb.Schemas
                //             from queue in schema.ServiceQueues
                //             where !queue.IsMicrosoftShipped
                //             from service in queue.Services
                //             from contract in service.ServiceContracts.Select(sc => sc.ServiceContract).DefaultIfEmpty()
                //             from messageType in contract.MessageTypes.DefaultIfEmpty()
                //             select new
                //             {
                //                 Schema = schema.Name,
                //                 Queue = queue.Name,
                //                 Service = service.Name,
                //                 Contract = contract.Name,
                //                 MessageType = messageType != null ? new
                //                 {
                //                     messageType.ServiceMessageType.Name,
                //                     messageType.IsSentByInitiator,
                //                     messageType.IsSentByTarget,
                //                 } : null,
                //                 ContextString = SystemContext.ContextInfo().ToString(),
                //             };
                //foreach (var item in queues)
                //{
                //    Console.WriteLine($"Q: {item}");
                //}

                //var collections = from xml in ssb.XmlSchemaCollections
                //                  let schema = xml.Schema.Name
                //                  select new
                //                  {
                //                      Schema = schema,
                //                      XmlCollection = xml.Name,
                //                      XSD = xml.Schema.Name != "sys" ? SystemContext.XmlSchemaNamespace(schema, xml.Name) : null,
                //                  };
                //foreach (var item in collections)
                //{
                //    Console.WriteLine($"X: {item}");
                //}

                var qis = from qi in ssb.ProcessResponseQueue
                          select new
                          {
                              qi.ConversationHandle,
                              qi.MessageSequenceNumber,
                              sc = SystemContext.SessionContextInteger("UserValue"),
                              //ci = SystemContext.ContextInfo().ToString(),
                              //qi.ServiceContractName,
                              //qi.ServiceName,
                              //qi.MessageTypeName,
                              // MessageBody = qi.MessageBody != null ? qi.MessageBody.ToString() : null,
                          };
                //foreach (var item in qis)
                //{
                //    Console.WriteLine($"X: {item}");
                //}

                //ssb.Database.BeginTransaction();
                //Console.WriteLine($"Before: {qis.Count()}");
                //var received = qis.Where(i=>i.ConversationHandle== Guid.Parse("67D15B0A-6B7C-E811-8D28-C49DED21411D")).Receive();
                //foreach (var item in received)
                //{
                //    Console.WriteLine($"X: {item}");
                //}
                //Console.WriteLine($"After: {qis.Count()}");
                //ssb.Database.RollbackTransaction();

                ssb.ProcessResponseQueue.EnableQueue();

                Guid? firstGroup = null;
                for (var x = 0; x < 10; x++)
                {
                    // ssb.Database.BeginTransaction();
                    var id = ssb.ProcessResponseQueue.GetConversationGroup();
                    var messages = ssb.ProcessResponseQueue.Where(m => m.ConversationGroupId == id);
                    if (firstGroup.HasValue)
                    {
                        foreach (var message in messages)
                        {
                            Console.WriteLine($"GroupID:{x}/{id} ({message.MessageBody}){message.ConversationHandle}");
                            //  ssb.MoveConversation(message.ConversationHandle, firstGroup.Value);
                        }
                    }
                    else
                    {
                        firstGroup = id;
                    }
                    //ssb.Database.CommitTransaction();
                }

                /*
                 	FROM SERVICE [ProcessResponseService]
				TO SERVICE 'ProcessMessageService'
                */

                var ch = ssb.BeginDialogConversation(ssb.ProcessResponseService, ssb.ProcessMessageService, ssb.ProcessMessageContract);
                Console.WriteLine(ch);

                ssb.SendOnConversation(ch, ssb.RequestMessageType, new XElement("Root", new XElement("Item", new XAttribute("id", DateTime.Now))));

                /*
                         DECLARE @ch UNIQUEIDENTIFIER;
             DECLARE @msg XML;

             BEGIN DIALOG CONVERSATION @ch
                 FROM SERVICE [ProcessResponseService]
                 TO SERVICE 'ProcessMessageService'
                 ON CONTRACT [oobdev://ProcessMessage/Contract]
                 WITH ENCRYPTION = OFF;

             SET @msg = N'<Root>
                 <Item id=''Value'' />
             </Root>';

             SEND ON CONVERSATION @ch MESSAGE TYPE 
                 [oobdev://ProcessMessage/Request] (@msg);
                 */

                //ssb.ProcessMessageQueue.Begin
                //ssb.ProcessResponseQueue.SendOn()


                Console.WriteLine(ssb.GetContextInfo().AsString());
                Console.WriteLine(ssb.GetSessionContext<int>("UserValue"));

                Console.WriteLine("fin!");
                // ssb.Database.CommitTransaction();
                Console.Read();
            }
        }
    }
}
