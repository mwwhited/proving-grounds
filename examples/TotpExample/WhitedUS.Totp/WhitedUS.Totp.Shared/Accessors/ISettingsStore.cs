using System;
using System.Collections.Generic;
using System.Diagnostics.Contracts;
using System.Linq;
using System.Text;

namespace WhitedUS.Totp.Shared.Accessors
{
    [ContractClass(typeof(ISettingsStoreContract))]
    public interface ISettingsStore
    {
        T Get<T>(string key);
        T Add<T>(string key, T value);
        void Remove(string key);
    }

    [ContractClassFor(typeof(ISettingsStore))]
    internal abstract class ISettingsStoreContract : ISettingsStore
    {
        public T Get<T>(string key)
        {
            Contract.Requires(!string.IsNullOrWhiteSpace(key));
            //Null or Default if not exists Contract.Ensures(Contract.Result<T>() != null);
            throw new NotImplementedException();
        }

        public T Add<T>(string key, T value)
        {
            Contract.Requires(!string.IsNullOrWhiteSpace(key));
            Contract.Requires(value != null);
            Contract.Ensures(Contract.Result<T>() != null);
            Contract.Ensures(Contract.Result<T>().Equals(value));
            throw new NotImplementedException();
        }

        public void Remove(string key)
        {
            Contract.Requires(!string.IsNullOrWhiteSpace(key));
            throw new NotImplementedException();
        }
    }
}
