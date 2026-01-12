using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Common.Graphics.Exif
{
    /// <summary>
    /// Focal Plane Resolution Unit
    /// </summary>
    /// <remarks>
    /// FocalPlaneResolutionUnit
    /// Indicates the unit for measuring FocalPlaneXResolution and FocalPlaneYResolution. This value is the same as the
    /// ResolutionUnit.
    /// Tag = 41488 (A210.H)
    /// Type = SHORT
    /// Count = 1
    /// Default = 2 (inch)
    /// Note on use of tags concerning focal plane resolution
    /// These tags record the actual focal plane resolutions of the main image which is written as a file after processing
    /// instead of the pixel resolution of the image sensor in the camera. It should be noted carefully that the data from
    /// the image sensor is resampled.
    /// These tags are used at the same time as a FocalLength tag when the angle of field of the recorded image is to
    /// be calculated precisely.
    /// </remarks>
    public enum FocalPlaneResolutionUnitType : short
    {
        Inches = 2
    }
}
