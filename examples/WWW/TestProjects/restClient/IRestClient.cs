using System.ServiceModel;
using System.ServiceModel.Web;
using System.Xml.Linq;

namespace restClient
{
    [ServiceContract]
    public interface IRestClient
    {
        [OperationContract]
        [WebGet(
            BodyStyle = WebMessageBodyStyle.Bare,
            ResponseFormat = WebMessageFormat.Xml,
            RequestFormat = WebMessageFormat.Xml,
            UriTemplate = ""
            )]
        XElement GetServices();
    }
}
