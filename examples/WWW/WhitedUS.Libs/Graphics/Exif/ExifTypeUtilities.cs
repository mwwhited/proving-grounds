using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Libs.Graphics.Exif
{
    public static class ExifTypeUtilities
    {
        public static byte[] GetData(this ExifType exifType, object value)
        {
            if (value == null)
                return null;

            byte[] buffer = null;

            switch (exifType)
            {
                case ExifType.BYTE:
                    if (value is byte)
                        buffer = new byte[] { (byte)value };
                    else if (value is byte[])
                        buffer = (byte[])value;
                    break;

                case ExifType.ASCII:
                    if (value is string)
                    {
                        if (((string)value).Last() != (char)0)
                            buffer = ASCIIEncoding.ASCII.GetBytes((string)value + '\0');
                        else
                            buffer = ASCIIEncoding.ASCII.GetBytes((string)value);
                    }
                    break;

                case ExifType.SHORT: //16 bit
                    if (value is short)
                    {
                        buffer = new byte[]
                        {
                            (byte)((short)value),
                            (byte)(((short)value) >> 8)
                        };
                    }
                    break;

                case ExifType.LONG: //32 bit
                    if (value is uint)
                    {
                        buffer = new byte[]
                        {
                            (byte)((uint)value),
                            (byte)(((uint)value) >> 8),
                            (byte)(((uint)value) >> 16),
                            (byte)(((uint)value) >> 24),
                        };
                    }
                    break;


                case ExifType.SLONG:
                    if (value is int)
                    {
                        buffer = new byte[]
                        {
                            (byte)((int)value),
                            (byte)(((int)value) >> 8),
                            (byte)(((int)value) >> 16),
                            (byte)(((int)value) >> 24),
                        };
                    }
                    break;

                case ExifType.RATIONAL:
                    buffer = (ExifRational)value;
                    break;

                case ExifType.SRATIONAL:
                    buffer = (ExifSRational)value;
                    break;

                case ExifType.UNDEFINED:
                default:
                    if (value is byte[])
                        buffer = (byte[])value;
                    break;
            }

            return buffer;
        }

        public static object GetValue(this ExifType exifType, byte[] data)
        {
            switch (exifType)
            {
                case ExifType.BYTE:
                    if (data.Length == 1)
                        return data.FirstOrDefault();
                    else
                        return data;

                case ExifType.ASCII:
                    return (ASCIIEncoding.ASCII.GetString(data) ?? "").Trim(new char[] { '\0' }).Trim();

                case ExifType.SHORT:
                    if (data.Length < 2)
                        return (short)data.FirstOrDefault();
                    else if (data.Length == 2)
                        return (short)(
                            (short)data[0] +
                            ((short)data[1] << 8)
                            );
                    else
                    {
                        short[] buffer = new short[data.Length / 2];
                        for (int i = 0; i < buffer.Length; i++)
                        {
                            buffer[i] =
                                (short)(
                                (short)data[i * 2] +
                                ((short)data[(i * 2) + 1] << 8)
                                );
                        }
                        return buffer;
                    }

                case ExifType.SLONG:
                    if (data.Length < 2)
                        return (int)(data.FirstOrDefault());
                    else if (data.Length < 4)
                        return (int)(
                            ((int)data[0]) +
                            ((int)data[1] << 8)
                            );
                    else
                        return (int)(
                            ((int)data[0]) +
                            ((int)data[1] << 8) +
                            ((int)data[2] << 16) +
                            ((int)data[3] << 24)
                            );

                case ExifType.LONG:
                    if (data.Length < 2)
                        return (uint)(data.FirstOrDefault());
                    else if (data.Length < 4)
                        return (uint)(
                            ((uint)data[0]) +
                            ((uint)data[1] << 8)
                            );
                    else
                        return (uint)(
                            ((uint)data[0]) +
                            ((uint)data[1] << 8) +
                            ((uint)data[2] << 16) +
                            ((uint)data[3] << 24)
                            );

                case ExifType.SRATIONAL:
                    return (ExifSRational)(data);

                case ExifType.RATIONAL:
                    return (ExifRational)(data);

                case ExifType.UNDEFINED:
                    return data;

                default:
                    throw new InvalidOperationException("This type is not declared");
            }
        }
    }
}
