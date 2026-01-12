using System;
using System.ComponentModel;
using System.Globalization;

namespace MyControls.DataSources.ObjectHierarchicalDataSource {
    /// <summary>
    /// Converts a string containing a separated list into a string[].
    /// </summary>
    /// <remarks>Uses the culture's list separator.</remarks>
    public class PropertyNamesConverter : TypeConverter {
        /// <summary>
        /// Only allow conversion from string
        /// </summary>
        /// <returns>true if sourceType is string</returns>
        public override bool CanConvertFrom(ITypeDescriptorContext context, Type sourceType) {
            if (sourceType == typeof(string)) {
                return true;
            }
            return false;
        }

        /// <summary>
        /// Converts a separated string into a string[].
        /// </summary>
        /// <param name="value">The string to convert.</param>
        /// <returns>The converted string[].</returns>
        public override object ConvertFrom(ITypeDescriptorContext context, CultureInfo culture, object value) {
            string stringValue = value as string;
            if (stringValue != null) {
                if (stringValue.Length == 0) {
                    return new string[0];
                }

                string[] names = stringValue.Split(new char[] { culture.TextInfo.ListSeparator[0] });
                for (int i = 0; i < names.Length; i++) {
                    names[i] = names[i].Trim();
                }
                return names;
            }
            throw GetConvertFromException(value);
        }

        /// <summary>
        /// Converts a string[] into a separated string.
        /// </summary>
        /// <param name="value">The string[] to convert.</param>
        /// <param name="destinationType">Must be string.</param>
        /// <returns>A string joining the value elements with the culture's list separator.</returns>
        public override object ConvertTo(ITypeDescriptorContext context, CultureInfo culture, object value, Type destinationType) {
            if (destinationType == typeof(string)) {
                string[] arrayValue = value as string[];
                if (arrayValue == null) {
                    return String.Empty;
                }
                return String.Join(culture.TextInfo.ListSeparator, arrayValue);
            }
            throw GetConvertToException(value, destinationType);
        }
    }
}