using CarMaintenanceLog.Abstractions.ComponentModel;
using Newtonsoft.Json;
using System;
using System.Linq;

namespace CarMaintenanceLog.Common.Converters
{

    public class JsonEnumValueConverter : JsonConverter
    {
        public override bool CanConvert(Type objectType)
        {
            var t = SummerizeType(objectType);
            if (t == null)
            {
                return false;
            }

            return t.IsEnum && (t.GetMembers()?.Any(m => m.GetCustomAttributes(false)?.OfType<EnumValueAttribute>().Any() ?? false) ?? false);
        }


        public override object ReadJson(JsonReader reader, Type objectType, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null)
            {
                return DefaultValue(objectType);
            }

            var t = SummerizeType(objectType);
            if (reader.TokenType == JsonToken.Integer)
            {
                return Enum.ToObject(t, reader.Value);
            }
            else if (reader.TokenType == JsonToken.String)
            {
                var v = reader.Value.ToString().Trim();

                if (string.IsNullOrWhiteSpace(v))
                {
                    return DefaultValue(objectType);
                }

                var vs = (from m in t.GetMembers()
                          let a = m?.GetCustomAttributes(typeof(EnumValueAttribute), false)?.OfType<EnumValueAttribute>()?.FirstOrDefault()?.Name?.Trim()
                          where string.Equals(v, a, StringComparison.InvariantCultureIgnoreCase)
                          select m.Name).FirstOrDefault() ?? v;

                try
                {
                    return Enum.Parse(t, vs);
                }
                catch { }

                if (long.TryParse(vs, out var i))
                {
                    return Enum.ToObject(t, i);
                }
            }

            throw new NotSupportedException();

            /*
            bool isNullable = ReflectionUtils.IsNullableType(objectType);
            Type t = isNullable ? Nullable.GetUnderlyingType(objectType) : objectType;

                if (reader.TokenType == JsonToken.String)
                {
                    string? enumText = reader.Value?.ToString();

                    if (StringUtils.IsNullOrEmpty(enumText) && isNullable)
                    {
                        return null;
                    }

                    return EnumUtils.ParseEnum(t, NamingStrategy, enumText!, !AllowIntegerValues);
                }

            */
        }

        public override void WriteJson(JsonWriter writer, object value, JsonSerializer serializer)
        {
            if (value == null)
            {
                writer.WriteNull();
            }
            else
            {
                var type = SummerizeType(value.GetType());
                var info = type.GetMember(value.ToString());
                var member = info.FirstOrDefault(m => m.DeclaringType == type);
                var attribute = member?.GetCustomAttributes(typeof(EnumValueAttribute), false)?
                                       .OfType<EnumValueAttribute>()
                                       .FirstOrDefault();
                var mapped = attribute?.Name ?? value.ToString();

                writer.WriteValue(mapped);
            }
        }

        private static object DefaultValue(Type objectType)
        {
            return IsNullable(objectType) ? null : Convert.ChangeType(0, objectType);
        }
        private static Type SummerizeType(Type objectType)
        {
            if (objectType == null) return null;
            return IsNullable(objectType)
                ? Nullable.GetUnderlyingType(objectType)
                : objectType;
        }
        private static bool IsNullable(Type t)
        {
            if (!t.IsValueType)
            {
                return true;
            }

            return t.IsGenericType && t.GetGenericTypeDefinition() == typeof(Nullable<>);
        }
    }
}
