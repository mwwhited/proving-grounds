using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Libs.CompressedFiles.PKZip
{
    public enum CompressionMethodType : short
    {
        /*
          compression method: (2 bytes)
          (see accompanying documentation for algorithm descriptions)
        */
        /// <summary>
        /// The file is stored (no compression)
        /// </summary>
        None = 0,
        /// <summary>
        /// The file is Shrunk
        /// </summary>
        Shrunk = 1,
        /// <summary>
        /// The file is Reduced with compression factor 1
        /// </summary>
        Factor1 = 2,
        /// <summary>
        /// The file is Reduced with compression factor 2
        /// </summary>
        Factor2 = 3,
        /// <summary>
        /// The file is Reduced with compression factor 3
        /// </summary>
        Factor3 = 4,
        /// <summary>
        /// The file is Reduced with compression factor 4
        /// </summary>
        Factor4 = 5,
        /// <summary>
        /// The file is Imploded
        /// </summary>
        Imploded = 6,
        /// <summary>
        /// Reserved for Tokenizing compression algorithm
        /// </summary>
        Tokenized = 7,
        /// <summary>
        /// The file is Deflated
        /// </summary>
        Deflate = 8,
        /// <summary>
        /// Enhanced Deflating using Deflate64(tm)
        /// </summary>
        Deflate64 = 9,
        /// <summary>
        /// PKWARE Data Compression Library Imploding (old IBM TERSE)
        /// </summary>
        IbmTerseOld = 10,
        /// <summary>
        /// Reserved by PKWARE
        /// </summary>
        Reserved11 = 11,
        /// <summary>
        /// File is compressed using BZIP2 algorithm
        /// </summary>
        BZIP2 = 12,
        /// <summary>
        /// Reserved by PKWARE
        /// </summary>
        Reserved13 = 13,
        /// <summary>
        /// LZMA (EFS)
        /// </summary>
        LZMA = 14,
        /// <summary>
        /// Reserved by PKWARE
        /// </summary>
        Reserved15 = 15,
        /// <summary>
        /// Reserved by PKWARE
        /// </summary>
        Reserved16 = 16,
        /// <summary>
        /// Reserved by PKWARE
        /// </summary>
        Reserved17 = 17,
        /// <summary>
        /// File is compressed using IBM TERSE (new)
        /// </summary>
        IbmTerseNew = 18,
        /// <summary>
        /// IBM LZ77 z Architecture (PFS)
        /// </summary>
        IbmLZ77z = 19,
        /// <summary>
        /// WavPack compressed data
        /// </summary>
        WavPack = 97,
        /// <summary>
        /// PPMd version I, Rev 1
        /// </summary>
        PPMdv1r1= 98
    }
}
