using OobDev.Common.Accessors;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Windows.Security.Credentials;

namespace OobDev.Common.Accessors
{
    //https://code.msdn.microsoft.com/windowsapps/PasswordVault-f01be74a
    public class UniversalCredentialStore : ICredentialStore
    {
        internal class Credential : ICredentialValue
        {
            public string Resource { get; internal set; }
            public string Username { get; internal set; }
            public string Password { get; internal set; }
            public IEnumerable<KeyValuePair<string, string>> Properties { get; internal set; }

            public static explicit operator Credential(PasswordCredential pc)
            {
                if (pc == null)
                    return null;
                pc.RetrievePassword();
                return new Credential
                {
                    Resource = pc.Resource,
                    Username = pc.UserName,
                    Password = pc.Password,
                };
            }
        }

        private PasswordVault Vault { get; } = new PasswordVault();
        private ISettingsStore SettingsStore { get; }

        public UniversalCredentialStore(ISettingsStore settingsStore)
        {
            this.SettingsStore = settingsStore;
        }

        public ICredentialValue Get(string resource)
        {
            var pc = this.Vault.RetrieveAll().FirstOrDefault(r => r.Resource == resource);
            var credential = (Credential)pc;

            if (credential == null)
                return null;

            var extensionKey = $"{resource}+Properties";
            var setting = this.SettingsStore.Get<IEnumerable<KeyValuePair<string, string>>>(extensionKey);
            credential.Properties = setting?.ToArray() ?? Enumerable.Empty<KeyValuePair<string,string>>();

            return credential;
        }

        public void Clear(string resource)
        {
            var pc = this.Vault.RetrieveAll()
                               .FirstOrDefault(r => r.Resource == resource);
            if (pc != null)
                this.Vault.Remove(pc);

            var settingStore = ObjectLocatorService.Get<ISettingsStore>();
            var extensionKey = $"{resource}+Properties";
            settingStore.Remove(extensionKey);
        }

        public void Add(ICredentialValue credential)
        {
            if (!string.IsNullOrWhiteSpace(credential.Resource)
                && !string.IsNullOrWhiteSpace(credential.Username)
                && !string.IsNullOrWhiteSpace(credential.Password))
            {
                this.Vault.Add(new PasswordCredential(credential.Resource, credential.Username, credential.Password));

                var extensionKey = $"{credential.Resource}+Properties";
                this.SettingsStore.Add(extensionKey, credential.Properties);
            }
        }
    }
}
