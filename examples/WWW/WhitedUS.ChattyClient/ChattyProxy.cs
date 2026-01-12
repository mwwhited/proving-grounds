using System;
using System.ServiceModel;
using System.ServiceModel.Description;

namespace WhitedUS.ChattyClient
{
    public class ChattyProxy : ClientBase<IChattyProxy>, IChattyClient
    {
        public ChattyProxy(string uri)
            : base(new WebHttpBinding(), new EndpointAddress(uri))
        {
            this.Endpoint.Behaviors.Add(new WebHttpBehavior());
        }

        #region IChattyProxy Members

        public Ack SendTo(string to, string from, string message)
        {
            return this.Channel.SendTo(to, new SendMessage()
            {
                 From = from,
                 Message = message
            });
        }

        public Messages GetFor(string username, DateTime sync)
        {
            return this.Channel.GetFor(username, sync);
        }

        public Ack DeleteFor(string username, DateTime sync)
        {
            return this.Channel.DeleteFor(username, sync);
        }

        #endregion
    }
}
