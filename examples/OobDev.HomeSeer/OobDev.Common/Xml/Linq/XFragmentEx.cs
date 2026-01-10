using System.Collections.Generic;
using System.Xml.Linq;

namespace OobDev.Common.Xml.Linq
{
    public static class XFragmentEx
    {
        public static XFragment ToXFragment(this IEnumerable<XNode> nodes)
        {
            return new XFragment(nodes);
        }
    }
}
