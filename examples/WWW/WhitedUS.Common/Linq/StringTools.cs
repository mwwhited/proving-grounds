using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace WhitedUS.Common.Linq
{
    public static class StringTools
    {
        public static IEnumerable<string> AsLines(this string filename)
        {
            using (var reader = new StreamReader(filename))
                while (!reader.EndOfStream)
                    yield return reader.ReadLine();
        }
    }
}
