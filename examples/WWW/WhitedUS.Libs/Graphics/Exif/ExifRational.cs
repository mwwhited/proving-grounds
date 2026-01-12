using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Libs.Graphics.Exif
{
    public class ExifRational
    {
        public uint Numerator { get; set; }
        public uint Denominator { get; set; }

        public override string ToString()
        {
            return string.Format("{0}/{1}", Numerator, Denominator);
        }

        public static implicit operator double(ExifRational rational)
        {
            return (double)rational.Numerator / (double)rational.Denominator;
        }

        public static implicit operator byte[](ExifRational rational)
        {
            byte[] buffer = new byte[8];

            Array.Copy(ExifType.LONG.GetData(rational.Numerator), 0, buffer, 0, 4);
            Array.Copy(ExifType.LONG.GetData(rational.Denominator), 0, buffer, 4, 4);

            return buffer;
        }

        public static implicit operator ExifRational(byte[] data)
        {
            byte[] ab1 = new byte[data.Length / 2];
            byte[] ab2 = new byte[data.Length / 2];

            Array.Copy(data, ab1, data.Length / 2);
            Array.Copy(data, data.Length / 2, ab2, 0, data.Length / 2);

            ExifRational rational = new ExifRational()
            {
                Numerator = (uint)ExifType.LONG.GetValue(ab1),
                Denominator = (uint)ExifType.LONG.GetValue(ab2)
            };

            return rational;
        }

        public static implicit operator ExifRational(double data)
        {
            uint[] ints = ToUInt32s(data);
            ExifRational rational = new ExifRational()
            {
                Numerator = ints[0],
                Denominator = ints[1]
            };
            return rational;
        }

        internal const int MAX_CARRY = 9;
        internal static uint[] ToUInt32s(double item)
        {
            uint p1 = 0;
            uint p2 = 0;

            if (item == 0)
            {
                p1 = 0; p2 = 1;
            }
            else if (item < 1)
            {
                p1 = 32;
                p2 = (uint)(p1 / item);
            }
            else
            {
                if (item == (double)(uint)item)
                {
                    p1 = (uint)item;
                    p2 = 1;
                }
                else
                {
                    for (int i = 0; i < MAX_CARRY; i++)
                    {
                        p2 = (uint)Math.Pow(10, i);
                        p1 = (uint)(item * p2);

                        if (item * p2 == p1)
                            break;
                    }
                }
            }
            return new uint[] { p1, p2 };
        }
    }
}
