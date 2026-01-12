using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Common.Converters
{
    /// <summary>
    /// Generic Converter to change input object to chosen type
    /// </summary>
    public static class MagicConverters
    {
        /// <summary>
        /// Generic Type Converter.  Convert, Cast, or Parse 
        /// your way into a differnet type.  If the 
        /// conversion is not supported the type default 
        /// will be returned
        /// </summary>
        /// <typeparam name="T">Type to Convert To</typeparam>
        /// <param name="_Object">Object to Convert</param>
        /// <returns>Converted Object</returns>
        public static T ToType<T>(this object _Object)
        {
            if (_Object == null)
                return default(T);

            if (!(_Object is string))
            {
                if (_Object is T)
                    return (T)_Object;
                else
                    return default(T);
            }

            if (typeof(T) == typeof(string))
                return (T)_Object;

            object _outVar = null;
            if (typeof(T) == typeof(int) || typeof(T) == typeof(int?))
            {
                int _iOutVar;
                int.TryParse((string)_Object, out _iOutVar);
                _outVar = (object)_iOutVar;
            }
            else if (typeof(T) == typeof(short) || typeof(T) == typeof(short?))
            {
                short _iOutVar;
                short.TryParse((string)_Object, out _iOutVar);
                _outVar = (object)_iOutVar;
            }
            else if (typeof(T) == typeof(bool) || typeof(T) == typeof(bool?))
            {
                bool _iOutVar;
                bool.TryParse((string)_Object, out _iOutVar);
                _outVar = (object)_iOutVar;
            }
            else if (typeof(T) == typeof(long) || typeof(T) == typeof(long?))
            {
                long _iOutVar;
                long.TryParse((string)_Object, out _iOutVar);
                _outVar = (object)_iOutVar;
            }
            else if (typeof(T) == typeof(Guid) || typeof(T) == typeof(Guid?))
            {
                Guid _iOutVar = new Guid((string)_Object);
                _outVar = (object)_iOutVar;
            }
            else if (typeof(T) == typeof(DateTime) || 
                        typeof(T) == typeof(DateTime?))
            {
                DateTime _iOutVar;
                DateTime.TryParse((string)_Object, out _iOutVar);
                _outVar = (object)_iOutVar;
            }
            else
            {
                return default(T);
            }

            if (typeof(T).IsNullable() && IComparable.Equals(_outVar, 
                Activator.CreateInstance(Nullable.GetUnderlyingType(typeof(T)))))
                _outVar = null;

            return (T)_outVar;
        }

        /// <summary>
        /// Check if Type is Nullable
        /// </summary>
        /// <param name="_Type">Type to Check</param>
        /// <returns>Boolean true if is nullable</returns>
        public static bool IsNullable(this Type _Type)
        {
            return (_Type.Namespace == "System" && 
                    _Type.Name == "Nullable`1"
                    ) || _Type.IsClass;
        }

        /// <summary>
        /// Check if Type is Nullable
        /// </summary>
        /// <typeparam name="T">Type to Check</typeparam>
        /// <returns>Boolean true if is nullable</returns>
        public static bool IsNullable<T>()
        {
            return DefaultValue<T>() == null;
        }

        /// <summary>
        /// Return a default value for a type
        /// </summary>
        /// <typeparam name="T">Type to get the default value of</typeparam>
        /// <returns>Default Value</returns>
        public static T DefaultValue<T>()
        {
            return default(T);
        }
    }
}
