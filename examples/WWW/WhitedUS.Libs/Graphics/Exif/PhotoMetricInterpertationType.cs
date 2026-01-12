using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Libs.Graphics.Exif
{
    /// <summary>
    /// PhotometricInterpretation
    /// The pixel composition. In JPEG compressed data a JPEG marker is used instead of this tag.
    /// Tag = 262 (106.H)
    /// Type = SHORT
    /// Count = 1
    /// Default = none
    /// 2 = RGB
    /// 6 = YCbCr
    /// Other = reserved
    /// </summary>
    public enum PhotoMetricInterpertationType : short
    {
        /// <remarks />
        RGB = 2,

        /// <remarks />
        YCbCr = 6
    }
}
