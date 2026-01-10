using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using TheDotNetFactory.Framework.Common.Converters;
using System.Collections.ObjectModel;

namespace WhitedUS.Framework.Common.Security.Crypt
{
    public static class UnixCrypt
    {
        private readonly static IDictionary<byte[], int> _prefixes = new Dictionary<byte[], int>();
        private readonly static IDictionary<int, ICrypt> _cryptOptions = new Dictionary<int, ICrypt>();
        private readonly static IDictionary<string, int> _cryptNames = new Dictionary<string, int>();
        private static int _cryptoPointer = 0;
        private static object _cryptLock = new object();

        private static string _defaultCrypt = typeof(Md5Crypt).Name;
        private static object _defaultCryptLock = new object();

        #region Properties

        public static ReadOnlyCollection<string> SupportedCryptTypes 
        { 
            get 
            {
                ReadOnlyCollection<string> _outVar = null;
                lock (_cryptLock)
                {
                    _outVar = _cryptNames.Keys.ToList().AsReadOnly();
                }
                return _outVar; 
            } 
        }

        public static string DefaultCrypt 
        { 
            get 
            {
                lock (_defaultCryptLock)
                {
                    return _defaultCrypt;
                }
            }
            set { SetDefault(value); }
        }

        #endregion

        #region Constructor

        static UnixCrypt()
        {
            RefreshCrypt();
        }

        #endregion

        #region Methods

        #region Refresh

        public static void RefreshCrypt()
        {
            //Assembly[] _assemblies = new Assembly[] { Assembly.GetAssembly(typeof(UnixCrypt)) };
            Assembly[] _assemblies = AppDomain.CurrentDomain.GetAssemblies();

            foreach (var _assembly in _assemblies)
            {
                var _types = from t in _assembly.GetTypes()
                             where t.GetInterface(typeof(ICrypt).FullName, false) != null &&
                                   t.GetConstructor(new Type[0]) != null
                             select t;

                foreach (var _cryptType in _types)
                {
                    LoadHash(_cryptType);
                }
            }
        }

        #endregion

        #region SetDefault

        public static ICrypt SetDefault<ICryptType>() where ICryptType : ICrypt
        {
            return SetDefault(typeof(ICryptType));
        }

        public static ICrypt SetDefault(Type ICryptType)
        {
            if (ICryptType == null)
                throw new ArgumentNullException("ICryptType can not be null");

            return SetDefault(ICryptType.Name);
        }

        public static ICrypt SetDefault(string ICryptType)
        {
            if (string.IsNullOrEmpty(ICryptType))
                throw new ArgumentNullException("ICryptType can not be null");

            ICrypt _loaded = LoadHash(ICryptType);

            lock (_defaultCryptLock)
            {
                _defaultCrypt = ICryptType;
            }

            return _loaded;
        }

        #endregion

        #region LoadHash

        public static ICrypt LoadHash<ICryptType>() where ICryptType : ICrypt
        {
            return LoadHash(typeof(ICryptType));
        }

        public static ICrypt LoadHash(Type ICryptType)
        {
            if (ICryptType == null)
                throw new ArgumentNullException("ICryptType can not be null");

            if (!_cryptNames.ContainsKey(ICryptType.Name))
            {
                ICrypt _newCrypt = ICryptType.Assembly.CreateInstance(ICryptType.FullName, false, BindingFlags.CreateInstance, null, null, null, null) as ICrypt;
                if (_newCrypt != null)
                {
                    lock (_cryptLock)
                    {
                        if (_newCrypt.Prefix.Length > 0)
                            _prefixes.Add(_newCrypt.Prefix, _cryptoPointer);

                        _cryptOptions.Add(_cryptoPointer, _newCrypt);
                        _cryptNames.Add(ICryptType.Name, _cryptoPointer);
                        _cryptoPointer++;
                    }
                }
                else
                    throw new InvalidOperationException("ICryptType must be of type \"ICrypt\" and have an empty constructor");
            }

            var _loadedCrypt = LoadHash(ICryptType.Name);
            
            return _loadedCrypt;
        }

        public static ICrypt LoadHash(string cryptName)
        {
            if (string.IsNullOrEmpty(cryptName))
                throw new ArgumentNullException("cryptName can not be null");

            if (!_cryptNames.ContainsKey(cryptName))
                throw new ArgumentOutOfRangeException("cryptName is not loaded");

            ICrypt _loaded = null;
            lock (_cryptLock)
            {
                _loaded = _cryptOptions[_cryptNames[cryptName]];
            }

            return _loaded;
        }

