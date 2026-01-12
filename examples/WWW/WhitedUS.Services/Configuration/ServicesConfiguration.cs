using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;

//WhitedUS.Services.Configuration.ServicesConfiguration,WhitedUS.Services
namespace WhitedUS.Services.Configuration
{
    public class ServicesConfiguration : ConfigurationSection
    {
        [ConfigurationProperty("telnetConfig")]
        public TelnetConfig TelnetConfiguration
        {
            get { return this["telnetConfig"] as TelnetConfig; }
            set { this["telnetConfig"] = value; }
        }

        public static ServicesConfiguration Instance
        {
            get
            {
                return ConfigurationManager.GetSection("servicesConfiguration") 
                                            as ServicesConfiguration 
                                            ?? new ServicesConfiguration();
            }
        }
    }
}
