using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Drawing.Exif
{
    /// <summary>
    /// Sharpness
    /// </summary>
    /// <remarks>
    /// Sharpness
    /// This tag indicates the direction of sharpness processing applied by the camera when the image was shot.
    /// Tag = 41994 (A40A.H)
    /// Type = SHORT
    /// Count = 1
    /// Default = 0
    /// 0 = Normal
    /// 1 = Soft
    /// 2 = Hard
    /// Other = reserved        
    /// </remarks>
    public enum SharpnessType : short
    {
        /// <remarks />
        Normal = 0,
        /// <remarks />
        Low = 1,
        /// <remarks />
        High = 2
    }
}
