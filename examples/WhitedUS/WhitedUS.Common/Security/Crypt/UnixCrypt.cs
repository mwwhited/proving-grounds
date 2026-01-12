using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WhitedUS.Common.Converters;
using System.Reflection;

namespace WhitedUS.Common.Security.Crypt
{
    /// <summary>
    /// Implementation of Unix's Crypt functions for .Net
    /// </summary>
    public static class UnixCrypt
    {
        #region Private Members

        private const string TYPE_NOT_LOADED = "Make sure Assembly containing type \"{0}\" is loaded";
        private const string TYPE_PARAM_CANT_BE_NULL = "Parameter \"{0}\" can not be null";
        private const string TYPE_PARAM_WRONG_TYPE = "Parameter \"{0}\" must be of Type \"{1}\"";

        private static object _refreshLock = new object();
        private readonly static IDictionary<byte[], int> _prefixes = new Dictionary<byte[], int>();
        private readonly static IDictionary<int, ICrypt> _cryptOptions = new Dictionary<int, ICrypt>();
        private readonly static IDictionary<string, int> _cryptNames = new Dictionary<string, int>();

        #endregion

        static UnixCrypt() { Refresh(); }

        /// <summary>
        /// Refresh Crypt Types
        /// </summary>
        public static void Refresh()
        {
            lock (_refreshLock)
            {
                int _cryptoPointer = 0;
                var _assemblies = AppDomain.CurrentDomain.GetAssemblies();
                foreach (var _assembly in _assemblies)
                {
                    var _types = from t in _assembly.GetTypes()
                                 where t.GetInterface(typeof(ICrypt).FullName,
                                                     false) != null &&
                                       t.GetConstructor(new Type[0]) != null &&
                                       !_cryptNames.ContainsKey(t.Name)
                                 select t;

                    foreach (var _cryptType in _types)
                    {
                        var _newCrypt = _assembly.CreateInstance(
                                                _cryptType.FullName,
                                                false,
                                                BindingFlags.CreateInstance,
                                                null,
                                                null,
                                                null,
                                                null) as ICrypt;

                        if (_newCrypt != null)
                        {
                            _prefixes.Add(_newCrypt.Prefix, _cryptoPointer);
                            _cryptOptions.Add(_cryptoPointer, _newCrypt);
                            _cryptNames.Add(_cryptType.Name, _cryptoPointer);
                            _cryptoPointer++;
                        }
                    }
                }
            }
        }

        /// <summary>
        /// List of currently loaded crypt types
        /// </summary>
        public static IEnumerable<string> LoadedCryptTypes
        {
            get
            {
                return _cryptNames.Keys.ToList().AsReadOnly();
            }
        }

        /// <summary>
        /// Hash/Key comparison using Magic String to identify type
        /// </summary>
        /// <param name="key">byte[] Key</param>
        /// <param name="hash">byte[] Hash</param>
        /// <returns>True if match</returns>
        public static bool MatchHash(byte[] key, byte[] hash)
        {
            foreach (var _prefix in _prefixes)
            {
                if (hash.StartsWith(_prefix.Key))
                {
                    var _result = _cryptOptions[_prefix.Value]
                                            .Crypt(key, hash);

                    if (_result.Length == hash.Length &&
                            hash.StartsWith(_result))
                        return true;

                    break;
                }
            }
            return false;
        }

        /// <summary>
        /// Hash/Key comparison using Magic String to identify type
        /// </summary>
        /// <param name="key">byte[] Key</param>
        /// <param name="hash">byte[] Hash</param>
        /// <returns>True if match</returns>
        public static bool MatchHash(string key, string hash)
        {
            return MatchHash(Encoding.ASCII.GetBytes(key),
                Encoding.ASCII.GetBytes(hash));
        }

        #region Generate Salt

        #region Return byte[]

        /// <summary>
        /// Method to generate a Salt for a given hash type
        /// </summary>
        /// <typeparam name="ICryptType">Type of Hash to generate Salt for</typeparam>
        /// <returns>byte[] Salt value</returns>
        public static byte[] GenerateSaltBytes<ICryptType>()
            where ICryptType : ICrypt
        {
            return GenerateSaltBytes(typeof(ICryptType).Name);
        }

        /// <summary>
        /// Method to generate a Salt for a given hash type
        /// </summary>
        /// <param name="ICryptType">Type of Hash to generate Salt for</param>
        /// <returns>byte[] Salt value</returns>
        public static byte[] GenerateSaltBytes(Type ICryptType)
        {
            if (ICryptType == null)
                throw new ArgumentNullException(
                    string.Format(TYPE_PARAM_CANT_BE_NULL, "ICryptType"));

            if (!(ICryptType is ICrypt))
                throw new ArgumentOutOfRangeException(
                    string.Format(TYPE_PARAM_WRONG_TYPE,
                                  "ICryptType",
                                  typeof(ICrypt).Name));

            return GenerateSaltBytes(ICryptType.Name);
        }


