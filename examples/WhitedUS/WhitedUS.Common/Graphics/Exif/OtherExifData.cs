using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Common.Graphics.Exif
{
    public class OtherExifDataList : List<OtherExifData>
    {
        public override string ToString()
        {
            StringBuilder sb = new StringBuilder();
            foreach (var item in this)
                sb.AppendFormat("\r\n\t{0}", item);

            return sb.ToString();
        }
    }

    public class OtherExifData
    {
        public ExifIdType ID { get; set; }
        public ExifType Type { get; set; }
        public byte[] Data { get; set; }
        public object Value
        {
            get
            {
                return Type.GetValue(Data);
            }
        }

        public override string ToString()
        {
            return string.Format("{0} ({1}): {2}", ID.ToString(), (int)ID, Value);
        }
    }
}
