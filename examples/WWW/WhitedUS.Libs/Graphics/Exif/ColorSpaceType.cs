using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Libs.Graphics.Exif
{
    /// <summary>
    /// ColorSpace
    /// The color space information tag (ColorSpace) is always recorded as the color space specifier.
    /// Normally sRGB (=1) is used to define the color space based on the PC monitor conditions and environment. If a
    /// color space other than sRGB is used, Uncalibrated (=FFFF.H) is set. Image data recorded as Uncalibrated can be
    /// treated as sRGB when it is converted to Flashpix. On sRGB see Annex E.
    /// Tag = 40961 (A001.H)
    /// Type = SHORT
    /// Count = 1
    /// 1 = sRGB
    /// FFFF.H = Uncalibrated
    /// Other = reserved
    /// </summary>
    public enum ColorSpaceType : short
    {
        /// <remarks />
        sRGB = 1,

        /// <remarks />
        Uncalibrated = -1
    }
}
