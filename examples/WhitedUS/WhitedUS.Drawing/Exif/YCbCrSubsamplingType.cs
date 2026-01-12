using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Drawing.Exif
{
    /// <summary>
    /// YCbCrSubSampling
    /// The sampling ratio of chrominance components in relation to the luminance component. In JPEG compressed data
    /// a JPEG marker is used instead of this tag.
    /// Tag = 530 (212.H)
    /// Type = SHORT
    /// Count = 2
    /// [2, 1] = YCbCr4:2:2
    /// [2, 2] = YCbCr4:2:0
    /// Other = reserved
    /// </summary>
    public enum YCbCrSubsamplingType : int
    {
        /// <remarks />
        YCbCr422 = 2 << 16 + 1,
        /// <remarks />
        YCbCr420 = 2 << 16 + 2,
    }
}
