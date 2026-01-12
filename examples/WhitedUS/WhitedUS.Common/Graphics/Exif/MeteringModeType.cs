using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Common.Graphics.Exif
{
    /// <summary>
    /// Metering Mode
    /// </summary>
    /// <remarks>
    /// MeteringMode
    /// The metering mode.
    /// Tag = 37383 (9207.H)
    /// Type = SHORT
    /// Count = 1
    /// Default = 0
    /// 0 = unknown
    /// 1 = Average
    /// 2 = CenterWeightedAverage
    /// 3 = Spot
    /// 4 = MultiSpot
    /// 5 = Pattern
    /// 6 = Partial
    /// Other = reserved
    /// 255 = other
    /// </remarks>
    public enum MeteringModeType : short
    {
        /// <remarks />
        Unknown = 0,

        /// <remarks />
        Average = 1,

        /// <remarks />
        CenterWeightedAverage = 2,

        /// <remarks />
        Sport = 3,

        /// <remarks />
        MuiltiSpot = 4,

        /// <remarks />
        Pattern = 5,

        /// <remarks />
        Parital = 6,

        /// <remarks />
        Other = 255

    }
}
