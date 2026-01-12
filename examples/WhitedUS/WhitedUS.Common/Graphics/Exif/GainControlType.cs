using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Common.Graphics.Exif
{
    /// <summary>
    /// Gain Control
    /// </summary>
    /// <remarks>
    /// GainControl
    /// This tag indicates the degree of overall image gain adjustment.
    /// Tag = 41991 (A407.H)
    /// Type = SHORT
    /// Count = 1
    /// Default = none
    /// 0 = None
    /// 1 = Low gain up
    /// 2 = High gain up
    /// 3 = Low gain down
    /// 4 = High gain down
    /// Other = reserved
    /// </remarks>
    public enum GainControlType : short
    {
        /// <remarks />
        None = 0,
        /// <remarks />
        LowUp = 1,
        /// <remarks />
        HighUp = 2,
        /// <remarks />
        LowDown = 3,
        /// <remarks />
        HighDown = 4
    }
}
