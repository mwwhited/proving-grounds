using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace WhitedUS.Libs.Converters
{
    /// <summary>
    /// MemorySteam Converters
    /// </summary>
    public static class MemoryStreamConverters
    {
        /// <summary>
        /// Gets the Byte Array from the contents of a MemoryStream
        /// If it can not be read it will return null.
        /// </summary>
        /// <param name="_Input">MemoryStream to convert</param>
        /// <returns>Byte Array</returns>
        public static byte[] ToByteArray(this MemoryStream _Input)
        {
            if (_Input.CanSeek)
                _Input.Seek(0, SeekOrigin.Begin);

            if (_Input.CanRead)
            {
                List<byte> _byteList = new List<byte>();
                int _lastByte = 0;
                while (_lastByte != -1)
                {
                    _lastByte = _Input.ReadByte();

                    if (_lastByte != -1)
                        _byteList.Add((byte)_lastByte);
                }

                return _byteList.ToArray();
            }
            else
            {
                return null;
            }
        }

        public static MemoryStream Rewind(this MemoryStream input)
        {
            if (input == null)
                return new MemoryStream();
            input.Seek(0, SeekOrigin.Begin);
            return input;
        }

        public static MemoryStream FastForward(this MemoryStream input)
        {
            if (input == null)
                return new MemoryStream();
            input.Seek(input.Length, SeekOrigin.End);
            return input;
        }

        public static string ToEncodedString(this MemoryStream input)
        {
            if (input == null)
                return null;
            else if (input.Length == 0)
                return string.Empty;
            else
                return input.ToArray().ToEncodedString();
        }
    }
}
