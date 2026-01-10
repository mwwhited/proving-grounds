using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace UnmanagedExports
{
    public static class TailCallTools
    {
        public static IEnumerable<string> ParseTailCalls(
                                            this IEnumerable<string> ilLines)
        {
            var skipLine = false;
            var asm = false;

            var inMethod = false;
            var isTailCall = false;

            var patternMethod = new Regex(@"^([^:]*:)?\s+call\s+.*");

            var methodInstrs = new List<string>();

            foreach (var line in ilLines)
            {
                var trimmed = line.TrimStart();
                if (trimmed.StartsWith(".method"))
                    inMethod = true;
                if (inMethod)
                {
                    if (trimmed.StartsWith(
                        ".custom instance void [UnmanagedExports.Common]" +
                        "UnmanagedExports.Common.TailCallAttribute::"))
                    {
                        isTailCall = true;
                        continue;
                    }

                    if (trimmed.StartsWith("}"))
                    {
                        if (isTailCall)
                        {
                            var cnt = methodInstrs.Count;
                            for (int i = 0; i < cnt; i++)
                            {
                                var adjustedIndex = cnt - 1 - i;
                                var methodLine = methodInstrs[adjustedIndex];
                                if (patternMethod.IsMatch(methodLine))
                                {
                                    methodInstrs.Insert(adjustedIndex, "tail.");
                                    break;
                                }
                            }
                        }

                        foreach (var methodLine in methodInstrs)
                            yield return methodLine;
                        methodInstrs.Clear();
                        inMethod = false;
                        isTailCall = false;
                    }
                    else
                    {
                        methodInstrs.Add(line);
                        continue;
                    }
                }

                if (line.StartsWith(".assembly extern UnmanagedExports"))
                {
                    skipLine = true;
                    asm = true;
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
