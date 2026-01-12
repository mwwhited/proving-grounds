using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
using System.Text;
using WhitedUS.ChattyClient;
using WhitedUS.Data.Chatty;

namespace ChattyTest
{
    class Program
    {
        static ChattyClient client = new ChattyClient()
        {
            Port = 8081,
            Host = "localhost",
            BasePath = "Services/ChattyRest.svc",
        };

        static void Main(string[] args)
        {
            using (var context = new ChattyDataDataContext())
                if (!context.DatabaseExists())
                    context.CreateDatabase();

            var send = client.SendTo("to", "from", "message");
            var get = client.GetFor("to");

            var cnt = get.Items.Count;
            var ts = get.Items.OrderBy(i => i.TimeStamp).Skip(cnt / 2).First().TimeStamp;
            var del = client.DeleteFor("to", ts);
        }
    }
}
