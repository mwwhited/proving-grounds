using CarMaintenanceLog.Abstractions;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyModel;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;

namespace CarMaintenanceLog.Loader
{
    public static class RegistrarLoader
    {
        private static IReadOnlyCollection<Type> _registrarTypes;
        public static IReadOnlyCollection<Type> RegistrarTypes
        {
            get
            {
                return _registrarTypes ?? (_registrarTypes = LoadRegistrarTypes());
            }
        }

        public static IServiceCollection AddRegistrars(this IServiceCollection services)
        {
            var registrars = from t in RegistrarTypes
                             let i = Activator.CreateInstance(t)
                             let r = i as IRegistrar
                             where r != null
                             select r;

            return registrars.Aggregate(
                services,
                (service, registrar) => registrar.AddServices(service)
                );
        }

        private static IReadOnlyCollection<Type> LoadRegistrarTypes()
        {
            if (_registrarTypes != null)
            {
                return _registrarTypes;
            }

            var calcs = from a in GetReferencingAssemblies()
                        from t in a.GetTypes()
                        where t.GetTypeInfo().ImplementedInterfaces.Contains(typeof(IRegistrar))
                        select t;

            return calcs.ToList().AsReadOnly();
        }

        private static IEnumerable<Assembly> GetReferencingAssemblies()
        {
            var assemblies = new List<Assembly>();
            var dependencies = DependencyContext.Default.RuntimeLibraries;

            foreach (var library in dependencies)
            {
                try
                {
                    var assembly = Assembly.Load(new AssemblyName(library.Name));
                    assemblies.Add(assembly);
                }
                catch (FileNotFoundException)
                { }
            }
            return assemblies;
        }
    }
}
