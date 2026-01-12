using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Drawing.Exif
{
    /// <summary>
    /// White Balance
    /// </summary>
    /// <remarks>
    /// WhiteBalance
    /// This tag indicates the white balance mode set when the image was shot.
    /// Tag = 41987 (A403.H)
    /// Type = SHORT
    /// Count = 1
    /// Default = none
    /// 0 = Auto white balance
    /// 1 = Manual white balance
    /// Other = reserved
    /// </remarks>
    public enum WhiteBalanceType : short
    { 
        /// <summary>
        /// 0 = Auto white balance
        /// </summary>
        Auto = 0,

        /// <summary>
        /// 1 = Manual white balance
        /// </summary>
        Manual = 1

    }
}
