using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;

//WhitedUS.Services.NetworkRelay.IConnectionContract,WhitedUS.Services
namespace WhitedUS.Services.NetworkRelay
{
    [ServiceContract(
        Name = Constants.ServiceContractName,
        Namespace = Constants.ServiceContractNamespace,
        SessionMode = SessionMode.Required,
        CallbackContract = typeof(IConnectionCallbackContract)
    )]
    public interface IConnectionContract
    {
        [OperationContract(IsInitiating = true, IsOneWay = true)]
        void Connect(string server, int port, string orgSocket);

        [OperationContract(IsOneWay = true)]
        void SendData(DataMessage inboundData);

        [OperationContract()]
        void SendSystemEvent(EventMessage eventMessage);

        [OperationContract(IsOneWay = true)]
        void LoopbackWithCallBack(string inboundMessage);

        [OperationContract()]
        string Loopback(string inboundMessage);

        [OperationContract(IsTerminating = true, IsOneWay = true)]
        void Disconnect();
    }
}
