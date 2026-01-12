using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Libs.Graphics.Exif
{
    /// <summary>
    /// Exposure Mode
    /// </summary>
    /// <remarks>
    /// ExposureMode
    /// This tag indicates the exposure mode set when the image was shot. In auto-bracketing mode, the camera shoots a
    /// series of frames of the same scene at different exposure settings.
    /// Tag = 41986 (A402.H)
    /// Type = SHORT
    /// Count = 1
    /// Default = none
    /// 0 = Auto exposure
    /// 1 = Manual exposure
    /// 2 = Auto bracket
    /// Other = reserved
    /// </remarks>
    public enum ExposureModeType : short
    {
        /// <summary>
        /// 0 = Auto exposure
        /// </summary>
        Auto = 0,

        /// <summary>
        /// 1 = Manual exposure
        /// </summary>
        Manual = 1,

        /// <summary>
        /// 2 = Auto bracket
        /// </summary>
        AutoBracket = 2
    }
}
