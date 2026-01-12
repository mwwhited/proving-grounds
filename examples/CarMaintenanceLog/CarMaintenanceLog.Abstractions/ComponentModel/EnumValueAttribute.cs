using System;

namespace CarMaintenanceLog.Abstractions.ComponentModel
{
    [AttributeUsage(AttributeTargets.Field, AllowMultiple = false, Inherited = false)]
    public class EnumValueAttribute : Attribute
    {
        public EnumValueAttribute(string name)
        {
            this.Name = name;
        }

        public string Name { get; private set; }
    }
}
