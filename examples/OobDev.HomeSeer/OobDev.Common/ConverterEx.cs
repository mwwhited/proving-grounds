using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OobDev.Common
{
    public static class ConverterEx
    {
        public static int ParseInt32Safe(string input, int @default = 0)
        {
            int result;
            if (int.TryParse(input, out result))
                return result;
            return @default;
        }
    }
}
