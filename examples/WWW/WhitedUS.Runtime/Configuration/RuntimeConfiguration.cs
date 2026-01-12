using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;

//WhitedUS.Runtime.Configuration.RuntimeConfiguration,WhitedUS.Runtime
namespace WhitedUS.Runtime.Configuration
{
    public class RuntimeConfiguration : ConfigurationSection
    {
        [ConfigurationProperty("runtimeModules", IsRequired = true)]
        public RuntimeModuleConfigurationCollection RuntimeModules
        {
            get
            {
                return this["runtimeModules"]
                    as RuntimeModuleConfigurationCollection;
            }
            set { this["runtimeModules"] = value; }
        }

        public static RuntimeConfiguration Instance
        {
            get
            {
                return ConfigurationManager.GetSection("runtimeConfiguration")
                    as RuntimeConfiguration;
            }
        }
    }
}
