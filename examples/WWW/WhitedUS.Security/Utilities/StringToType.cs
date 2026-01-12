using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Globalization;
using System.Linq;
using System.Text;

namespace WhitedUS.Security.Utilities
{
    internal class StringToType : TypeConverter 
    {
        public override bool CanConvertFrom(ITypeDescriptorContext context, 
                                            Type sourceType)
        {
            return sourceType == typeof(Type);
        }

        public override object ConvertFrom(ITypeDescriptorContext context, 
                                           CultureInfo culture, 
                                           object value)
        {
            if (string.IsNullOrEmpty(value as string))
                throw new InvalidOperationException();

            return Type.GetType(value as string);
        }

        public override bool CanConvertTo(ITypeDescriptorContext context, 
                                          Type destinationType)
        {
            return destinationType == typeof(String);
        }
        
        public override object ConvertTo(ITypeDescriptorContext context, 
                                         CultureInfo culture, 
                                         object value, 
                                         Type destinationType)
        {
            if (!(value is Type))
                throw new InvalidOperationException();

            return (value as Type).FullName;
        }
    }
}
