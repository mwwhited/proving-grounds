using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace OutOfBand.Cloud.Definitions
{
    public interface IChannel : IApplication  
    {
        event EventHandler FromService;
        void ToService(object message);
    }

    public interface IChannel<TMessage> : IChannel
    {
        void ToService(TMessage message);
    }
}
