using System;
using System.Collections.Generic;
using System.Diagnostics.Contracts;
using System.Linq;
using System.Text;

namespace WhitedUS.Totp.Shared.Accessors
{
    [ContractClass(typeof(IDispatcherContract))]
    public interface IDispatcher
    {
        void Invoke(Action action);
    }

    [ContractClassFor(typeof(IDispatcher))]
    internal abstract class IDispatcherContract : IDispatcher
    {
        public void Invoke(Action action)
        {
            Contract.Ensures(action != null);
            throw new NotImplementedException();
        }
    }
}
