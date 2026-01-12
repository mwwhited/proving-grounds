using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Libs.Graphics.Exif
{
    /// <summary>
    /// Sensing Method
    /// </summary>
    /// <remarks>
    /// SensingMethod
    /// Indicates the image sensor type on the camera or input device. The values are as follows.
    /// Tag = 41495 (A217.H)
    /// Type = SHORT
    /// Count = 1
    /// Default = none
    /// 1 = Not defined
    /// 2 = One-chip color area sensor
    /// 3 = Two-chip color area sensor
    /// 4 = Three-chip color area sensor
    /// 5 = Color sequential area sensor
    /// 7 = Trilinear sensor
    /// 8 = Color sequential linear sensor
    /// Other = reserved
    /// </remarks>
    public enum SensingMethodType : short
    {
        /// <summary>
        /// 1 = Not defined
        /// </summary>
        NotDefined = 1,

        /// <summary>
        /// 2 = One-chip color area sensor
        /// </summary>
        OneChipColor = 2,

        /// <summary>
        /// 3 = Two-chip color area sensor
        /// </summary>
        TwoChipColor = 3,

        /// <summary>
        /// 4 = Three-chip color area sensor
        /// </summary>
        ThreeChipColor = 4,

        /// <summary>
        /// 5 = Color sequential area sensor
        /// </summary>
        ColorSequential = 5,

        /// <summary>
        /// 7 = Trilinear sensor
        /// </summary>
        Triliner = 7,

        /// <summary>
        /// 8 = Color sequential linear sensor
        /// </summary>
        ColorSequentialLinear = 8
    }
}
