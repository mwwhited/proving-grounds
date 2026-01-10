using System.Linq;
using System.Net.NetworkInformation;
using System.Net.Sockets;

namespace OoBDev.ScoreMachine.Web.Core.Providers.Tools
{
    public static class TcpClientEx
    {
        // https://stackoverflow.com/questions/1387459/how-to-check-if-tcpclient-connection-is-closed
        public static TcpState GetState(this TcpClient tcpClient)
        {
            var globalProperties = IPGlobalProperties.GetIPGlobalProperties()
              .GetActiveTcpConnections()
              .SingleOrDefault(x => x.RemoteEndPoint.Equals(tcpClient.Client.RemoteEndPoint));
            return globalProperties?.State ?? TcpState.Unknown;
        }
    }
}
