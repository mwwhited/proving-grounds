using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading;
using System.Text.RegularExpressions;
using UnmanagedExports.Common;

namespace UnmanagedExports
{
    static class Program
    {
        static void Main(string[] args)
        {
            // @"..\..\..\ExportTest\bin\Debug\ExportTest.dll";
            var dllFile = args[0];
            var keyFile = @"UnmangedExports.snk";

            var buildType = "debug";

            //get set of types
            var exportTypes = dllFile.GetExportableTypes();

            //decompile existing assembly
            var ilFile = dllFile.DecompileAssembly();
            var asmExt = Path.GetExtension(dllFile);
            var fileType = asmExt.Trim('.');
            var ilExternFile = Path.ChangeExtension(dllFile,
                                                    ".extern" + asmExt + ".il");
            var resourceFile = dllFile + ".res";
            var externDll = Path.Combine(
                Path.GetDirectoryName(ilExternFile),
                Path.GetFileNameWithoutExtension(ilExternFile)
                );

            //post process il
            var ilLines = ilFile.ReadAsLines();
            var exportLines = ilLines.ParseExports(exportTypes);
            var keyLines = exportLines.ParseStrongKey(keyFile);
            var tailCalls = keyLines.ParseTailCalls();

            var outLines = tailCalls;

            outLines.WriteLinesTo(ilExternFile);

            //compile exports
            ilExternFile.CompileAssembly(externDll, 
                                         fileType, 
                                         buildType, 
                                         resourceFile,
                                         keyFile);

        }
    }
}