        /// <summary>
        /// Method to generate a Salt for a given hash type
        /// </summary>
        /// <param name="ICryptType">Type of Hash to generate Salt for</param>
        /// <returns>byte[] Salt value</returns>
        public static byte[] GenerateSaltBytes(string ICryptType)
        {
            if (!_cryptNames.ContainsKey(ICryptType))
                throw new NotSupportedException(
                    string.Format(TYPE_NOT_LOADED, ICryptType));

            return _cryptOptions[_cryptNames[ICryptType]].SaltGenerate();
        }

        #endregion

        #region Return string

        /// <summary>
        /// Generate Salt for selected type of hash
        /// </summary>
        /// <typeparam name="ICryptType">Type of hash</typeparam>
        /// <returns>salt value as byte aray</returns>
        public static string GenerateSaltString<ICryptType>()
            where ICryptType : ICrypt
        {
            return Encoding.ASCII.GetString(GenerateSaltBytes<ICryptType>());
        }

        /// <summary>
        /// Generate Salt for selected type of hash
        /// </summary>
        /// <param name="ICryptType">Type of hash</param>
        /// <returns>salt value as byte aray</returns>
        public static string GenerateSaltString(Type ICryptType)
        {
            return Encoding.ASCII.GetString(GenerateSaltBytes(ICryptType));
        }

        /// <summary>
        /// Generate Salt for selected type of hash
        /// </summary>
        /// <param name="ICryptType">Type of hash</param>
        /// <returns>salt value as byte aray</returns>
        public static string GenerateSaltString(string ICryptType)
        {
            return Encoding.ASCII.GetString(GenerateSaltBytes(ICryptType));
        }

        #endregion

        #endregion

        #region Hash

        #region Hash byte[]

        /// <summary>
        /// Hash key based on selected type of hash
        /// </summary>
        /// <typeparam name="ICryptType">type of hash</typeparam>
        /// <param name="key">key value to hash</param>
        /// <returns>hashed key value with generated salt</returns>
        public static byte[] Hash<ICryptType>(byte[] key)
            where ICryptType : ICrypt
        {
            return Hash(key, typeof(ICryptType).Name);
        }

        /// <summary>
        /// Hash key based on selected type of hash
        /// </summary>
        /// <typeparam name="ICryptType">type of hash</typeparam>
        /// <param name="key">key value to hash</param>
        /// <param name="salt">salt value</param>
        /// <returns>hashed key value</returns>
        public static byte[] Hash<ICryptType>(byte[] key, byte[] salt)
            where ICryptType : ICrypt
        {
            return Hash(key, salt, typeof(ICryptType).Name);
        }

        /// <summary>
        /// Hash key based on selected type of hash
        /// </summary>
        /// <param name="ICryptType">type of hash</param>
        /// <param name="key">key value to hash</param>
        /// <returns>hashed key value with generated salt</returns>
        public static byte[] Hash(byte[] key, Type ICryptType)
        {
            if (ICryptType == null)
                throw new ArgumentNullException(
                    string.Format(TYPE_PARAM_CANT_BE_NULL, "ICryptType"));

            if (!(ICryptType is ICrypt))
                throw new ArgumentOutOfRangeException(
                    string.Format(TYPE_PARAM_WRONG_TYPE,
                                  "ICryptType",
                                  typeof(ICrypt).Name));

            return Hash(key, ICryptType.Name);
        }

        /// <summary>
        /// Hash key based on selected type of hash
        /// </summary>
        /// <param name="ICryptType">type of hash</param>
        /// <param name="key">key value to hash</param>
        /// <param name="salt">salt value</param>
        /// <returns>hashed key value</returns>
        public static byte[] Hash(byte[] key, byte[] salt, Type ICryptType)
        {
            if (ICryptType == null)
                throw new ArgumentNullException(
                    string.Format(TYPE_PARAM_CANT_BE_NULL, "ICryptType"));

            if (!(ICryptType is ICrypt))
                throw new ArgumentOutOfRangeException(
                    string.Format(TYPE_PARAM_WRONG_TYPE,
                                  "ICryptType",
                                  typeof(ICrypt).Name));

            return Hash(key, salt, ICryptType.Name);
        }

        /// <summary>
        /// Hash key based on selected type of hash
        /// </summary>
        /// <param name="ICryptType">type of hash</param>
        /// <param name="key">key value to hash</param>
        /// <returns>hashed key value with generated salt</returns>
        public static byte[] Hash(byte[] key, string ICryptType)
        {
            byte[] salt = GenerateSaltBytes(ICryptType);
            return Hash(key, salt, ICryptType);
        }

