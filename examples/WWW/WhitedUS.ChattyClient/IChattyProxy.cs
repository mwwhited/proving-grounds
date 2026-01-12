using System;
using System.ServiceModel;
using System.ServiceModel.Web;

namespace WhitedUS.ChattyClient
{
    [ServiceContract]
    [XmlSerializerFormat]
    public interface IChattyProxy
    {
        [OperationContract()]
        [WebInvoke(UriTemplate = "/{username}", Method = "POST")]
        Ack SendTo(string username, SendMessage input);

        [OperationContract()]
        [WebGet(UriTemplate = "/{username}?sync={sync}")]
        Messages GetFor(string username, DateTime sync);

        [OperationContract()]
        [WebInvoke(UriTemplate = "/{username}?sync={sync}", Method = "DELETE")]
        Ack DeleteFor(string username, DateTime sync);
    }
}
