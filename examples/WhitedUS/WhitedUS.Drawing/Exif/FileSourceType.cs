using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Drawing.Exif
{
    /// <summary>
    /// File Source
    /// </summary>
    /// <remarks>
    /// FileSource
    /// Indicates the image source. If a DSC recorded the image, this tag value of this tag always be set to 3, indicating
    /// that the image was recorded on a DSC.
    /// Tag = 41728 (A300.H)
    /// Type = UNDEFINED
    /// Count = 1
    /// Default = 3
    /// 3 = DSC
    /// Other = reserved
    /// </remarks>
    public enum FileSourceType : byte
    {
        DSC = 3
    }
}
