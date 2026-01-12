using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Libs.Graphics.Exif
{
    /// <summary>
    /// ExposureProgram
    /// </summary>
    /// <remarks>
    /// The class of the program used by the camera to set exposure when the picture is taken. The tag values are as
    /// follows.
    /// Tag = 34850 (8822.H)
    /// Type = SHORT
    /// Count = 1
    /// Default = 0
    /// 0 = Not defined
    /// 1 = Manual
    /// 2 = Normal program
    /// 3 = Aperture priority
    /// 4 = Shutter priority
    /// 5 = Creative program (biased toward depth of field)
    /// 6 = Action program (biased toward fast shutter speed)
    /// 7 = Portrait mode (for closeup photos with the background out of focus)
    /// 8 = Landscape mode (for landscape photos with the background in focus)
    /// Other = reserved
    /// </remarks>
    public enum ExposureProgramType : short
    {
        /// <summary>
        /// Not defined
        /// </summary>
        NotDefined = 0,

        /// <summary>
        /// Manual
        /// </summary>
        Manual = 1,

        /// <summary>
        /// Normal program
        /// </summary>
        Normal = 2,

        /// <summary>
        /// Aperture priority
        /// </summary>
        AperturePriority = 3,

        /// <summary>
        /// Shutter priority
        /// </summary>
        ShutterPriority = 4,

        /// <summary>
        /// Creative program (biased toward depth of field)
        /// </summary>
        Creative = 5,

        /// <summary>
        /// Action program (biased toward fast shutter speed)
        /// </summary>
        Action = 6,

        /// <summary>
        /// Portrait mode (for closeup photos with the background out of focus)
        /// </summary>
        Portrait = 7,

        /// <summary>
        /// Landscape mode (for landscape photos with the background in focus)
        /// </summary>
        Landscape = 8
    }
}
