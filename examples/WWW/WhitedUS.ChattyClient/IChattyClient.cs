using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;

namespace WhitedUS.ChattyClient
{
    public interface IChattyClient
    {
        Ack SendTo(string to, string from, string message);
        Messages GetFor(string username, DateTime sync);
        Ack DeleteFor(string username, DateTime sync);
    }
}
