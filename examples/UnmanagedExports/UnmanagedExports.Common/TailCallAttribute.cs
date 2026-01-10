using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace UnmanagedExports.Common
{
    [AttributeUsage(AttributeTargets.Method)]
    public class TailCallAttribute : Attribute
    {
    }
}
