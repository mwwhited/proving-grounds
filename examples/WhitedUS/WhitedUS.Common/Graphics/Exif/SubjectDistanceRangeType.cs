using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Common.Graphics.Exif
{
    /// <summary>
    /// Subject Distance Range
    /// </summary>
    /// <remarks>
    /// SubjectDistanceRange
    /// This tag indicates the distance to the subject.
    /// Tag = 41996 (A40C.H)
    /// Type = SHORT
    /// Count = 1
    /// Default = none
    /// 0 = unknown
    /// 1 = Macro
    /// 2 = Close view
    /// 3 = Distant view
    /// Other = reserved
    /// </remarks>
    public enum SubjectDistanceRangeType : short
    {
        /// <remarks />
        Unknown = 0,

        /// <remarks />
        Macro = 1,

        /// <remarks />
        Close = 2,

        /// <remarks />
        Distant = 3
    }
}
