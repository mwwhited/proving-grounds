using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Libs.Graphics.Exif
{
    /// <summary>
    /// YCbCrPositioning
    /// The position of chrominance components in relation to the luminance component. This field is designated only for
    /// JPEG compressed data or uncompressed YCbCr data. The TIFF default is 1 (centered); but when Y:Cb:Cr = 4:2:2
    /// it is recommended in this standard that 2 (co-sited) be used to record data, in order to improve the image quality
    /// when viewed on TV systems. When this field does not exist, the reader shall assume the TIFF default. In the case
    /// of Y:Cb:Cr = 4:2:0, the TIFF default (centered) is recommended. If the reader does not have the capability of
    /// supporting both kinds of YCbCrPositioning, it shall follow the TIFF default regardless of the value in this field. It is
    /// preferable that readers be able to support both centered and co-sited positioning.
    /// Tag = 531 (213.H)
    /// Type = SHORT
    /// Count = 1
    /// Default = 1
    /// 1 = centered
    /// 2 = co-sited
    /// Other = reserved
    /// </summary>
    public enum YCbCrPositioningType : short
    {
        /// <remarks />
        Centered = 1,
        /// <remarks />
        CoSited = 2
    }
}
