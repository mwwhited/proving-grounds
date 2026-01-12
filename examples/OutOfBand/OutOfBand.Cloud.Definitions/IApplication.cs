using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace OutOfBand.Cloud.Definitions
{
    public interface IApplication : IService 
    {
        object Persist();
        void Restore(object state);
    }

    public interface IApplication<TState> : IApplication
    {
        TState Persist();
        void Restore(TState state);
    }
}
