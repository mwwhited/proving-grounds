using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Common.Linq
{
    public static class LogicTools
    {
        public static IEnumerable<byte> XOR(this IEnumerable<byte> left,
                                                 IEnumerable<byte> right)
        {
            return left.SetAction(right,
                                  (l, r) => (byte)(l ^ r));
        }
        public static IEnumerable<byte> OR(this IEnumerable<byte> left,
                                                IEnumerable<byte> right)
        {
            return left.SetAction(right,
                                  (l, r) => (byte)(l | r));
        }
        public static IEnumerable<byte> AND(this IEnumerable<byte> left,
                                                 IEnumerable<byte> right)
        {
            return left.SetAction(right,
                                  (l, r) => (byte)(l & r));
        }
        public static IEnumerable<sbyte> XOR(this IEnumerable<sbyte> left,
                                                  IEnumerable<sbyte> right)
        {
            return left.SetAction(right,
                                  (l, r) => (sbyte)(l ^ r));
        }
        public static IEnumerable<sbyte> OR(this IEnumerable<sbyte> left,
                                                 IEnumerable<sbyte> right)
        {
            return left.SetAction(right,
                                  (l, r) => (sbyte)(l | r));
        }
        public static IEnumerable<sbyte> AND(this IEnumerable<sbyte> left,
                                                  IEnumerable<sbyte> right)
        {
            return left.SetAction(right,
                                  (l, r) => (sbyte)(l & r));
        }

        public static IEnumerable<short> XOR(this IEnumerable<short> left,
                                                  IEnumerable<short> right)
        {
            return left.SetAction(right,
                                  (l, r) => (short)(l ^ r));
        }
        public static IEnumerable<short> OR(this IEnumerable<short> left,
                                                 IEnumerable<short> right)
        {
            return left.SetAction(right,
                                  (l, r) => (short)(l | r));
        }
        public static IEnumerable<short> AND(this IEnumerable<short> left,
                                                  IEnumerable<short> right)
        {
            return left.SetAction(right,
                                  (l, r) => (short)(l & r));
        }
        public static IEnumerable<ushort> XOR(this IEnumerable<ushort> left,
                                                   IEnumerable<ushort> right)
        {
            return left.SetAction(right,
                                  (l, r) => (ushort)(l ^ r));
        }
        public static IEnumerable<ushort> OR(this IEnumerable<ushort> left,
                                                  IEnumerable<ushort> right)
        {
            return left.SetAction(right,
                                  (l, r) => (ushort)(l | r));
        }
        public static IEnumerable<ushort> AND(this IEnumerable<ushort> left,
                                                   IEnumerable<ushort> right)
        {
            return left.SetAction(right,
                                  (l, r) => (ushort)(l & r));
        }

        public static IEnumerable<int> XOR(this IEnumerable<int> left,
                                                IEnumerable<int> right)
        {
            return left.SetAction(right,
                                  (l, r) => (int)(l ^ r));
        }
        public static IEnumerable<int> OR(this IEnumerable<int> left,
                                               IEnumerable<int> right)
        {
            return left.SetAction(right,
                                  (l, r) => (int)(l | r));
        }
        public static IEnumerable<int> AND(this IEnumerable<int> left,
                                                IEnumerable<int> right)
        {
            return left.SetAction(right,
                                  (l, r) => (int)(l & r));
        }
        public static IEnumerable<uint> XOR(this IEnumerable<uint> left,
                                                 IEnumerable<uint> right)
        {
            return left.SetAction(right,
                                  (l, r) => (uint)(l ^ r));
        }
        public static IEnumerable<uint> OR(this IEnumerable<uint> left,
                                                IEnumerable<uint> right)
        {
            return left.SetAction(right,
                                  (l, r) => (uint)(l | r));
        }
        public static IEnumerable<uint> AND(this IEnumerable<uint> left,
                                                 IEnumerable<uint> right)
        {
            return left.SetAction(right,
                                  (l, r) => (uint)(l & r));
        }

        public static IEnumerable<long> XOR(this IEnumerable<long> left,
                                                 IEnumerable<long> right)
        {
            return left.SetAction(right,
                                  (l, r) => (long)(l ^ r));
        }
        public static IEnumerable<long> OR(this IEnumerable<long> left,
                                                IEnumerable<long> right)
        {
            return left.SetAction(right,
                                  (l, r) => (long)(l | r));
        }
        public static IEnumerable<long> AND(this IEnumerable<long> left,
                                                 IEnumerable<long> right)
        {
            return left.SetAction(right,
                                  (l, r) => (long)(l & r));
        }
        public static IEnumerable<ulong> XOR(this IEnumerable<ulong> left,
                                                  IEnumerable<ulong> right)
        {
            return left.SetAction(right,
                                  (l, r) => (ulong)(l ^ r));
        }
        public static IEnumerable<ulong> OR(this IEnumerable<ulong> left,
                                                 IEnumerable<ulong> right)
        {
            return left.SetAction(right,
                                  (l, r) => (ulong)(l | r));
        }
        public static IEnumerable<ulong> AND(this IEnumerable<ulong> left,
                                                  IEnumerable<ulong> right)
        {
            return left.SetAction(right,
                                  (l, r) => (ulong)(l & r));
        }
    }
}
