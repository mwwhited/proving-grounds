using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Common.Linq
{
    public static class EnumerableTools
    {
        public static void ForEach<T>(this IEnumerable<T> input,
                                           Action<T> action)
        {
            foreach (var item in input)
                action(item);
        }
    }
}
