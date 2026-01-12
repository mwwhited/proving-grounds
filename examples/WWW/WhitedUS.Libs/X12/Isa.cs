using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Libs.X12
{
    /*
    ISA Segment
      ISA01 Authorization Information Qualifier
      ISA02 Authorization Information
      ISA03 Security Information Qualifier
      ISA04 Security Information
      ISA05 Interchange ID Qualifier
      ISA06 Interchange Sender ID
      ISA07 Interchange ID Qualifier
      ISA08 Interchange Receiver ID
      ISA09 Interchange Date
      ISA10 Interchange Time
      ISA11 Interchange Control Standards ID
      ISA12 Interchange Control Version Number
      ISA13 Interchange Control Number
      ISA14 Acknowledgement Requested
      ISA15 Test Indicator
      ISA16 Subelement Separator
    */
    public class Isa : IX12Segment
    {
        public Isa() { }
        internal Isa(string isaSegment)
        {
            if (isaSegment.Length != 106)
                throw new ArgumentOutOfRangeException("isaSegment must be 105 characters long");

            //"ISA*00*1234567890*00*0987654321*ZZ*123456789012345*ZZ*098765432109876*YYMMDD*HHMM*U*00401*123456789*1*1*>~";

        }

        public X12Separators Seperators { get; protected set; }
    }
}
