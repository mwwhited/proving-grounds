using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Diagnostics.Contracts;
using System.IO;
using System.Linq;
using System.Xml.Linq;

namespace OobDev.Common.Accessors
{
    public class DefaultCredentialStore : ICredentialStore
    {
        public class Credential : ICredentialValue
        {
            public string Resource { get; set; }
            public string Username { get; set; }
            public string Password { get; set; }
            public IEnumerable<KeyValuePair<string, string>> Properties { get; set; }

            public XElement ToXml()
            {
                return new XElement("c",
                    new XAttribute("r", this.Resource ?? ""),
                    new XAttribute("u", this.Username ?? ""),
                    new XAttribute("p", this.Password ?? ""),
                    from p in (this.Properties ?? Enumerable.Empty<KeyValuePair<string, string>>())
                    select new XElement("x",
                        new XAttribute("k", p.Key ?? ""),
                        new XAttribute("v", p.Value)
                        )
                    );
            }

            public static ICredentialValue Load(XElement xml)
            {
                Contract.Requires(xml != null);
                return new DefaultCredentialStore.Credential
                {
                    Resource = (string)xml.Attribute("r"),
                    Username = (string)xml.Attribute("u"),
                    Password = (string)xml.Attribute("p"),
                    Properties = (from pXml in xml.Elements("x")
                                  select new KeyValuePair<string, string>(
                                      (string)pXml.Attribute("k"),
                                      (string)pXml.Attribute("v")
                                  )).ToArray(),

                };
            }
        }

        private string GetKey(string resource)
        {
            return string.Format(CommonGlobals.Formatters.PasswordKey, resource);
        }
        private ISettingsStore Store
        {
            get { return ObjectLocatorService.Get<ISettingsStore>(); }
        }

        public void Add(ICredentialValue credential)
        {
            var iCredential = (credential as DefaultCredentialStore.Credential) ?? new DefaultCredentialStore.Credential
            {
                Resource = credential.Resource,
                Username = credential.Username,
                Password = credential.Password,
                Properties = (credential.Properties ?? Enumerable.Empty<KeyValuePair<string, string>>()).ToArray()
            };
            using (var clearStream = new MemoryStream())
            using (var encryptedStream = new MemoryStream())
            {
                iCredential.ToXml().Save(clearStream);
                var crypto = ObjectLocatorService.Get<ICrypto>();
                var key = crypto.GenerateKey(128);
                var salt = crypto.GenerateKey(16);
                var encrypted = crypto.EncryptAES(key, salt, clearStream.ToArray());

                encryptedStream.Write(salt, 0, salt.Length);
                encryptedStream.Write(encrypted, 0, encrypted.Length);
                encryptedStream.Write(key, 0, key.Length);

                this.Store.Add(this.GetKey(credential.Resource), encryptedStream.ToArray());
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
                using (var clearStream = new MemoryStream())
                {
                    var salt = new byte[16];
                    var key = new byte[128];
                    Array.Copy(encrypted, 0, salt, 0, salt.Length);
                    Array.Copy(encrypted, encrypted.Length - key.Length, key, 0, key.Length);
                    var encryptedBuffer = new byte[encrypted.Length - 16 - 128];
                    Array.Copy(encrypted, 16, encryptedBuffer, 0, encryptedBuffer.Length);

                    var decrypted = crypto.DecrpytAES(key, salt, encryptedBuffer);
                    using (var ms = new MemoryStream(decrypted))
                    {
                        ms.Position = 0;
                        var xml = XElement.Load(ms);
                        var credential = DefaultCredentialStore.Credential.Load(xml);
                        return credential;
                    }
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
