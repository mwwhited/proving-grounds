using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Common.Graphics.Exif
{
    /// <summary>
    /// SceneType 
    /// </summary>
    /// <remarks>
    /// SceneType
    /// Indicates the type of scene. If a DSC recorded the image, this tag value shall always be set to 1, indicating that the
    /// image was directly photographed.
    /// Tag = 41729 (A301.H)
    /// Type = UNDEFINED
    /// Count = 1
    /// Default = 1
    /// 1 = A directly photographed image
    /// Other = reserved 
    /// </remarks>
    public enum SceneTypeType : byte
    {
        /// <summary>
        /// 1 = A directly photographed image
        /// </summary>
        DirectlyPhotographed = 1
    }
}
