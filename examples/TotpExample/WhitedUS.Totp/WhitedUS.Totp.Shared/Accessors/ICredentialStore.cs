using System;
using System.Collections.Generic;
using System.Diagnostics.Contracts;
using System.Linq;
using System.Text;

namespace WhitedUS.Totp.Shared.Accessors
{
    [ContractClass(typeof(ICredentialStoreContract))]
    public interface ICredentialStore
    {
        void Add(string resource, string username, string password);
        ICredentialValue Get(string resource);
        void Clear(string resource);
    }

    [ContractClassFor(typeof(ICredentialStore))]
    internal abstract class ICredentialStoreContract : ICredentialStore
    {
        public void Add(string resource, string username, string password)
        {
            Contract.Requires(!string.IsNullOrWhiteSpace(resource));
            Contract.Requires(!string.IsNullOrWhiteSpace(username));
            Contract.Requires(!string.IsNullOrWhiteSpace(password));
            throw new NotImplementedException();
        }

        public ICredentialValue Get(string resource)
        {
            Contract.Requires(!string.IsNullOrWhiteSpace(resource));
            //Note: Null if not found // Contract.Ensures(Contract.Result<ICredentialValue>() != null);
            throw new NotImplementedException();
        }

        public void Clear(string resource)
        {
            Contract.Requires(!string.IsNullOrWhiteSpace(resource));
            throw new NotImplementedException();
        }
    }
}
