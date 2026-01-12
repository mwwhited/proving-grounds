using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;
using System.Globalization;

namespace WhitedUS.Common
{
    public class TypeTypeConverter : TypeConverter
    {
        public override bool CanConvertTo(ITypeDescriptorContext context, 
                                          Type destinationType)
        {
            return base.CanConvertTo(context, destinationType);
        }

        public override object ConvertTo(ITypeDescriptorContext context, 
                                         CultureInfo culture, 
                                         object value, 
                                         Type destinationType)
        {
            return base.ConvertTo(context, culture, value, destinationType);
        }

        public override bool CanConvertFrom(ITypeDescriptorContext context, 
                                            Type sourceType)
        {
            return base.CanConvertFrom(context, sourceType);
        }

        public override object ConvertFrom(ITypeDescriptorContext context, 
                                           CultureInfo culture, 
                                           object value)
        {
            return Type.GetType(value as string);
        }
    }
}
