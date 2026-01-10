using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace UnmanagedExports
{
    public static class ExportTools
    {
        public static IEnumerable<string> ParseExports(
            this IEnumerable<string> ilLines,
                 Dictionary<string, ExportableType> exportTypes)
        {

            var skipLine = false;
            var asm = false;
            var attr = false;

            StringBuilder sb = null;

            var classRegex = new Regex(@".+\s+([^\s]+)\s+extends\s+\[.*");
            string lastClass = null;
            var getClass = false;

            var methodRegex = new Regex(@".+\s+([^\s]+)\s*\(.*");
            string lastMethod = null;
            var getmethod = false;

            int exportCount = 0;

            var totalExports = exportTypes.Values
                              .Select(c => c.Exports.Count)
                              .Sum();

            foreach (var line in ilLines)
            {
                if (line.TrimStart().StartsWith(".class "))
                {
                    getClass = true;
                    sb = new StringBuilder();
                }
                if (getClass)
                {
                    if (line.TrimStart().StartsWith("{"))
                    {
                        var match = classRegex.Match(sb.ToString());
                        lastClass = match.Groups[1].Value;

                        if (!exportTypes.ContainsKey(lastClass))
                            lastClass = null;

                        getClass = false;
                    }
                    else
                    {
                        if (sb == null)
                            sb = new StringBuilder();
                        sb.Append(line + " ");
                    }
                }

                if (lastClass != null)
                {
                    if (line.TrimStart().StartsWith(".method"))
                    {
                        getmethod = true;
                        sb = new StringBuilder();
                    }
                    if (getmethod)
                    {
                        if (line.TrimStart().StartsWith("{"))
                        {
                            var match = methodRegex.Match(sb.ToString());
                            lastMethod = match.Groups[1].Value;

                            if (!exportTypes[lastClass].Exports
                                                       .ContainsKey(lastMethod))
                                lastMethod = null;

                            getClass = false;
                        }
                        else
                        {
                            if (sb == null)
                                sb = new StringBuilder();
                            sb.Append(line + " ");
                        }
                    }
                }

                if (lastClass != null && lastMethod != null)
                {
                    if (skipLine && attr)
                    {
                        if (line.Contains(")"))
                        {
                            skipLine = false;
                            attr = false;
                            continue;
                        }
                    }
                    else
                    {
                        if (line.TrimStart().StartsWith(
                            ".custom instance void [UnmanagedExports.Common]" +
                            "UnmanagedExports.Common.DllExportAttribute"))
                        {
                            var regEx = new Regex(@"(?<atr>([^/]*))(//.*)?");
                            var match = regEx.Match(line);
                            var attrib = match.Groups["atr"];
                            var value = attrib.Value.TrimEnd();

                            exportCount++;

                            var exportItem = exportTypes[lastClass]
                                                    .Exports[lastMethod];
                            var exportName = exportItem.Export.MethodName;
                            if (string.IsNullOrEmpty(exportName))
                                exportName = exportItem.Method.Name;

                            yield return string.Format("    .vtentry {0} : 1",
                                                       exportCount);
                            yield return string.Format("    .export [{0}] as {1}",
                                                       exportCount,
                                                       exportName);

#if x64Test
                            yield return string.Format("    .export [{0}] as {1}_x64",
                                                       exportCount + totalExports,
                                                       exportName);
#endif
                            if (!value.EndsWith(")"))
                            {
                                skipLine = true;
                                attr = true;
                            }
                            continue;
                        }
                    }
                }

                if (line.StartsWith(".assembly extern UnmanagedExports"))
                {
                    skipLine = true;
                    asm = true;
                }

                if (line.StartsWith(".corflags "))
                {
                    var currentPart = line.Substring(12, 10);
                    var currentValue = int.Parse(currentPart,
                                                 NumberStyles.HexNumber);
//                    currentValue &= ~1;
//#if !x64Test
//                    currentValue |= 2;
//#endif
                    currentValue = 2;

                    var newLine = string.Format(".corflags {0}", currentValue);
                    yield return newLine;

                    for (int i = 0; i < totalExports; i++)
                    {
                        yield return string.Format(
                            ".vtfixup [1] int32 fromunmanaged at VT_{0:D2}",
                            i + 1);
                        yield return string.Format(
                            ".data VT_{0:D2} = int32(0)",
                            i + 1);

#if x64Test
                        yield return string.Format(
                            ".vtfixup [1] int64 fromunmanaged at VT_{0:D2}",
                            i + 1 + totalExports);
                        yield return string.Format(
                            ".data VT_{0:D2} = int64(0)",
                            i + 1 + totalExports);
#endif
                    }

                    continue;
                }

                if (!skipLine)
                    yield return line;
                else
                {
                    if (line.StartsWith("}") && asm)
                    {
                        skipLine = false;
                        asm = false;
                    }
                }
            }
        }
    }
}
