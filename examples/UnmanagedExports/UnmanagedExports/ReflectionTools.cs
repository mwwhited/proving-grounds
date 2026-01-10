using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnmanagedExports.Common;
using System.Reflection;
using System.IO;

namespace UnmanagedExports
{
    public static class ReflectionTools
    {
        public static Dictionary<string, ExportableType> GetExportableTypes(
            this string assemblyFile)
        {
            assemblyFile = Path.GetFullPath(assemblyFile);
            var assembly = Assembly.LoadFile(assemblyFile);
            var exportTypes = from t in assembly.GetTypes()
                              let methods = t.GetExportableMethods()
                              where methods != null && methods.Any()
                              select new ExportableType
                              {
                                  Type = t,
                                  Exports = methods
                              };
            var exportTypesDict = exportTypes.ToDictionary(k => k.Type.FullName);
            return exportTypesDict;
        }

        public static Dictionary<string, ExportableMethod> GetExportableMethods(
            this Type type)
        {
            var methods = from method in type.GetMethods(BindingFlags.Static |
                                                         BindingFlags.Public)
                          let a = method.GetCustomAttributes<DllExportAttribute>()
                          where a != null && a.Any()
                          select new ExportableMethod
                          {
                              Method = method,
                              Export = a.First() as DllExportAttribute
                          };
            var methodDict = methods.ToDictionary(k => k.Method.Name);
            return methodDict;
        }

        public static IEnumerable<TAttrib> GetCustomAttributes<TAttrib>(
            this ICustomAttributeProvider input
            ) where TAttrib : Attribute
        {
            return input.GetCustomAttributes<TAttrib>(false);
        }

        public static IEnumerable<TAttrib> GetCustomAttributes<TAttrib>(
            this ICustomAttributeProvider input,
            bool inherit
            ) where TAttrib : Attribute
        {
            return input.GetCustomAttributes(typeof(TAttrib), inherit)
                         .OfType<TAttrib>();
        }
    }
}
