using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Data.SourceCode
{
    public interface ISharedSource
    {
        Guid UniqueID { get; set; }
        string Name { get; set; }
    }
}
