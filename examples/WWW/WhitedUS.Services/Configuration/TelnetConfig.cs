using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;

//WhitedUS.Services.Telnet.TelnetConfig
namespace WhitedUS.Services.Configuration
{
    public class TelnetConfig : ConfigurationElement
    {
        [ConfigurationProperty("port", DefaultValue = 23)]
        public int Port
        {
            get { return (int)this["port"]; }
            set { this["port"] = value; }
        }

        [ConfigurationProperty("welcomeMessage", 
            DefaultValue = "Welcome to my telnet server")]
        public string WelcomeMessage
        {
            get { return this["welcomeMessage"] as string; }
            set { this["welcomeMessage"] = value; }
        }

        [ConfigurationProperty("loginPrompt", DefaultValue = "Login: ")]
        public string LoginPrompt
        {
            get { return this["loginPrompt"] as string; }
            set { this["loginPrompt"] = value; }
        }

        [ConfigurationProperty("passwordPrompt", DefaultValue = "Password: ")]
        public string PasswordPrompt
        {
            get { return this["passwordPrompt"] as string; }
            set { this["passwordPrompt"] = value; }
        }

        [ConfigurationProperty("failedMessage", DefaultValue = "Login failed")]
        public string FailedMessage
        {
            get { return this["failedMessage"] as string; }
            set { this["failedMessage"] = value; }
        }

        [ConfigurationProperty("useMembershipProvider", DefaultValue = true)]
        public bool UseMembershipProvider
        {
            get { return (bool)this["useMembershipProvider"]; }
            set { this["useMembershipProvider"] = value; }
        }

        public static TelnetConfig CurrentConfig
        {
            get { return ServicesConfiguration.Instance.TelnetConfiguration 
                                                    ?? new TelnetConfig(); }
        }
    }
}
