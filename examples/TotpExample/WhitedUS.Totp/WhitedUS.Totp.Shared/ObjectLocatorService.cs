using System;
using System.Collections.Generic;
using System.Diagnostics.Contracts;
using System.Text;
using System.Windows.Input;
using WhitedUS.Totp.Shared.Accessors;

namespace WhitedUS.Totp.Shared
{
    public class ObjectLocatorService
    {

        public static void Configure(
            INavigator navigator,
            ISettingsStore settingsStore,
            ICrypto crypto = null,
            ICredentialStore credentialStore = null,

            IDispatcher dispatcher = null
            )
        {
            Contract.Requires(navigator != null);
            Contract.Requires(settingsStore != null);

            ObjectLocatorService.Register<INavigator>(navigator);
            ObjectLocatorService.Register<ISettingsStore>(settingsStore);

            ObjectLocatorService.Register<ICrypto>(crypto ?? new DefaultCrypto());
            ObjectLocatorService.Register<ICredentialStore>(credentialStore ?? new DefaultPasswordStore());

            if (dispatcher != null)
                ObjectLocatorService.Register<IDispatcher>(dispatcher);
        }

        private static readonly object _syncLock = new object();
        private static readonly IDictionary<Type, object> _objectStore = new Dictionary<Type, object>();
        private static readonly IDictionary<string, object> _objectKeyStore = new Dictionary<string, object>();

        private static T Register<T>(T target)
        {
            Contract.Requires(target != null);
            Contract.Ensures(Contract.Result<T>() != null);

            lock (ObjectLocatorService._syncLock)
            {
                ObjectLocatorService._objectStore.Add(typeof(T), target);
                return target;
            }
        }
        private static T Register<T>(string key, T target)
        {
            Contract.Requires(!string.IsNullOrWhiteSpace(key));
            Contract.Requires(target != null);
            Contract.Ensures(Contract.Result<T>() != null);

            lock (ObjectLocatorService._syncLock)
            {
                ObjectLocatorService._objectKeyStore.Add(key, target);
                return target;
            }
        }

        public static T Get<T>()
        {
            Contract.Ensures(Contract.Result<T>() != null);
            Contract.EnsuresOnThrow<NullReferenceException>(!ObjectLocatorService._objectStore.ContainsKey(typeof(T)));

            lock (ObjectLocatorService._syncLock)
            {
                if (ObjectLocatorService._objectStore.ContainsKey(typeof(T)))
                    return (T)ObjectLocatorService._objectStore[typeof(T)];
                throw new NullReferenceException(string.Format("Object Not Found: {0}", typeof(T).Name));
            }
        }
        public static T Get<T>(string key)
        {
            Contract.Requires(!string.IsNullOrWhiteSpace(key));
            Contract.Ensures(Contract.Result<T>() != null);
            Contract.EnsuresOnThrow<NullReferenceException>(!ObjectLocatorService._objectStore.ContainsKey(typeof(T)));

            lock (ObjectLocatorService._syncLock)
            {
                if (ObjectLocatorService._objectKeyStore.ContainsKey(key))
                    return (T)ObjectLocatorService._objectKeyStore[key];
                throw new NullReferenceException(string.Format("Object Not Found: {0}", typeof(T).Name));
            }
        }
        public static T GetOrDefault<T>()
        {
            lock (ObjectLocatorService._syncLock)
            {
                if (ObjectLocatorService._objectStore.ContainsKey(typeof(T)))
                    return (T)ObjectLocatorService._objectStore[typeof(T)];
                return default(T);
            }
        }
    }
}
