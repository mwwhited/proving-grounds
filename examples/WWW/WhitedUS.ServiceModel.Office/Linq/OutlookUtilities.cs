using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using Microsoft.Office.Interop.Outlook;

namespace WhitedUS.ServiceModel.Office.Linq
{
    public static class OutlookUtilities
    {
        public static IQueryable<T> GetItems<T>(
                                    this OlDefaultFolders defaultFolderType)
        {
            return
                new ApplicationClass()
                .Session
                .GetDefaultFolder(defaultFolderType)
                .Items
                .OfType<T>()
                .AsQueryable();
        }

        public static XElement ToXml<T>(this IEnumerable<T> input)
        {
            if (input == null)
                return null;

            Type typ = typeof(T);
            var root = XName.Get(typ.Name.Trim('_'));
            
            return new XElement(root,
                input
                .Select(x => x.ToXml<T>())
                .Where(x => x != null)
                );
        }

        public static XElement ToXml<T>(this object input)
        {
            if (input == null)
                return null;

            Type typ = typeof(T);
            var root = XName.Get(typ.Name.Trim('_'));

            return new XElement(root,
                typ.GetProperties()
                .Where(p => p.PropertyType.IsValueType 
                            || p.PropertyType == typeof(string))
                .Select(p => new { Prop = p, Getter = p.GetGetMethod() })
                .Where(p => p.Getter != null)
                .Select(p => new { Prop = p.Prop, 
                                   Getter = p.Getter, 
                                   Params = p.Getter.GetParameters() })
                .Where(p => (p.Params == null || p.Params.Count() <= 0))
                .Select(p => new { Name = p.Prop.Name, 
                                   Value = p.Getter.Invoke(input, null) })
                .Where(p => p.Value != null)
                .Select(p => new XAttribute(XName.Get(p.Name), p.Value))
                );
        }
    }
}
