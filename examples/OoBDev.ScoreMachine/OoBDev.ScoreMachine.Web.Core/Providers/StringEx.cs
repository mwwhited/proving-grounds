using System;
using System.Linq;
using System.Collections.Generic;
using System.Net;
using System.Runtime.InteropServices;
using Newtonsoft.Json;
using System.Reflection;

namespace OoBDev.ScoreMachine.Web.Core.Providers
{
    public static class StringEx
    {
        /// <summary>
        /// Try loading value from provided environment variable
        /// </summary>
        /// <param name="variable"></param>
        /// <param name="defaultValue"></param>
        /// <returns></returns>
        public static string FromEnvironment(this string variable, string defaultValue = null)
        {
            if (string.IsNullOrWhiteSpace(variable)) return defaultValue;
            var value = Environment.GetEnvironmentVariable(variable);
            return string.IsNullOrWhiteSpace(value) ? defaultValue : value;
        }

        public static bool Is(this string input, string comparedTo, StringComparison comparison = StringComparison.InvariantCultureIgnoreCase)
        {
            return string.Equals(input?.Trim() ?? "", comparedTo?.Trim() ?? "", StringComparison.InvariantCultureIgnoreCase);
        }

        public static string As(this object input, string delimiter = ";")
        {
            if (input == null) return null;

            var type = input.GetType();
            if (type.IsPrimitive || input is string || input is DateTime || input is TimeSpan || input is IPAddress || input is Uri || input is Guid)
            {
                return input.ToString();
            }

            if (input is byte[] data)
            {
                return Convert.ToBase64String(data);
            }

            if (input is IEnumerable<object> items)
            {
                return string.Join(delimiter, items.Select(i => i?.As()));
            }

            var properties = type.GetProperties(BindingFlags.GetProperty | BindingFlags.Public | BindingFlags.Instance);
            if (properties != null)
            {
                var values = from p in properties
                             let v = p.GetValue(input).As()
                             where !string.IsNullOrWhiteSpace(v)
                             select string.Join("= ",p.Name, v);
                return string.Join(Environment.NewLine, values);
            }


            return input.ToString();
        }

        public static int As(this string input, int defaultValue)
        {
            if (string.IsNullOrWhiteSpace(input)) return defaultValue;
            return int.TryParse(input, out var result) ? result : defaultValue;
        }

        public static IPAddress As(this string input, IPAddress defaultValue)
        {
            if (string.IsNullOrWhiteSpace(input)) return defaultValue;
            return IPAddress.TryParse(input, out var result) ? result : defaultValue;
        }

        public static T OrByOsPlatform<T>(this T input, IEnumerable<(OSPlatform os, T defaultValue)> choices, T defaultValue = default(T))
        {
            if (input != null)
                return input;

            if (choices != null)
            {
                var found = choices.Where(i => RuntimeInformation.IsOSPlatform(i.os))
                                   .Select(i => i.defaultValue).FirstOrDefault();
                if (found != null)
                    return found;
            }

            return defaultValue;
        }
    }
}
