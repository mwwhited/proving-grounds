using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Libs.X12
{
    public struct X12Separators
    {
        public char Element { get; set; }
        public char SubElement { get; set; }
        public char Segment { get; set; }
    }
}
