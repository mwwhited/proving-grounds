using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Drawing.Exif
{
    /// <summary>
    /// Light Source
    /// </summary>
    /// <remarks>
    /// LightSource
    /// The kind of light source.
    /// Tag = 37384 (9208.H)
    /// Type = SHORT
    /// Count = 1
    /// Default = 0
    /// 0 = unknown
    /// 1 = Daylight
    /// 2 = Fluorescent
    /// 3 = Tungsten (incandescent light)
    /// 4 = Flash
    /// 9 = Fine weather
    /// 10 = Cloudy weather
    /// 11 = Shade
    /// 12 = Daylight fluorescent (D 5700 – 7100K)
    /// 13 = Day white fluorescent (N 4600 – 5400K)
    /// 14 = Cool white fluorescent (W 3900 – 4500K)
    /// 15 = White fluorescent (WW 3200 – 3700K)
    /// 17 = Standard light A
    /// 18 = Standard light B
    /// 19 = Standard light C
    /// 20 = D55
    /// 21 = D65
    /// 22 = D75
    /// 23 = D50
    /// 24 = ISO studio tungsten
    /// 255 = other light source
    /// Other = reserved
    /// </remarks>
    public enum LightSourceType : short
    {
        /// <remarks />
        Unknown = 0,

        /// <remarks />
        DayLight = 1,

        /// <remarks />
        Fluorescent = 2,

        /// <summary>
        /// Tungsten (incandescent light)
        /// </summary>
        Tungsten = 3,

        /// <remarks />
        Flash = 4,

        /// <remarks />
        FineWeather = 9,

        /// <remarks />
        CloudyWeather = 10,

        /// <remarks />
        Shade = 11,

        /// <summary>
        /// Daylight fluorescent (D 5700 – 7100K)
        /// </summary>
        DayLightFluorescent = 12,

        /// <summary>
        /// Day white fluorescent (N 4600 – 5400K)
        /// </summary>
        DayWhiteFluorescent = 13,

        /// <summary>
        /// Cool white fluorescent (W 3900 – 4500K)
        /// </summary>
        CoolWhiteFluorescent = 14,

        /// <summary>
        /// White fluorescent (WW 3200 – 3700K)
        /// </summary>
        WhiteFluorescent = 15,

        /// <remarks />
        StandardLightA = 17,

        /// <remarks />
        StandardLightB = 18,

        /// <remarks />
        StandardLightC = 19,

        /// <remarks />
        D55 = 20,
        /// <remarks />
        D65 = 21,
        /// <remarks />
        D75 = 22,
        /// <remarks />
        D50 = 23,
        /// <remarks />
        ISOStudioTungsten = 24,

        /// <remarks />
        Other = 255
    }
}
