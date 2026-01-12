using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO.Compression;
using System.IO;
using System.Security.Cryptography;

namespace WhitedUS.Libs.Converters
{
    /// <summary>
    /// This is a collection of the coolest byte array converters
    /// </summary>
    public static class ByteArrayConverters
    {
        /// <summary>
        /// GZip Compress a byte array
        /// </summary>
        /// <param name="_Input">Input Array</param>
        /// <returns>Compressed Array</returns>
        public static byte[] Compress(this byte[] _Input)
        {
            if (_Input == null)
                return null;

            MemoryStream _ms = new MemoryStream();
            GZipStream _zip = new GZipStream(_ms, CompressionMode.Compress);
            _zip.Write(_Input, 0, _Input.Length);
            _zip.Close();

            return _ms.GetBuffer();
        }

        /// <summary>
        /// GZip Deompress a byte array
        /// </summary>
        /// <param name="_Input">Input Array</param>
        /// <returns>Decompressed Array</returns>
        public static byte[] Decompress(this byte[] _Input)
        {
            if (_Input == null)
                return null;

            MemoryStream _ms = new MemoryStream(_Input);
            GZipStream _zip = new GZipStream(_ms, CompressionMode.Decompress);
            List<Byte> _outArray = new List<byte>();

            int _lastByte = 0;
            do
            {
                _lastByte = _zip.ReadByte();
                if (_lastByte > -1)
                    _outArray.Add((byte)_lastByte);
            } while (_lastByte > -1);
            _zip.Flush();

            return _outArray.ToArray();
        }

        /// <summary>
        /// Convert an existing Byte arry into a hex string. (a-f0-9)
        /// </summary>
        /// <param name="_Input">Byte Array</param>
        /// <returns>Hex String</returns>
        public static string ToHexString(this byte[] _Input)
        {
            if ((_Input == null) || (_Input.Length == 0))
                return null;

            StringBuilder sb = new StringBuilder();
            foreach (byte _byte in _Input)
            {
                sb.Append(_byte.ToString("x2"));
            }
            return sb.ToString();
        }

        /// <summary>
        /// Convert an existing Byte array into a hex string. (A-F0-9)
        /// </summary>
        /// <param name="_Input">Byte Array</param>
        /// <returns>Hex String</returns>
        public static string ToHexStringU(this byte[] _Input)
        {
            if ((_Input == null) || (_Input.Length == 0))
                return null;

            return _Input.ToHexString().ToUpper();
        }

        /// <summary>
        /// Convert a byte array into a Base64 string
        /// </summary>
        /// <param name="_Input">Byte Array</param>
        /// <returns>Base64 String</returns>
        public static string ToBase64(this byte[] _Input)
        {
            if (_Input == null)
                return null;

            return Convert.ToBase64String(_Input);
        }

        /// <summary>
        /// Convert the contents of the byte array _Arry to a string
        /// Encoding Type is ASCII
        /// </summary>
        /// <param name="_Array">Input Array</param>
        /// <returns>String</returns>
        public static string ToEncodedString(this byte[] _Array)
        {
            return ToEncodedString(_Array, Encoding.ASCII);
        }

        /// <summary>
        /// Convert the contents of the byte array _Arry to a string
        /// </summary>
        /// <param name="_Array">Input Array</param>
        /// <param name="_Encoding">Type of Encoding to use</param>
        /// <returns>String</returns>
        public static string ToEncodedString(this byte[] _Array, 
                                             Encoding _Encoding)
        {
            return _Array == null ? null : _Encoding.GetString(_Array);
        }

        /// <summary>
        /// Convert Byte Array to MemoryStream
        /// </summary>
        /// <param name="_Input">Byte Array</param>
        /// <returns>MemoryStream</returns>
        public static MemoryStream ToMemoryStream(this byte[] _Input)
        {
            return new MemoryStream(_Input);
        }

        /// <summary>
        /// Tests is byte array starts with another byte array
        /// </summary>
        /// <param name="arg">To Test</param>
        /// <param name="prefix">To Look for</param>
        /// <returns>True is matched</returns>
        public static bool StartsWith(this byte[] arg, byte[] prefix)
        {
            if (arg.Length < prefix.Length)
                return false;

            for (int i = 0; i < prefix.Length; i++)
                if (arg[i] != prefix[i])
                    return false;

            return true;
        }

        /// <summary>
        /// Find first instance of "b" in arg
        /// </summary>
        /// <param name="arg">To be searched</param>
        /// <param name="b">To look for</param>
        /// <returns>value</returns>
        public static int IndexOf(this byte[] arg, byte b)
        {
            for (int i = 0; i < arg.Length; i++)
                if (arg[i] == b)
                    return i;

            return arg.Length;
        }

        /// <summary>
        /// Get the MD5 Hash of a given byte[]
        /// </summary>
        /// <param name="buffer">data to hash</param>
        /// <returns>md5 hash of data buffer</returns>
        public static byte[] GetMD5Hash(this byte[] buffer)
        {
            MD5CryptoServiceProvider md5 = new MD5CryptoServiceProvider();
            md5.Initialize();
            md5.ComputeHash(buffer);
            return md5.Hash;
        }
        
        /// <summary>
        /// Get the MD5 Hash of a given byte[]
        /// </summary>
        /// <param name="buffer">data to hash</param>
        /// <returns>md5 hash of data buffer as hex string</returns>
        public static string GetMD5HashString(this byte[] buffer)
        {
            return buffer.GetMD5Hash().ToHexString();
        }
    }
}
