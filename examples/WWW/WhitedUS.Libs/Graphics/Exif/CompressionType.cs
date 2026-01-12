using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Libs.Graphics.Exif
{
    /// <summary>
    /// Compression
    /// The compression scheme used for the image data. When a primary image is JPEG compressed, this designation is
    /// not necessary and is omitted. When thumbnails use JPEG compression, this tag value is set to 6.
    /// Tag = 259 (103.H)
    /// Type = SHORT
    /// Count = 1
    /// Default = none
    /// 1 = uncompressed
    /// 6 = JPEG compression (thumbnails only)
    /// Other = reserved
    /// </summary>
    public enum CompressionType : short
    {
        /// <summary>
        /// uncompressed
        /// </summary>
        Uncompressed = 1,

        /// <summary>
        /// JPEG compression (thumbnails only)
        /// </summary>
        JPEG = 6
    }
}
