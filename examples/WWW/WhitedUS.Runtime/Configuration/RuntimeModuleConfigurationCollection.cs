using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;

namespace WhitedUS.Runtime.Configuration
{
    public class RuntimeModuleConfigurationCollection : 
        ConfigurationElementCollection
    {
        protected override ConfigurationElement CreateNewElement()
        {
            return new RuntimeModuleConfiguration();
        }

        protected override object GetElementKey(ConfigurationElement element)
        {
            return (element as RuntimeModuleConfiguration).Key;
        }
    }
}
