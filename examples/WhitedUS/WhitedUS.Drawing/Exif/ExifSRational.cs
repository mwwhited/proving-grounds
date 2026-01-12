using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Drawing.Exif
{
    public class ExifSRational
    {
        public int Numerator { get; set; }
        public int Denominator { get; set; }

        public override string ToString()
        {
            return string.Format("{0}/{1}", Numerator, Denominator);
        }

        public static implicit operator double(ExifSRational rational)
        {
            return (double)rational.Numerator / (double)rational.Denominator;
        }

        public static implicit operator byte[](ExifSRational rational)
        {
            byte[] buffer = new byte[8];

            Array.Copy(ExifType.SLONG.GetData(rational.Numerator), 0, buffer, 0, 4);
            Array.Copy(ExifType.SLONG.GetData(rational.Denominator), 0, buffer, 4, 4);

            return buffer;
        }

        public static implicit operator ExifSRational(byte[] data)
        {
            byte[] ab1 = new byte[data.Length / 2];
            byte[] ab2 = new byte[data.Length / 2];

            Array.Copy(data, ab1, data.Length / 2);
            Array.Copy(data, data.Length / 2, ab2, 0, data.Length / 2);

            ExifSRational rational = new ExifSRational()
            {
                Numerator = (int)ExifType.SLONG.GetValue(ab1),
                Denominator = (int)ExifType.SLONG.GetValue(ab2)
            };

            return rational;
        }

        public static implicit operator ExifSRational(double data)
        {
            int[] ints = ToInt32s(data);
            ExifSRational rational = new ExifSRational(){
                Numerator = ints[0],
                Denominator = ints[1]
            };
            return rational;
        }

        internal const int MAX_CARRY = 9;
        internal static int[] ToInt32s(double item)
        {
            int p1 = 0;
            int p2 = 0;

            if (item == 0)
            {
                p1 = 0; p2 = 1;
            }
            else if (item < 1)
            {
                p1 = 32;
                p2 = (int)(p1 / item);
            }
            else
            {
                if (item == (double)(int)item)
                {
                    p1 = (int)item;
                    p2 = 1;
                }
                else
                {
                    for (int i = 0; i < MAX_CARRY; i++)
                    {
                        p2 = (int)Math.Pow(10, i);
                        p1 = (int)(item * p2);

                        if (item * p2 == p1)
                            break;
                    }
                }
            }
            return new int[] { p1, p2 };
        }
    }
}
