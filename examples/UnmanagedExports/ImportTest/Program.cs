using System.Runtime.InteropServices;
using System.IO;

namespace ImportTest
{
    class Program
    {
        //const string dll = @"..\..\..\ExportTest\bin\Debug\ExportTest.extern.dll";
        const string dll = @"C:\Users\Matthew Whited\Documents\CodeSets\evenger\UnmanagedExports\UnmanagedExports\bin\x86\Debug\ExportTest.extern.dll";

        [DllImport(dll, EntryPoint = "SayHello")]
        static extern string SayHello(string name);

        [DllImport(dll, EntryPoint = "Write")]
        static extern string Write();

        static void Main(string[] args)
        {
            var full = Path.GetFullPath(dll);
            Write();
            var t = SayHello("what");
        }
    }
}
