using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;

namespace WhitedUS.Web.Controls
{
    public class TimeStampDictionary<TKey, TValue> : IDictionary<TKey, TValue>
    {
        private Dictionary<TKey, DateTime> _timeStamps =
                                        new Dictionary<TKey, DateTime>();
        private Dictionary<TKey, TValue> _dictionary =
                                        new Dictionary<TKey, TValue>();
        private TimeSpan _expiry = TimeSpan.FromMinutes(20);
        private DateTime _nextExpiry;

        public TimeStampDictionary()
        {
            _nextExpiry = DateTime.UtcNow.Add(_expiry);
        }
        public TimeStampDictionary(TimeSpan expiry)
        {
            _expiry = expiry;
            _nextExpiry = DateTime.UtcNow.Add(_expiry);
        }

        public void ClearExpired()
        {
            if (DateTime.UtcNow > _nextExpiry)
            {
                lock (this)
                {
                    var removeKeys = _timeStamps
                        .Where(t => t.Value <=
                                        DateTime.UtcNow.Subtract(_expiry))
                        .Select(t => t.Key)
                        .ToArray();

                    for (int i = 0; i < removeKeys.Length; i++)
                    {
                        _timeStamps.Remove(removeKeys[i]);
                        _dictionary.Remove(removeKeys[i]);
                    }
                }
            }
        }

        #region IDictionary<TKey,TValue> Members

        public void Add(TKey key, TValue value)
        {
            lock (this)
            {
                _timeStamps.Add(key, DateTime.UtcNow);
                _dictionary.Add(key, value);
            }
        }

        public bool ContainsKey(TKey key)
        {
            lock (this)
            {
                return _dictionary.ContainsKey(key);
            }
        }

        public ICollection<TKey> Keys
        {
            get
            {
                lock (this)
                {
                    return _dictionary.Keys;
                }
            }
        }

        public bool Remove(TKey key)
        {
            lock (this)
            {
                _timeStamps.Remove(key);
                return _dictionary.Remove(key);
            }
        }

        public bool TryGetValue(TKey key, out TValue value)
        {
            lock (this)
            {
                return _dictionary.TryGetValue(key, out value);
            }
        }

        public ICollection<TValue> Values
        {
            get
            {
                lock (this)
                {
                    return _dictionary.Values;
                }
            }
        }

        public TValue this[TKey key]
        {
            get
            {
                lock (this)
                {
                    _timeStamps[key].Add(_expiry);
                    return _dictionary[key];
                }
            }
            set
            {
                lock (this)
                {
                    _dictionary[key] = value;
                }
            }
        }

        #endregion

        #region ICollection<KeyValuePair<TKey,TValue>> Members

        public void Add(KeyValuePair<TKey, TValue> item)
        {
            Add(item.Key, item.Value);
        }

        public void Clear()
        {
            _timeStamps.Clear();
            _dictionary.Clear();
        }

        public bool Contains(KeyValuePair<TKey, TValue> item)
        {
            return _dictionary.ContainsKey(item.Key);
        }

        public void CopyTo(KeyValuePair<TKey, TValue>[] array, int arrayIndex)
        {
            //NotImplemented: TimeStampDictionary::CopyTo
            throw new NotImplementedException();
        }

        public int Count
        {
            get { return _dictionary.Count; }
        }

        public bool IsReadOnly
        {
            get
            {
                //NotImplemented: TimeStampDictionary::IsReadOnly
                throw new NotImplementedException();
            }
        }

        public bool Remove(KeyValuePair<TKey, TValue> item)
        {
            if (_dictionary.Remove(item.Key))
                return _timeStamps.Remove(item.Key);
            return false;
        }

        #endregion

        #region IEnumerable<KeyValuePair<TKey,TValue>> Members

        public IEnumerator<KeyValuePair<TKey, TValue>> GetEnumerator()
        {
            return _dictionary.GetEnumerator();
        }

        #endregion

        #region IEnumerable Members

        IEnumerator IEnumerable.GetEnumerator()
        {
            return _dictionary.GetEnumerator();
        }

        #endregion
    }
}
