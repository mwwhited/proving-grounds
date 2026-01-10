using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Diagnostics;
using System.Threading;

namespace UnmanagedExports
{
    public static class CompilerTools
    {
        static readonly string ildasm =
            @"c:\Program Files\Microsoft SDKs\Windows\v6.0A\bin\ildasm.exe";
        static readonly string ilasm =
            @"C:\Windows\Microsoft.NET\Framework\v2.0.50727\ilasm.exe";

        public static string DecompileAssembly(this string assemblyFile)
        {
            var ilFile = assemblyFile + ".il";

            assemblyFile.DecompileAssembly(ilFile);

            return ilFile;
        }
        public static void DecompileAssembly(this string assemblyFile,
                                                  string ilFile)
        {
            assemblyFile = Path.GetFullPath(assemblyFile);
            ilFile = Path.GetFullPath(ilFile);
            var ildasmArgs = string.Format("\"{0}\" /out:\"{1}\" /linenum",
                                           assemblyFile,
                                           ilFile);

            if (File.Exists(ilFile))
                File.Delete(ilFile);
            assemblyFile.BlockTillRead();
            Thread.Sleep(100);
            ildasm.RunAs(ildasmArgs);
            ilFile.BlockTillRead();
        }

        public static string CompileAssembly(this string ilFile,
                                                  string buildType)
        {
            var assemblyFile = Path.ChangeExtension(ilFile, ".dll");
            ilFile.CompileAssembly(assemblyFile, "dll", buildType);
            return assemblyFile;
        }
        public static void CompileAssembly(this string ilFile,
                                                string assemblyFile,
                                                string fileType,
                                                string buildType)
        {
            ilFile.CompileAssembly(assemblyFile,
                                   fileType,
                                   buildType,
                                   null);
        }

        public static void CompileAssembly(this string ilFile,
                                                string assemblyFile,
                                                string fileType,
                                                string buildType,
                                                string resource)
        {
            ilFile.CompileAssembly(assemblyFile, 
                                   fileType, 
                                   buildType, 
                                   null, 
                                   null);
        }

        public static void CompileAssembly(this string ilFile,
                                                string assemblyFile,
                                                string fileType,
                                                string buildType,
                                                string resource,
                                                string keyFile)
        {
            ilFile = Path.GetFullPath(ilFile);
            assemblyFile = Path.GetFullPath(assemblyFile);
            resource = Path.GetFullPath(resource);
            keyFile = Path.GetFullPath(keyFile);

            var ilasmArgs = string.Format("/{2} \"{0}\" /{3} /output=\"{1}\"",
                              ilFile,
                              assemblyFile,
                              fileType,
                              buildType
                              );

            if (!string.IsNullOrEmpty(resource) && File.Exists(resource))
                ilasmArgs += string.Format(" /resource=\"{0}\"", resource);

            if (!string.IsNullOrEmpty(keyFile) && File.Exists(keyFile))
                ilasmArgs += string.Format(" /key=\"{0}\"", keyFile);

            if (File.Exists(assemblyFile))
                File.Delete(assemblyFile);
            ilFile.BlockTillRead();
            Thread.Sleep(100);
            ilasm.RunAs(ilasmArgs);
            assemblyFile.BlockTillRead();
        }
    }
}
