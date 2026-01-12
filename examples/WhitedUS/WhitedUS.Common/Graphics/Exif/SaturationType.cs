using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Common.Graphics.Exif
{
    /// <summary>
    /// Saturation 
    /// </summary>
    /// <remarks>
    /// Saturation
    /// This tag indicates the direction of saturation processing applied by the camera when the image was shot.
    /// Tag = 41993 (A409.H)
    /// Type = SHORT
    /// Count = 1
    /// Default = 0
    /// 0 = Normal
    /// 1 = Low saturation
    /// 2 = High saturation
    /// Other = reserved
    /// </remarks>
    public enum SaturationType : short
    {
        /// <remarks />
        Normal = 0,
        /// <remarks />
        Low = 1,
        /// <remarks />
        High = 2
    }
}
