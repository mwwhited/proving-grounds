using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;

namespace WhitedUS.Services.NetworkRelay
{
    [ServiceContract(
        Name = Constants.ServiceContractName,
        Namespace = Constants.ServiceContractNamespace,
        SessionMode = SessionMode.Required
    )]
    public interface IConnectionCallbackContract
    {

        [OperationContract(IsOneWay = true)]
        void SendData(DataMessage OutboundData);

        [OperationContract()]
        void CallbackSystemEvent(EventMessage eventMessage);

        [OperationContract(IsOneWay = true)]
        void ReturnLoopBack(string originSocketName, string OutboundData);

    }
}
