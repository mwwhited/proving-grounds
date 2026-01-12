using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Common.Graphics.Exif
{
    [AttributeUsage(AttributeTargets.Property, AllowMultiple = false, Inherited = false)]
    public class ExifTypeIdAttribute : Attribute
    {
        public ExifTypeIdAttribute(ExifIdType id)
        {
            _id = id;
        }

        private ExifIdType _id;
        public ExifIdType ID { get { return _id; } }
    }
}
