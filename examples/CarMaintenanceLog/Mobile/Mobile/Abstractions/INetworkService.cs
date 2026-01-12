using System;

namespace Mobile.Abstractions
{
    public interface INetworkService
    {
        bool IsConnected { get; }
    }
}
