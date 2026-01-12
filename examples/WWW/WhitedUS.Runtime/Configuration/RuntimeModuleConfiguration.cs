using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using WhitedUS.Common;
using System.ComponentModel;
using WhitedUS.Runtime.Definitions;

namespace WhitedUS.Runtime.Configuration
{
    public class RuntimeModuleConfiguration : ConfigurationElement
    {
        [ConfigurationProperty("key", IsKey = true)]
        public string Key
        {
            get { return this["key"] as string; }
            set { this["key"] = value; }
        }

        [TypeConverter(typeof(TypeTypeConverter))]
        [ConfigurationProperty("moduleType", IsRequired = true)]
        public Type ModuleType
        {
            get { return this["moduleType"] as Type; }
            set { this["moduleType"] = value; }
        }

        public IRuntimeModule CreateInstance()
        {
            return ModuleType.GetConstructor(Type.EmptyTypes).Invoke(null)
                                                        as IRuntimeModule;
        }

        public void Invoke()
        {
            CreateInstance().Start();
        }
    }
}
