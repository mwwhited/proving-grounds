using System;
using System.Collections.Generic;
using System.IO;
using System.IO.IsolatedStorage;
using System.Linq;
using System.Net;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace OobDev.Common.Accessors
{
    public class WindowsSettingsStore : ISettingsStore
    {
        public T Add<T>(string key, T value)
        {
            var ndc = new NetDataContractSerializer();
            using (var isoStore = IsolatedStorageFile.GetStore(IsolatedStorageScope.User | IsolatedStorageScope.Assembly | IsolatedStorageScope.Domain,null, null))
            {
                if (!isoStore.DirectoryExists("Settings"))
                    isoStore.CreateDirectory("Settings");

                var filepath = Path.Combine("Settings", $"Setting.{WebUtility.UrlEncode(key)}");

                using (var isoStream = isoStore.OpenFile(filepath, FileMode.Create, FileAccess.Write))
                {
                    ndc.Serialize(isoStream, value);
                }
            }
            return value;
        }

        public T Get<T>(string key)
        {
            var ndc = new NetDataContractSerializer();
            using (var isoStore = IsolatedStorageFile.GetStore(IsolatedStorageScope.User | IsolatedStorageScope.Assembly | IsolatedStorageScope.Domain, null, null))
            {
                if (!isoStore.DirectoryExists("Settings"))
                    return default(T);

                var filepath = Path.Combine("Settings", $"Setting.{WebUtility.UrlEncode(key)}");

                using (var isoStream = isoStore.OpenFile(filepath, FileMode.Open, FileAccess.Read))
                {
                    var obj = ndc.Deserialize(isoStream);
                    return (T)obj;
                }
            }
        }

        public void Remove(string key)
        {
            using (var isoStore = IsolatedStorageFile.GetUserStoreForApplication())
            {
                if (isoStore.DirectoryExists("Settings"))
                {
                    var filepath = Path.Combine("Settings", $"Setting.{WebUtility.UrlEncode(key)}");
                    if (isoStore.FileExists(filepath))
                        isoStore.DeleteFile(filepath);
                }
            }
        }
    }
}
