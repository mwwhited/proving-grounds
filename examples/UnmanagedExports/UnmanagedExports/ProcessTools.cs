using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Diagnostics;

namespace UnmanagedExports
{
    public static class ProcessTools
    {
        public static string RunAs(this string processFile)
        {
            return processFile.RunAs(String.Empty);
        }
        public static string RunAs(this string processFile, string args)
        {
            processFile = Path.GetFullPath(processFile);
            using (var proc = Process.Start(processFile, args))
            {
                proc.StartInfo.RedirectStandardError = true;
                proc.StartInfo.RedirectStandardInput = true;
                proc.StartInfo.RedirectStandardOutput = true;
                proc.StartInfo.UseShellExecute = false;
                if (proc.Start())
                {
                    proc.WaitForExit();
                    var err = proc.StandardError.ReadToEnd();
                    var std = proc.StandardOutput.ReadToEnd();
                    Debug.WriteLine(err);
                    var ret = proc.ExitCode;
                    if (ret != 0)
                        throw new InvalidOperationException(string.Format(
                            "ilasm: {0}",
                            ret));
                    return std;
                }
                else
                    throw new InvalidOperationException("ilasm failed");
            }
        }
    }
}
