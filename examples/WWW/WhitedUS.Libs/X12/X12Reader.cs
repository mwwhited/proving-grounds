using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace WhitedUS.Libs.X12
{
    //http://wiki.techdinamics.com/index.php?title=ANSI_ASC_X12
    public class X12Reader 
    {
        public X12Reader(Stream stream)
        {
            if (stream == null)
                throw new ArgumentNullException("stream");
            if (!stream.CanRead)
                throw new ArgumentException("can not read stream");

            this.BaseStream = stream;
        }

        protected Stream BaseStream { get; private set;}

 

    }
}
