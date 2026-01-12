using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Security.Cryptography;
using WhitedUS.Common.Converters;

namespace WhitedUS.Common.Security.Crypt
{
    /// <summary>
    /// MD5 Crypt Support for .Net
    /// </summary>
    public class Md5Crypt : ICrypt
    {
        private readonly static byte[] b64t = Encoding.ASCII.GetBytes(
            "./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ" +
            "abcdefghijklmnopqrstuvwxyz=");

        private readonly static byte[] _prefix = new[]{
            (byte)'$',(byte)'1',(byte)'$'
        };
        private readonly static byte _delimiter = (byte)'$';

        #region ICrypt Members

        /// <summary>
        /// MD5 Crypt prefix of "$1$" used to identify this hash type
        /// </summary>
        public virtual byte[] Prefix { get { return _prefix; } }

        /// <summary>
        /// MD5 minimum salt length is "0"
        /// </summary>
        public virtual int SaltMinLength { get { return 0; } }

        /// <summary>
        /// MD5 maximum salt length is "8"
        /// </summary>
        public virtual int SaltMaxLength { get { return 8; } }

        /// <summary>
        /// Function will randomly create a MD5 salt value that is 8 bytes long
        /// </summary>
        /// <returns></returns>
        public virtual byte[] SaltGenerate()
        {
            byte[] _newSalt = new byte[this.SaltMaxLength];
            Random _rand = new Random((int)DateTime.Now.Ticks);

            for (int i = 0; i < _newSalt.Length; i++)
                _newSalt[i] = b64t[_rand.Next(0, b64t.Length)];

            return _newSalt;
        }


        /// <summary>
        /// MD5 Hash algorithm
        /// </summary>
        /// <param name="key">key value to hash</param>
        /// <param name="salt">salt value</param>
        /// <returns>hash byte array</returns>
        public byte[] Crypt(byte[] key, byte[] salt)
        {
            byte[] _buffer;
            byte[] _altBuffer;

            List<byte> _bufferList = new List<byte>();
            List<byte> _altBufferList = new List<byte>();

            MD5CryptoServiceProvider _md5 = new MD5CryptoServiceProvider();

            int _saltLength = salt.Length;
            int _keyLength = key.Length;
            int _cp;
            int _cnt;

            if (salt.StartsWith(this.Prefix))
            {
                _saltLength = salt.Length - this.Prefix.Length;
                byte[] _tempSalt = new byte[_saltLength];
                Array.Copy(salt,
                           this.Prefix.Length,
                           _tempSalt,
                           0,
                           _saltLength);
                salt = _tempSalt;
            }

            _saltLength = Math.Min(salt.IndexOf(_delimiter), 8);
            if (_saltLength == -1) { _saltLength = 8; }

            if (_saltLength != salt.Length)
            {
                byte[] _tempSalt = new byte[_saltLength];
                Array.Copy(salt, 0, _tempSalt, 0, _saltLength);
                salt = _tempSalt;
            }

            _buffer = new byte[this.Prefix.Length + _saltLength + 1 + 22];

            _bufferList.Clear();
            _bufferList.AddRange(key);
            _bufferList.AddRange(this.Prefix);
            _bufferList.AddRange(salt);

            _altBufferList.Clear();
            _altBufferList.AddRange(key);
            _altBufferList.AddRange(salt);
            _altBufferList.AddRange(key);
            _altBuffer = _md5.ComputeHash(_altBufferList.ToArray());

            for (_cnt = _keyLength; _cnt > 16; _cnt -= 16)
                _bufferList.AddRange(_altBuffer);

            byte[] _altBufferPart = new byte[_cnt];
            Array.Copy(_altBuffer, 0, _altBufferPart, 0, _cnt);
            _bufferList.AddRange(_altBufferPart);

            for (int i = _keyLength; i > 0; i >>= 1)
                _bufferList.Add((byte)((i & 0x01) != 0 ? 0 : key[0]));

            _altBuffer = _md5.ComputeHash(_bufferList.ToArray());

            for (int i = 0; i < 1000; i++)
            {
                _bufferList.Clear();

                if ((i & 0x01) != 0)
                    _bufferList.AddRange(key);
                else
                    _bufferList.AddRange(_altBuffer);

                if (i % 3 != 0)
                    _bufferList.AddRange(salt);

                if (i % 7 != 0)
                    _bufferList.AddRange(key);

                if ((i & 0x01) != 0)
                    _bufferList.AddRange(_altBuffer);
                else
                    _bufferList.AddRange(key);

                _altBuffer = _md5.ComputeHash(_bufferList.ToArray());
            }

            Array.Copy(this.Prefix, 0, _buffer, 0, this.Prefix.Length);
            _cp = this.Prefix.Length;

            Array.Copy(salt, 0, _buffer, _cp, _saltLength);
            _cp += _saltLength;

            _buffer[_cp++] = _delimiter;

            _cp += b64From24Bit(_buffer, _cp,
                                _altBuffer[0],
                                _altBuffer[6],
                                _altBuffer[12],
                                4);
            _cp += b64From24Bit(_buffer, _cp,
                                _altBuffer[1],
                                _altBuffer[7],
                                _altBuffer[13],
                                4);
            _cp += b64From24Bit(_buffer, _cp,
                                _altBuffer[2],
                                _altBuffer[8],
                                _altBuffer[14],
                                4);
            _cp += b64From24Bit(_buffer, _cp,
                                _altBuffer[3],
                                _altBuffer[9],
                                _altBuffer[15],
                                4);
            _cp += b64From24Bit(_buffer, _cp,
                                _altBuffer[4],
                                _altBuffer[10],
                                _altBuffer[5],
                                4);
            _cp += b64From24Bit(_buffer,
                                _cp,
                                (byte)0,
                                (byte)0,
                                _altBuffer[11],
                                2);

            return _buffer;
        }

        #endregion

        private static int b64From24Bit(byte[] buffer,
                                        int cp,
                                        byte B2,
                                        byte B1,
                                        byte B0,
                                        int N)
        {
            int w = ((((int)B2) & 0xFF) << 16) |
                    ((((int)B1) & 0xFF) << 8) |
                    B0;
            int n = N;
            while (n-- > 0)
            {
                buffer[cp++] = b64t[w & 0x3f];
                w >>= 6;
            }
            return N;
        }
    }
}
