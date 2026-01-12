using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;
using System.Threading;
using WhitedUS.Libs.Xml.Xsl;

namespace WhitedUS.Libs.Xml.Linq
{
    public static class ObjectTools
    {
        private static Dictionary<Type, string> _namespaceCache = new Dictionary<Type, string>();
        public static string ResolveNamespace(this Type type)
        {
            if (type == null) return string.Empty;

            lock (_namespaceCache)
                if (_namespaceCache.ContainsKey(type))
                    return _namespaceCache[type];

            var attribute = type.GetCustomAttributes(typeof(XmlRootAttribute), true)
                                .OfType<XmlRootAttribute>()
                                .Select(s => s.Namespace)
                                .FirstOrDefault();

            if (string.IsNullOrEmpty(attribute))
                attribute = "clr-type:" + type.AssemblyQualifiedName;

            lock (_namespaceCache)
                if (!_namespaceCache.ContainsKey(type))
                    _namespaceCache.Add(type, attribute);

            return attribute;
        }
        public static string ResolveNamespace(this object input)
        {
            if (input == null) return string.Empty;

            var resolvable = input as INamespaceResolvable;
            if (resolvable != null) return resolvable.ResolveNamespace();

            return input.GetType().ResolveNamespace();
        }
    }
}
