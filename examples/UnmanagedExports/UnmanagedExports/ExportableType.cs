using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace UnmanagedExports
{
    public class ExportableType
    {
        public Type Type { get; set; }
        public Dictionary<string, ExportableMethod> Exports { get; set; }
    }
}
