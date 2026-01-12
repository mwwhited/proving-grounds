using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Mobile.Helpers
{
    /// <summary>
    /// Service locator for internal implementations.
    /// </summary>
    public sealed class ServiceLocator
    {
        static readonly Lazy<ServiceLocator> instance = new Lazy<ServiceLocator>(() => new ServiceLocator());
        public static ServiceLocator Instance => instance.Value;

        readonly Dictionary<Type, Lazy<object>> registeredServices = new Dictionary<Type, Lazy<object>>();

        public void Add<TContract, TService>() where TService : new()
        {
            registeredServices[typeof(TContract)] = new Lazy<object>(() => Activator.CreateInstance(typeof(TService)));
        }

        public T Resolve<T>() where T : class
        {
            Lazy<object> service;
            if (registeredServices.TryGetValue(typeof(T), out service))
                return (T)service.Value;
            
            return null;
        }
    }
}
