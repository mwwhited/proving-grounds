using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data.Linq;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Text;
using System.Xml.Linq;
using WhitedUS.Common.Linq;
using WhitedUS.Data.Chatty;
using WhitedUS.ServiceModel.Linq;

namespace WhitedUS.ServiceModel.Services
{
    public class SentTo
    {
        public string From { get; set; }
        public string Message { get; set; }
    }

    [ServiceContract]
    [AspNetCompatibilityRequirements(
        RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    public class ChattyRest
    {
        [OperationContract()]
        [WebGet(UriTemplate = "/")]
        [Description("list all services under this service binding")]
        public XElement ListServices()
        {
            return this.GetWebGetServices();
        }

        [OperationContract()]
        [WebInvoke(UriTemplate = "/{to}", Method = "POST")]
        //[XmlSerializerFormat]
        public XElement SendTo(string to, XElement input)
        {
            try
            {
                var msg = new
                {
                    From = input.Element("From").Value,
                    Message = input.Element("Message").Value
                };

                if (string.IsNullOrEmpty(to))
                    throw new ArgumentNullException("to");
                if (string.IsNullOrEmpty(msg.From))
                    throw new ArgumentNullException("from");
                if (string.IsNullOrEmpty(msg.Message))
                    throw new ArgumentNullException("message");

                using (var context = new ChattyDataDataContext())
                {
                    var newMsg = new MessageQueue()
                    {
                        To = to,
                        From = msg.From,
                        Message = msg.Message,
                        TimeStamp = DateTime.Now
                    };

                    context.MessageQueues.InsertOnSubmit(newMsg);
                    context.SubmitChanges();

                    var newId = newMsg.ID;

                    return new XElement("ack",
                            new XAttribute("result", true),
                            new XAttribute("id", newId));
                }
            }
            catch (Exception ex)
            {
                return new XElement("ack",
                    new XAttribute("result", false),
                    new XElement("exception", ex));
            }
        }

        [OperationContract()]
        [WebGet(UriTemplate = "/{username}?sync={sync}")]
        public XElement GetFor(string username, DateTime sync)
        {
            try
            {
                if (string.IsNullOrEmpty(username))
                    throw new ArgumentNullException("username");

                using (var context = new ChattyDataDataContext())
                {
                    var msgQuery = from message in context.MessageQueues
                                   where message.To == username
                                   select message;

                    if (sync > new DateTime(2000, 01, 01))
                        msgQuery = msgQuery.Where(m => m.TimeStamp >= sync);

                    return new XElement("messages",
                        new XAttribute("result", true),
                        msgQuery.Select(m =>
                        new XElement("message",
                            new XAttribute("to", m.To),
                            new XAttribute("from", m.From),
                            new XAttribute("ts", m.TimeStamp),
                            new XAttribute("id", m.ID),
                            new XElement("body", m.Message))));
                }
            }
            catch (Exception ex)
            {
                return new XElement("messages",
                    new XAttribute("result", false),
                    new XElement("exception", ex));
            }
        }

        [OperationContract()]
        [WebInvoke(UriTemplate = "/{username}?sync={sync}", Method = "DELETE")]
        public XElement DeleteFor(string username, DateTime sync)
        {
            try
            {
                if (string.IsNullOrEmpty(username))
                    throw new ArgumentNullException("username");

                using (var context = new ChattyDataDataContext())
                {
                    var msgQuery = from message in context.MessageQueues
                                   where message.To == username
                                   select message;

                    if (sync > new DateTime(2000, 01, 01))
                        msgQuery = msgQuery.Where(m => m.TimeStamp <= sync);

                    context.MessageQueues.DeleteAllOnSubmit(msgQuery);
                    context.SubmitChanges();

                    return new XElement("ack",
                            new XAttribute("result", true));
                }
            }
            catch (Exception ex)
            {
                return new XElement("ack",
                                    new XAttribute("result", false),
                                    new XElement("exception", ex));
            }
        }
    }
}
