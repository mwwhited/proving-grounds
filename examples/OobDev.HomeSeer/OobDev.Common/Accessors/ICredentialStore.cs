using System;
using System.Collections.Generic;
using System.Diagnostics.Contracts;
using System.Linq;
using System.Text;

namespace OobDev.Common.Accessors
{
    [ContractClass(typeof(ICredentialStoreContract))]
    public interface ICredentialStore
    {
        void Add(ICredentialValue credential);
        ICredentialValue Get(string resource);
        void Clear(string resource);
    }

    [ContractClassFor(typeof(ICredentialStore))]
    internal abstract class ICredentialStoreContract : ICredentialStore
    {
        public void Add(ICredentialValue credential)
        {
            throw new Exception();
        }

        public ICredentialValue Get(string resource)
        {
            Contract.Requires(!string.IsNullOrEmpty(resource));
            //Note: Null if not found // Contract.Ensures(Contract.Result<ICredentialValue>() != null);
            throw new Exception();
        }

        public void Clear(string resource)
        {
            Contract.Requires(!string.IsNullOrEmpty(resource));
            throw new Exception();
        }
    }
}
