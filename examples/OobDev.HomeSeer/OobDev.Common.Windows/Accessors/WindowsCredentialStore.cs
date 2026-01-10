using CredentialManagement;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using OobDev.Common.SimpleSerializers;

namespace OobDev.Common.Accessors
{
    public class WindowsCredentialStore : ICredentialStore
    {
        //Note: replace this uses Windows Credential Management
        private readonly Dictionary<string, ICredentialValue> _store = new Dictionary<string, ICredentialValue>();

        public void Add(ICredentialValue credential)
        {
            var c = new Credential
            {
                Target = credential.Resource,
                PersistanceType = PersistanceType.LocalComputer,
                Type = CredentialType.Generic,

                Username = credential.Username ?? "",
                Password = credential.Password ?? "",

                Description = credential.Properties?.ToSimpleXml().ToString(),
            };
            c.Save();
        }

        public void Clear(string resource)
        {
            var c = new Credential
            {
                Target = resource,
                PersistanceType = PersistanceType.LocalComputer,
            };
            if (c.Exists())
            {
                c.Delete();
            }
        }

        public ICredentialValue Get(string resource)
        {
            var c = new Credential
            {
                Target = resource,
                PersistanceType = PersistanceType.LocalComputer,
            };
            if (c.Exists())
            {
                c.Load();

                var r = new DefaultCredentialStore.Credential
                {
                    Resource = resource,
                    Username = c.Username,
                    Password = c.Password,
                    Properties = c.Description.ToKeyValuePair(),
                };
                return r;
            }
            else
            {
                return null;
            }
        }
    }
}
