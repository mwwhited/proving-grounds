using System;
using Mobile.Abstractions;

namespace Mobile.Services
{
    public class NetworkService : INetworkService
    {
        public bool IsConnected
        {
            get {return true;}
        }
    }
}
