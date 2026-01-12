using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Libs.Graphics.Exif
{
    /// <summary>
    /// Scene Capture Type
    /// </summary>
    /// <remarks>
    /// SceneCaptureType
    /// This tag indicates the type of scene that was shot. It can also be used to record the mode in which the image was
    /// shot. Note that this differs from the scene type (SceneType) tag.
    /// Tag = 41990 (A406.H)
    /// Type = SHORT
    /// Count = 1
    /// Default = 0
    /// 0 = Standard
    /// 1 = Landscape
    /// 2 = Portrait
    /// 3 = Night scene
    /// Other = reserved 
    /// </remarks>
    public enum SceneCaptureTypeType : short
    {
        /// <remarks />
        Standard = 0,

        /// <remarks />
        Landscape = 1,

        /// <remarks />
        Portrait = 2,

        /// <remarks />
        NightScene = 3
    }
}
