using System;
using UnmanagedExports.Common;

namespace ExportTest
{
    public class Class1
    {
        [DllExport]
        public static string SayHello(string name)
        {
           return string.Format("Hello {0}", name);
        }

        [DllExport]
        public static void Write()
        {
            Console.WriteLine("write");
        }
    }
}
