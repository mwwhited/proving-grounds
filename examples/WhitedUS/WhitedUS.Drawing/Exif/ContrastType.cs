using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Drawing.Exif
{
    /// <summary>
    /// Contrast 
    /// </summary>
    /// <remarks>
    /// Contrast
    /// This tag indicates the direction of contrast processing applied by the camera when the image was shot.
    /// Tag = 41992 (A408.H)
    /// Type = SHORT
    /// Count = 1
    /// Default = 0
    /// 0 = Normal
    /// 1 = Soft
    /// 2 = Hard
    /// Other = res
    public enum ContrastType : short
    {
        /// <remarks />
        Normal = 0,
        /// <remarks />
        Soft = 1,
        /// <remarks />
        Hard = 2
    }
}
