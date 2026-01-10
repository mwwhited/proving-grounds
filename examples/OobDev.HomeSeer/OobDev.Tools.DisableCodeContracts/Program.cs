using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace OobDev.Tools.DisableCodeContracts
{
    class Program
    {
        static void Main(string[] args)
        {
            var ns = (XNamespace)"http://schemas.microsoft.com/developer/msbuild/2003";
            var csprojFiles = Directory.EnumerateFiles("../../..", "*.csproj", SearchOption.AllDirectories);

            foreach (var csprojFile in csprojFiles)
            {
                var xml = XElement.Load(csprojFile);
                var changed = false;
                var codeContractsRunCodeAnalysis = xml.Descendants(ns + "CodeContractsRunCodeAnalysis").FirstOrDefault();
                if (codeContractsRunCodeAnalysis != null && !(bool)codeContractsRunCodeAnalysis)
                {
                    codeContractsRunCodeAnalysis.Value = "true";
                    changed = true;
                }

                var runCodeAnalysis = xml.Descendants(ns + "RunCodeAnalysis").FirstOrDefault();
                if (runCodeAnalysis != null && !(bool)runCodeAnalysis)
                {
                    runCodeAnalysis.Value = "true";
                    changed = true;
                }

                var codeContractsReferenceAssembly = xml.Descendants(ns + "CodeContractsReferenceAssembly").FirstOrDefault();
                if (codeContractsReferenceAssembly != null && (string)codeContractsReferenceAssembly != "Build") 
                {
                    codeContractsReferenceAssembly.Value = "Build";
                    changed = true;
                }

                if (changed)
                {
                    Console.WriteLine($"Update: {csprojFile}");
                    xml.Save(csprojFile);
                }

            }

        }
    }
}
