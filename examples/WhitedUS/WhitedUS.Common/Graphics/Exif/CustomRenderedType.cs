using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Common.Graphics.Exif
{
    /// <summary>
    /// Custom Rendered
    /// </summary>
    /// <remarks>
    /// CustomRendered
    /// This tag indicates the use of special processing on image data, such as rendering geared to output. When special
    /// processing is performed, the reader is expected to disable or minimize any further processing.
    /// Tag = 41985 (A401.H)
    /// Type = SHORT
    /// Count = 1
    /// Default = 0
    /// 0 = Normal process
    /// 1 = Custom process
    /// Other = reserved 
    /// </remarks>
    public enum CustomRenderedType : short
    {
        /// <summary>
        /// 0 = Normal process
        /// </summary>
        Normal = 0,

        /// <summary>
        /// 1 = Custom process
        /// </summary>
        Custom = 1
    }
}
