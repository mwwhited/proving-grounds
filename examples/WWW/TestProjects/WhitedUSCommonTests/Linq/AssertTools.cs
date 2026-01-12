using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUSCommonTests.Linq
{
    public static class AssertTools
    {
        public static bool DoesntMatch<T>(this IEnumerable<T> l, T[] r)
        {
            return l.Where((v, i) => !v.Equals(r[i]))
                    .Any();
        }
    }
}
