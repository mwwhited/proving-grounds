using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace INotifyPropertyChangedFactory
{
    [AttributeUsage(AttributeTargets.Property)]
    public class NotifiableAttribute : Attribute
    {
        public IEnumerable<string> PropertyNames { get; private set; }
        public NotifiableAttribute(params string[] propertyNames)
        {
            this.PropertyNames = propertyNames;
        }
    }
}
