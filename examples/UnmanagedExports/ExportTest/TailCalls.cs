using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnmanagedExports.Common;

namespace ExportTest
{
    public class TailCalls
    {
        [TailCall]
        public static void Sum(ref int input)
        {
            input++;
            Console.WriteLine(input);
            Add(ref input, 2);
        }

        [TailCall]
        public static void Add(ref int input, int val)
        {
            input += val;
            Console.WriteLine(input);
            Sum(ref input);
        }
    }
}
