using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection.Emit;

namespace WhitedUS.Libs.Converters
{
    public partial class GenericParser
    {
        /// <summary>
        /// Generic Convertion
        /// </summary>
        /// <typeparam name="T">Type to Convert To</typeparam>
        /// <typeparam name="U">Type to Convert From</typeparam>
        /// <param name="input">Instance of Type "U"</param>
        /// <returns>Instance of "T" based on "input"</returns>
        public static T ConvertTo<T, U>(U input)
        {
            return (T)ConvertTo(typeof(T), input);
        }

        /// <summary>
        /// Generic Convertion
        /// </summary>
        /// <param name="outputType">Type to Convert To</param>
        /// <param name="input">Instance to Convert</param>
        /// <returns>Instance of "outputType" based on "input"</returns>
        public static object ConvertTo(Type outputType, object input)
        {
            if (outputType == null)
                throw new ArgumentNullException("outputType must be provided");

            if (input == null)
                return CreateInstance(outputType);

            if (outputType.IsInstanceOfType(input))
                return input;

            if (outputType.IsGenericType && 
                outputType.Name.StartsWith("Nullable`"))
            {
                outputType = outputType.GetGenericArguments().FirstOrDefault();
                if (outputType.IsInstanceOfType(input))
                    return input;
            }

            if (outputType.IsEnum)
            {
                if (input is string)
                    return Enum.Parse(outputType, (string)input);
                else
                {
                    Type enumSubType = Enum.GetUnderlyingType(outputType);
                    if (!enumSubType.IsInstanceOfType(input))
                        input = ConvertTo(enumSubType, input);

                    if (input is IConvertible)
                        return CastTo(outputType, input);
                }
            }
            else if (input is string)
            {
                if (outputType.IsAssignableFrom(typeof(byte[])))
                {
                    var getValue = Encoding.ASCII.GetBytes(input.ToString());
                    return getValue;
                }
                else
                {
                    object getValue = CreateInstance(outputType);
                    if (TryParse(outputType, (string)input, out getValue))
                        return getValue;
                }
            }
            else if (input is IConvertible && 
                outputType.GetInterface(typeof(IConvertible).FullName) != null)
            {
                return Convert.ChangeType(input, outputType);
            }
            else if (outputType == typeof(string) && input is byte[])
            {
                return ASCIIEncoding.UTF8.GetString((byte[])input);
            }

            return CastTo(outputType, input);
        }
    }
}
