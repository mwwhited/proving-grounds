using System;
using System.Collections.Generic;
using System.IO;
using System.Threading;

namespace UnmanagedExports
{
    public static class IOTools
    {
        public static void BlockTillRead(this string inputfile)
        {
            if (File.Exists(inputfile))
            {
                int errorCount = 0;
            retryRead:
                try
                {
                    using (var fs = File.Open(inputfile,
                                              FileMode.Open,
                                              FileAccess.Read,
                                              FileShare.Read))
                    {
                    }
                }
                catch (Exception)
                {
                    errorCount++;
                    if (errorCount > 5)
                        throw;
                    Thread.Sleep(100);
                    goto retryRead;
                }
            }
        }
        public static void BlockTillWrite(this string inputfile)
        {
            if (File.Exists(inputfile))
            {
                int errorCount = 0;
            retryRead:
                try
                {
                    using (var fs = File.Open(inputfile,
                                              FileMode.Open,
                                              FileAccess.Write,
                                              FileShare.None))
                    {
                    }
                }
                catch (Exception)
                {
                    errorCount++;
                    if (errorCount > 5)
                        throw;
                    Thread.Sleep(100);
                    goto retryRead;
                }
            }
        }

        public static void WriteLinesTo(this IEnumerable<string> lines, 
                                             string fileName)
        {
            using (var writer = new StreamWriter(fileName))
                lines.WriteLinesTo(writer);
        }
        public static void WriteLinesTo(this IEnumerable<string> lines, 
                                             StreamWriter writer)
        {
            foreach (var line in lines)
                writer.WriteLine(line);
        }

        public static StreamReader OpenReader(this string fileName)
        {
            return new StreamReader(fileName);
        }
        public static IEnumerable<string> ReadAsLines(this string fileName)
        {
            using (var reader = new StreamReader(fileName))
                foreach (var line in reader.ReadAsLines())
                    yield return line;
        }
        public static IEnumerable<string> ReadAsLines(this StreamReader reader)
        {
            while (!reader.EndOfStream)
                yield return reader.ReadLine();
        }
    }
}
