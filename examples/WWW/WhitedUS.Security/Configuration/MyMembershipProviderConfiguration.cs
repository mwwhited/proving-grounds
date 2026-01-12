using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using System.Reflection;
using System.ComponentModel;
using WhitedUS.Security.Utilities;
using WhitedUS.Libs.Security.Crypt;
using System.Diagnostics;

//WhitedUS.Security.Configuration.MyMembershipProviderConfiguration,WhitedUS.Security
namespace WhitedUS.Security.Configuration
{
    public class MyMembershipProviderConfiguration : ConfigurationElement
    {
        [ConfigurationProperty("maxInvalidPasswordAttempts", DefaultValue = 5)]
        public int MaxInvalidPasswordAttempts
        {
            get { return (int)this["maxInvalidPasswordAttempts"]; }
            set { this["maxInvalidPasswordAttempts"] = value; }
        }

        [ConfigurationProperty("minRequiredNonAlphanumericCharacters", 
            DefaultValue = 1)]
        public int MinRequiredNonAlphanumericCharacters
        {
            get { return (int)this["minRequiredNonAlphanumericCharacters"]; }
            set { this["minRequiredNonAlphanumericCharacters"] = value; }
        }

        [ConfigurationProperty("minRequiredPasswordLength", DefaultValue = 7)]
        public int MinRequiredPasswordLength
        {
            get { return (int)this["minRequiredPasswordLength"]; }
            set { this["minRequiredPasswordLength"] = value; }
        }

        [ConfigurationProperty("passwordAttemptWindow", DefaultValue = 30)]
        public int PasswordAttemptWindow
        {
            get { return (int)this["passwordAttemptWindow"]; }
            set { this["passwordAttemptWindow"] = value; }
        }

        [ConfigurationProperty("passwordStrengthRegularExpression", 
            DefaultValue = (string)null)]
        public string PasswordStrengthRegularExpression
        {
            get { return this["passwordStrengthRegularExpression"] as string; }
            set { this["passwordStrengthRegularExpression"] = value; }
        }

        [ConfigurationProperty("passwordGeneratorClass", 
            DefaultValue = typeof(MyPasswordGenerator))]
        [TypeConverter(typeof(StringToType))]
        public Type PasswordGeneratorClass
        {
            get { return this["passwordGeneratorClass"] as Type 
                ?? typeof(MyPasswordGenerator); }
            set { this["passwordGeneratorClass"] = value; }
        }

        [ConfigurationProperty("passwordGeneratorStaticMethodName", 
            DefaultValue = "GeneratePassword")]
        public string PasswordGeneratorStaticMethodName
        {
            get { return this["passwordGeneratorStaticMethodName"] as string; }
            set { this["passwordGeneratorStaticMethodName"] = value; }
        }

        [ConfigurationProperty("passwordICryptClass", 
            DefaultValue = typeof(MyCrypt))]
        [TypeConverter(typeof(StringToType))]
        public Type PasswordICryptClass
        {
            get
            {
                Type returnVal = this["passwordICryptClass"] as Type 
                    ?? typeof(MyCrypt);

                if (returnVal.GetInterface(typeof(ICrypt).FullName) == null)
                {
                    Debug.WriteLine("\"passwordICryptClass\" must inherit " +
                                    "\"WhitedUS.Libs.Security.Crypt.ICrypt," +
                                    "WhitedUS.Libs\"");
                    returnVal = typeof(MyCrypt);
                }

                return returnVal;
            }
            set
            {
                if (value == null || 
                    value.GetInterface(typeof(ICrypt).FullName) == null)
                {
                    Debug.WriteLine("\"passwordICryptClass\" must inherit " +
                                    "\"WhitedUS.Libs.Security.Crypt.ICrypt," +
                                    "WhitedUS.Libs\"");
                    value = typeof(MyCrypt);
                }

                this["passwordICryptClass"] = value;
            }
        }

        public string GetPassword()
        {
            return PasswordGenerator();
        }

        public static string PasswordGenerator()
        {
            if (CurrentConfig.PasswordGeneratorClass == null)
                throw new NullReferenceException(
                    "Password Generator Class can not be null");

            MethodInfo mi = CurrentConfig.PasswordGeneratorClass
                .GetMethod(CurrentConfig.PasswordGeneratorStaticMethodName);
            if (mi == null)
                throw new NullReferenceException(
                    "No Password Generator found");

            string password = mi.Invoke(null, null) as string;

            if (string.IsNullOrEmpty(password))
                throw new NullReferenceException("No Password Generated");

            return password;
        }

        public static MyMembershipProviderConfiguration CurrentConfig
        {
            get { return MyProvidersConfiguration.CurrentConfig
                                                 .MyMembershipProvider; }
        }
    }
}