        /// <summary>
        /// This method will try to detect the hash algorithm.  
        /// if can not be determined it will use the current default 
        /// </summary>
        /// <param name="hashToCheck"></param>
        /// <returns></returns>
        public static ICrypt LoadHash(byte[] hashToCheck)
        {
            var _checkPrefixes = new Dictionary<byte[], string>();
            lock (_cryptLock)
            {
                _checkPrefixes = (
                    from n in _cryptNames 
                    join p in _prefixes 
                      on n.Value equals p.Value 
                    select new {Name = n.Key, Prefix = p.Key}
                    ).ToDictionary(o => o.Prefix, o => o.Name);
            }

            var _selectedCryptName = (from p in _checkPrefixes
                                      where hashToCheck.StartsWith(p.Key)
                                      select p.Value).FirstOrDefault();

            ICrypt _loadedCrypt = null;

            if (_selectedCryptName == null)
                return LoadHash(DefaultCrypt);
            else
                return LoadHash(_selectedCryptName);
        }

        #endregion

        #region MatchHash

        public static bool MatchHash(string key, string hash)
        {
            byte[] _key = Encoding.ASCII.GetBytes(key);
            byte[] _hash = Encoding.ASCII.GetBytes(hash);

            ICrypt _crypt = LoadHash(_hash);

            byte[] _rehashed = _crypt.Crypt(_key, _hash);

            if (_rehashed == null || _rehashed.Length <= 0)
                return false;

            return (Encoding.ASCII.GetString(_rehashed) == hash);
        }

        public static bool MatchHash<ICryptType>(string key, string hash) where ICryptType : ICrypt
        {
            ICrypt _crypt = LoadHash<ICryptType>();
            return MatchHash(key, hash, _crypt);
        }

        public static bool MatchHash(string key, string hash, Type ICryptType)
        {
            ICrypt _crypt = LoadHash(ICryptType);
            return MatchHash(key, hash, _crypt);
        }

        public static bool MatchHash(string key, string hash, string ICryptType)
        {
            ICrypt _crypt = LoadHash(ICryptType);
            return MatchHash(key, hash, _crypt);
        }

        public static bool MatchHash(string key, string hash, ICrypt iCrypt)
        {
            if (iCrypt == null)
                throw new ArgumentNullException("iCrypt cannot be null");

            byte[] _key = Encoding.ASCII.GetBytes(key);
            byte[] _hash = Encoding.ASCII.GetBytes(hash);

            byte[] _rehashed = iCrypt.Crypt(_key, _hash);

            if (_rehashed == null || _rehashed.Length <= 0)
                return false;

            return (Encoding.ASCII.GetString(_rehashed) == hash);
        }


        #endregion

        #region Hash

        public static string Hash<ICryptType>(string key, string salt) where ICryptType : ICrypt 
        {
            ICrypt _crypt = LoadHash<ICryptType>();
            byte[] _key = Encoding.ASCII.GetBytes(key);
            byte[] _salt = Encoding.ASCII.GetBytes(salt);
            byte[] _result = _crypt.Crypt(_key, _salt);
            return Encoding.ASCII.GetString(_result); 
        }

        public static string Hash<ICryptType>(string key) where ICryptType : ICrypt 
        {
            ICrypt _crypt = LoadHash<ICryptType>();
            string _salt = Encoding.ASCII.GetString(_crypt.SaltGenerate());
            return Hash<ICryptType>(key, _salt);            
        }

        public static string HashWithType(string key, string ICryptType)
        {
            ICrypt _crypt = LoadHash(ICryptType);
            string _salt = Encoding.ASCII.GetString(_crypt.SaltGenerate());
            return HashWithType(key, _salt);
        }

        public static string HashWithType(string key, string salt, string ICryptType) 
        {
            ICrypt _crypt = LoadHash(ICryptType); 
            byte[] _key = Encoding.ASCII.GetBytes(key);
            byte[] _salt = Encoding.ASCII.GetBytes(salt);
            byte[] _result = _crypt.Crypt(_key, _salt);
            return Encoding.ASCII.GetString(_result);
        }

        public static string HashDefault(string key)
        {
            ICrypt _crypt = LoadHash(DefaultCrypt);
            string _salt = Encoding.ASCII.GetString(_crypt.SaltGenerate());
            return HashDefault(key, _salt);
        }

        public static string HashDefault(string key, string salt)
        {
            ICrypt _crypt = LoadHash(DefaultCrypt);
            byte[] _key = Encoding.ASCII.GetBytes(key);
            byte[] _salt = Encoding.ASCII.GetBytes(salt);
            byte[] _result = _crypt.Crypt(_key, _salt);
            return Encoding.ASCII.GetString(_result);
        }

        #endregion

        #endregion
    }
}
