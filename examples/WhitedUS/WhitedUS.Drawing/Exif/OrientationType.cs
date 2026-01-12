using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Drawing.Exif
{
    /// <summary>
    /// Orientation
    /// The image orientation viewed in terms of rows and columns.
    /// Tag = 274 (112.H)
    /// Type = SHORT
    /// Count = 1
    /// Default = 1
    /// 1 = The 0th row is at the visual top of the image, and the 0th column is the visual left-hand side.
    /// 2 = The 0th row is at the visual top of the image, and the 0th column is the visual right-hand side.
    /// 3 = The 0th row is at the visual bottom of the image, and the 0th column is the visual right-hand side.
    /// 4 = The 0th row is at the visual bottom of the image, and the 0th column is the visual left-hand side.
    /// 5 = The 0th row is the visual left-hand side of the image, and the 0th column is the visual top.
    /// 6 = The 0th row is the visual right-hand side of the image, and the 0th column is the visual top.
    /// 7 = The 0th row is the visual right-hand side of the image, and the 0th column is the visual bottom.
    /// 8 = The 0th row is the visual left-hand side of the image, and the 0th column is the visual bottom.
    /// Other = reserved
    /// </summary>
    public enum OrientationType : short
    {
        /// <summary>
        /// The 0th row is at the visual top of the image, and the 0th column is the visual left-hand side.
        /// </summary>
        TopLeft = 1,

        /// <summary>
        /// The 0th row is at the visual top of the image, and the 0th column is the visual right-hand side.
        /// </summary>
        TopRight = 2,

        /// <summary>
        /// The 0th row is at the visual bottom of the image, and the 0th column is the visual right-hand side
        /// </summary>
        BottomRight = 3,

        /// <summary>
        /// The 0th row is at the visual bottom of the image, and the 0th column is the visual left-hand side.
        /// </summary>
        BottomLeft = 4,

        /// <summary>
        /// The 0th row is the visual left-hand side of the image, and the 0th column is the visual top.
        /// </summary>
        LeftTop = 5,

        /// <summary>
        /// The 0th row is the visual right-hand side of the image, and the 0th column is the visual top.
        /// </summary>
        RightTop = 6,

        /// <summary>
        /// The 0th row is the visual right-hand side of the image, and the 0th column is the visual bottom.
        /// </summary>
        RightBottom = 7,

        /// <summary>
        /// The 0th row is the visual left-hand side of the image, and the 0th column is the visual bottom.
        /// </summary>
        LeftBottom = 8,
    }
}
