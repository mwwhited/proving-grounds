using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace WhitedUS.Common.Converters
{
    /// <summary>
    /// Convert Between ByteArrays, and strings
    /// </summary>
    public static class StringConverters
    {
        /// <summary>
        /// Regular Expression to find whitespace in a string
        /// </summary>
        public static readonly Regex RegexWhitespace = new Regex(@"[ \t\r\n]");

        /// <summary>
        /// Test if Input string has any whitespace.  
        /// (Space, Tab, Carrage Return, Line Feed)
        /// </summary>
        /// <param name="_Input">String to Test</param>
        /// <returns>Boolean true if Input Has whitespace</returns>
        public static bool HasWhitespace(this string _Input)
        {
            return RegexWhitespace.IsMatch(_Input);
        }

        /// <summary>
        /// Remove all instances of whitespace out of a string
        /// </summary>
        /// <param name="_Input">string to evaluate</param>
        /// <returns>output string</returns>
        public static string RemoveAllWhitespace(this string _Input)
        {
            return RegexWhitespace.Replace(_Input, "");
        }

        /// <summary>
        /// Convert the contents of the string _String to a byte array.
        /// Encoding Type is ASCII
        /// </summary>
        /// <param name="_String">Input String</param>
        /// <returns>Byte Array of String</returns>
        public static byte[] ToByteArray(this string _String)
        {
            return ToByteArray(_String, Encoding.ASCII);
        }

        /// <summary>
        /// Convert the contents of the string _String to a byte array.
        /// </summary>
        /// <param name="_String">Input String</param>
        /// <param name="_Encoding">Type of Encoding to use</param>
        /// <returns>Byte Array of String</returns>
        public static byte[] ToByteArray(this string _String, 
                                         Encoding _Encoding)
        {
            return string.IsNullOrEmpty(_String) ? null 
                                                 : _Encoding.GetBytes(_String);
        }

        /// <summary>
        /// Regular Expression Pattern for matching Base64 
        /// Strings.  Whitespace not allowed
        /// </summary>
        public static readonly Regex RegexBase64String = 
                                        new Regex(@"^([a-zA-Z0-9+/=]{4})*$");

        /// <summary>
        /// Test if Input string is a base64 string
        /// </summary>
        /// <param name="_Input">String to Test</param>
        /// <returns>Boolean true if Input is base64 String</returns>
        public static bool IsBase64(this string _Input)
        {
            return RegexBase64String.IsMatch(_Input);
        }

        /// <summary>
        /// Convert a base64 string into a byte[].  
        /// Whitespace not allowed
        /// </summary>
        /// <param name="_String">Base64 String to convert</param>
        /// <returns>Byte[] from String</returns>
        public static byte[] FromBase64(this string _String)
        {
            if (string.IsNullOrEmpty(_String))
                return null;

            _String = _String.RemoveAllWhitespace();
            if (!(RegexBase64String.IsMatch(_String)))
                return null;

            return Convert.FromBase64String(_String);
        }

        /// <summary>
        /// Regular Expression Pattern for matching Hexadecimal Strings
        /// </summary>
        public static readonly Regex RegexHexString = 
                                        new Regex(@"^([A-Fa-f0-9]{2})*$");

        /// <summary>
        /// Test if Input string is a hexstring
        /// </summary>
        /// <param name="_Input">String to Test</param>
        /// <returns>Boolean true if Input is Hex String</returns>
        public static bool IsHexString(this string _Input)
        {
            return RegexHexString.IsMatch(_Input);
        }

        /// <summary>
        /// Convert a Hex String into a byte array.  If string 
        /// is blank, null, or just plain not a valid hexstring 
        /// it will return null
        /// </summary>
        /// <param name="_String">Input HexString</param>
        /// <returns>Byte Array</returns>
        public static byte[] FromHexString(this string _String)
        {
            if (string.IsNullOrEmpty(_String) ||
                !(RegexHexString.IsMatch(_String)))
                return null;

            byte[] _outArray = new byte[_String.Length / 2];

            for (int i = 0; i < _outArray.Length; i++)
                byte.TryParse(
                    _String.Substring(i * 2, 2), 
                    NumberStyles.HexNumber, 
                    null, 
                    out _outArray[i]
                    );

            return _outArray;
        }

        ///// <summary>
        ///// Use the System.Speech.Synthesis.SpeechSynthesizer to say the string
        ///// </summary>
        ///// <param name="_String">String to Speak</param>
        //public static void Speak(this string _String)
        //{
        //    if (_synth == null)
        //    {
        //        lock (typeof(StringConverters))
        //        {
        //            _synth = new SpeechSynthesizer();
        //        }
        //    }
        //    _synth.Speak(_String);
        //}

        ///// <summary>
        ///// Use the System.Speech.Synthesis.SpeechSynthesizer to say the string
        ///// </summary>
        ///// <param name="_String">String to Speak Async</param>
        //public static void SpeakAsync(this string _String)
        //{
        //    if (_synth == null)
        //    {
        //        lock (typeof(StringConverters))
        //        {
        //            _synth = new SpeechSynthesizer();
        //        }
        //    }
        //    _synth.SpeakAsync(_String);
        //}

        //private static SpeechSynthesizer _synth;

        /// <summary>
        /// Get the MD5 Hash of a given string
        /// </summary>
        /// <param name="buffer">data to hash</param>
        /// <returns>md5 hash of data buffer as hex string</returns>
        public static string GetMD5Hash(this string buffer)
        {
            return buffer.ToByteArray().GetMD5HashString();
        }

        /// <summary>
        /// Get the MD5 Hash of a given byte[]
        /// </summary>
        /// <param name="buffer">data to hash</param>
        /// <returns>md5 hash of data buffer</returns>
        public static byte[] GetMD5HashBytes(this string buffer)
        {
            return buffer.ToByteArray().GetMD5Hash();
        }
    }
}
