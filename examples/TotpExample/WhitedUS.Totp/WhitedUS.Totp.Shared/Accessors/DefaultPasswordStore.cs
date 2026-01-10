using System;
using System.Diagnostics;
using System.Diagnostics.Contracts;
using System.IO;
using System.Xml.Linq;

namespace WhitedUS.Totp.Shared.Accessors
{
    public class DefaultPasswordStore : ICredentialStore
    {
        public class Credential : ICredentialValue
        {
            public string Resource { get; set; }
            public string Username { get; set; }
            public string Password { get; set; }

            public XElement ToXml()
            {
                return new XElement("c",
                    new XAttribute("r", this.Resource),
                    new XAttribute("u", this.Username),
                    new XAttribute("p", this.Password)
                    );
            }

            public static ICredentialValue Load(XElement xml)
            {
                Contract.Requires(xml != null);
                return new DefaultPasswordStore.Credential
                {
                    Resource = (string)xml.Attribute("r"),
                    Username = (string)xml.Attribute("u"),
                    Password = (string)xml.Attribute("p"),
                };
            }
        }

        private string GetKey(string resource)
        {
            return string.Format(Globals.Formatters.PasswordKey, resource);
        }
        private ISettingsStore Store
        {
            get { return ObjectLocatorService.Get<ISettingsStore>(); }
        }

        public void Add(string resource, string username, string password)
        {
            var credential = new DefaultPasswordStore.Credential
            {
                Resource = resource,
                Username = username,
                Password = password,
            };
            using (var ms = new MemoryStream())
            {
                credential.ToXml().Save(ms);
                var crypto = ObjectLocatorService.Get<ICrypto>();
                var encrypted = crypto.Encrypt(ms.ToArray());
                this.Store.Add(this.GetKey(resource), encrypted);
            }
        }

        public ICredentialValue Get(string resource)
        {
            var encrypted = this.Store.Get<byte[]>(this.GetKey(resource));
            if (encrypted == null)
                return null;
            try
            {
                var crypto = ObjectLocatorService.Get<ICrypto>();
                var decrypted = crypto.Decrpyt(encrypted);
                using (var ms = new MemoryStream(decrypted))
                {
                    ms.Position = 0;
                    var xml = XElement.Load(ms);
                    var credential = DefaultPasswordStore.Credential.Load(xml);
                    return credential;
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex);
                return null;
            }
        }

        public void Clear(string resource)
        {
            this.Store.Remove(this.GetKey(resource));
        }
    }
}
