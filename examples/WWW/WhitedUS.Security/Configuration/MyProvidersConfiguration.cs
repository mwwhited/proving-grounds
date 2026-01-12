using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;

//WhitedUS.Security.Configuration.MyProvidersConfiguration,WhitedUS.Security
namespace WhitedUS.Security.Configuration
{
    public class MyProvidersConfiguration : ConfigurationSection
    {
        [ConfigurationProperty("applicationName", IsRequired = true)]
        public string ApplicationName
        {
            get
            {
                if (string.IsNullOrEmpty(this["applicationName"] as string))
                    throw new NullReferenceException(
                        "\"myProviders/applicationName\" in the App.Config" +
                        "/Web.Config must be configured");
                return this["applicationName"] as string;
            }
            set
            {
                if (string.IsNullOrEmpty(value))
                    throw new ArgumentNullException(
                        "ApplicationName can not be null");
                this["applicationName"] = value;
            }
        }

        [ConfigurationProperty("myMembershipProvider")]
        public MyMembershipProviderConfiguration MyMembershipProvider
        {
            get
            {
                return this["myMembershipProvider"]
                    as MyMembershipProviderConfiguration;
            }
        }

        public static MyProvidersConfiguration CurrentConfig
        {
            get
            {
                return ConfigurationManager.GetSection("myProviders")
                    as MyProvidersConfiguration
                    ?? new MyProvidersConfiguration();
            }
        }
    }
}
