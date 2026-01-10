using System;
using System.Collections.Generic;
using System.Diagnostics.Contracts;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OobDev.Common
{
    public class ObjectLocatorService
    {
        private static readonly object _syncLock = new object();
        private static readonly IDictionary<Type, object> _objectStore = new Dictionary<Type, object>();
        private static readonly IDictionary<string, object> _objectKeyStore = new Dictionary<string, object>();

        public static T Register<T>(T target)
        {
            Contract.Requires(target != null);
            Contract.Ensures(Contract.Result<T>() != null);

            lock (ObjectLocatorService._syncLock)
            {
                ObjectLocatorService._objectStore.Add(typeof(T), target);
                return target;
            }
        }
        public static T Register<T>(string key, T target)
        {
            Contract.Requires(!string.IsNullOrEmpty(key));
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
                throw new NullReferenceException($"Object Not Found: {typeof(T).Name}");
            }
        }
        public static T Get<T>(string key)
        {
            Contract.Requires(!string.IsNullOrEmpty(key));
            Contract.Ensures(Contract.Result<T>() != null);
            Contract.EnsuresOnThrow<NullReferenceException>(!ObjectLocatorService._objectKeyStore.ContainsKey(key));

            lock (ObjectLocatorService._syncLock)
            {
                if (ObjectLocatorService._objectKeyStore.ContainsKey(key))
                    return (T)ObjectLocatorService._objectKeyStore[key];
                throw new NullReferenceException($"Object Not Found: {key}");
            }
        }
        //public static T GetOrDefault<T>()
        //{
        //    lock (ObjectLocatorService._syncLock)
        //    {
        //        if (ObjectLocatorService._objectStore.ContainsKey(typeof(T)))
        //            return (T)ObjectLocatorService._objectStore[typeof(T)];
        //        return default(T);
        //    }
        //}
        //public static T GetOrDefault<T>(string key)
        //{
        //    lock (ObjectLocatorService._syncLock)
        //    {
        //        if (ObjectLocatorService._objectKeyStore.ContainsKey(key))
        //            return (T)ObjectLocatorService._objectKeyStore[key];
        //        return default(T);
        //    }
        //}

        //public static T GetOrRegister<T>(T target)
        //{
        //    Contract.Requires(target != null);
        //    var obj = ObjectLocatorService.GetOrDefault<T>();
        //    if (obj == null)
        //        return ObjectLocatorService.Register<T>(target);
        //    return obj;
        //}
        //public static T GetOrRegisterLazy<T>(Func<T> target)
        //{
        //    Contract.Requires(target != null);
        //    var obj = ObjectLocatorService.GetOrDefault<T>();
        //    if (obj == null)
        //        return ObjectLocatorService.Register<T>(target());
        //    return obj;
        //}
        //public static T GetOrRegister<T>(string key, T target)
        //{
        //    Contract.Requires(!string.IsNullOrEmpty(key));
        //    Contract.Requires(target != null);
        //    var obj = ObjectLocatorService.GetOrDefault<T>(key);
        //    if (obj == null)
        //        return ObjectLocatorService.Register<T>(key, target);
        //    return obj;
        //}
        //public static T GetOrRegisterLazy<T>(string key, Func<T> target)
        //{
        //    Contract.Requires(!string.IsNullOrEmpty(key));
        //    Contract.Requires(target != null);

        //    var obj = ObjectLocatorService.GetOrDefault<T>(key);
        //    if (obj == null)
        //        return ObjectLocatorService.Register<T>(key, target());
        //    return obj;
        //}
    }
}
