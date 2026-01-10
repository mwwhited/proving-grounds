using Ssb.Modeling.Models.Providers;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ssb.Modeling.Wpf.Providers
{
    public class ResourceLoader : IResourceLoader
    {
        public Task<Stream> GetResource(string resourceName)
        {
            return Task.Run(()=>typeof(IResourceLoader).Assembly.GetManifestResourceStream(resourceName));
        }
    }
}