        /// <summary>
        /// Hash key based on selected type of hash
        /// </summary>
        /// <param name="ICryptType">type of hash</param>
        /// <param name="key">key value to hash</param>
        /// <param name="salt">salt value</param>
        /// <returns>hashed key value</returns>
        public static byte[] Hash(byte[] key, byte[] salt, string ICryptType)
        {
            if (string.IsNullOrEmpty(ICryptType))
                throw new ArgumentNullException(
                    string.Format(TYPE_PARAM_CANT_BE_NULL, "ICryptType"));

            if (!_cryptNames.ContainsKey(ICryptType))
                throw new NotSupportedException(
                    string.Format(TYPE_NOT_LOADED, ICryptType));

            return _cryptOptions[_cryptNames[ICryptType]].Crypt(key, salt);
        }

        /// <summary>
        /// Create Hash using Md5Crypt
        /// </summary>
        /// <param name="key">byte[] Key</param>
        /// <returns>byte[] Hash</returns>
        public static byte[] Hash(byte[] key)
        {
            return Hash(key, typeof(Md5Crypt).Name);
        }

        #endregion

        #region Hash string

        /// <summary>
        /// Hash key based on selected type of hash
        /// </summary>
        /// <typeparam name="ICryptType">type of hash</typeparam>
        /// <param name="key">key value to hash</param>
        /// <returns>hashed key value with generated salt</returns>
        public static string Hash<ICryptType>(string key)
            where ICryptType : ICrypt
        {
            return Hash(key, typeof(ICryptType).Name);
        }

        /// <summary>
        /// Hash key based on selected type of hash
        /// </summary>
        /// <typeparam name="ICryptType">type of hash</typeparam>
        /// <param name="key">key value to hash</param>
        /// <param name="salt">salt value</param>
        /// <returns>hashed key value</returns>
        public static string Hash<ICryptType>(string key, string salt)
            where ICryptType : ICrypt
        {
            return Hash(key, salt, typeof(ICryptType).Name);
        }

        /// <summary>
        /// Hash key based on selected type of hash
        /// </summary>
        /// <param name="ICryptType">type of hash</param>
        /// <param name="key">key value to hash</param>
        /// <returns>hashed key value with generated salt</returns>
        public static string Hash(string key, Type ICryptType)
        {
            if (ICryptType == null)
                throw new ArgumentNullException(
                    string.Format(TYPE_PARAM_CANT_BE_NULL, "ICryptType"));

            if (ICryptType.GetInterface(typeof(ICrypt).FullName) == null)
                throw new ArgumentOutOfRangeException(
                    string.Format(TYPE_PARAM_WRONG_TYPE,
                                  "ICryptType",
                                  typeof(ICrypt).Name));

            return Hash(key, ICryptType.Name);
        }

        /// <summary>
        /// Hash key based on selected type of hash
        /// </summary>
        /// <param name="ICryptType">type of hash</param>
        /// <param name="key">key value to hash</param>
        /// <param name="salt">salt value</param>
        /// <returns>hashed key value</returns>
        public static string Hash(string key, string salt, Type ICryptType)
        {
            if (ICryptType == null)
                throw new ArgumentNullException(
                    string.Format(TYPE_PARAM_CANT_BE_NULL, "ICryptType"));

            if (!(ICryptType is ICrypt))
                throw new ArgumentOutOfRangeException(
                    string.Format(TYPE_PARAM_WRONG_TYPE,
                                  "ICryptType",
                                  typeof(ICrypt).Name));

            return Hash(key, salt, ICryptType.Name);
        }

        /// <summary>
        /// Hash key based on selected type of hash
        /// </summary>
        /// <param name="ICryptType">type of hash</param>
        /// <param name="key">key value to hash</param>
        /// <returns>hashed key value with generated salt</returns>
        public static string Hash(string key, string ICryptType)
        {
            string salt = GenerateSaltString(ICryptType);
            return Hash(key, salt, ICryptType);
        }

        /// <summary>
        /// Hash key based on selected type of hash
        /// </summary>
        /// <param name="ICryptType">type of hash</param>
        /// <param name="key">key value to hash</param>
        /// <param name="salt">salt value</param>
        /// <returns>hashed key value</returns>
        public static string Hash(string key, string salt, string ICryptType)
        {
            if (string.IsNullOrEmpty(ICryptType))
                throw new ArgumentNullException(
                    string.Format(TYPE_PARAM_CANT_BE_NULL, "ICryptType"));

            if (!_cryptNames.ContainsKey(ICryptType))
                throw new NotSupportedException(
                    string.Format(TYPE_NOT_LOADED, ICryptType));

            return Encoding.ASCII.GetString(
                Hash(
                    Encoding.ASCII.GetBytes(key),
                    Encoding.ASCII.GetBytes(salt),
                    ICryptType
                    )
                    );
        }

        /// <summary>
        /// Create Hash using Md5Crypt
        /// </summary>
        /// <param name="key">string Key</param>
        /// <returns>string Hash</returns>
        public static string Hash(string key)
        {
            return Hash(key, typeof(Md5Crypt).Name); ;
        }

        #endregion

        #endregion
    }
}
