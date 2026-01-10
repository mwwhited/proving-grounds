using System;
using System.Collections.Generic;
using System.Diagnostics.Contracts;
using System.Linq;
using System.Text;

namespace OobDev.Common.Accessors
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
            Contract.Requires(!string.IsNullOrEmpty(key));
            //Null or Default if not exists Contract.Ensures(Contract.Result<T>() != null);
            throw new Exception();
        }

        public T Add<T>(string key, T value)
        {
            Contract.Requires(!string.IsNullOrEmpty(key));
            Contract.Requires(value != null);
            Contract.Ensures(Contract.Result<T>() != null);
            Contract.Ensures(Contract.Result<T>().Equals(value));
            throw new Exception();
        }

        public void Remove(string key)
        {
            Contract.Requires(!string.IsNullOrEmpty(key));
            throw new Exception();
        }
    }
}
