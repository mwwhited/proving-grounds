using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using UnmanagedExports.Common;

namespace UnmanagedExports
{
    public class ExportableMethod
    {
        public MethodInfo Method { get; set; }
        public DllExportAttribute Export { get; set; }
    }
}
