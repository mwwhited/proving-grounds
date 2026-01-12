using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Libs.Graphics.Exif
{
    /// <summary>
    /// PlanarConfiguration
    /// Indicates whether pixel components are recorded in chunky or planar format. In JPEG compressed files a JPEG
    /// marker is used instead of this tag. If this field does not exist, the TIFF default of 1 (chunky) is assumed.
    /// Tag = 284 (11C.H)
    /// Type = SHORT
    /// Count = 1
    /// 1 = chunky format
    /// 2 = planar format
    /// Other = reserved
    /// </summary>
    public enum PlanarConfigurationType : short
    {
        /// <remarks />
        Chunky = 1,
        /// <remarks />
        Planar = 2
    }
}
