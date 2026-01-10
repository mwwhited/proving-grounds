using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ssb.Modeling.Models.Providers
{
    public interface IResourceLoader
    {
        Task<Stream> GetResource(string resourceName);
    }
}
