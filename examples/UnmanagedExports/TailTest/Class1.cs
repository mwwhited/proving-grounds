using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using ExportTest;
using System.IO;
using System.Reflection;

namespace TailTest
{
    public class Class1
    {
        public static void Main(string[] args)
        {
            //var assemblyFile = Path.GetFullPath("ExportTest.extern.dll");
            //var assembly = Assembly.LoadFrom(assemblyFile);
            //int val = 0;
            //ExportTest..TailCalls.Sum(ref val);

            var c = new ExportTest.Class1();
        }
    }
}
