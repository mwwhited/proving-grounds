using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace UnmanagedExports.Common
{
    [AttributeUsage(AttributeTargets.Method)]
    public class DllExportAttribute : Attribute 
    {
        private static int _id;

        public DllExportAttribute()
        {
            this.ID = _id;
            _id++;
        }
        public DllExportAttribute(string methodName) : this()
        {
            var check = new Regex("^[A-Za-z][A-Za-z0-9_]*$");
            if (!check.IsMatch(methodName))
                throw new InvalidOperationException();
            this.MethodName = methodName;
        }

        public string MethodName { get; protected set; }
        public int ID { get; protected set; }

        public override string ToString()
        {
            return this.MethodName;
        }
    }
}
