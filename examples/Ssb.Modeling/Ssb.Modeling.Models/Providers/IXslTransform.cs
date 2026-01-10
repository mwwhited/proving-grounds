using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ssb.Modeling.Models.Providers
{
    public interface IXslTransform
    {
        Task<Stream> Transform(Stream stylesheet, Stream source);
    }
}
