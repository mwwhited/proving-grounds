using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Drawing.Exif
{
    /// <summary>
    /// Flash
    /// </summary>
    /// <remarks>
    /// Flash
    /// This tag indicates the status of flash when the image was shot. Bit 0 indicates the flash firing status, bits 1 and 2
    /// indicate the flash return status, bits 3 and 4 indicate the flash mode, bit 5 indicates whether the flash function is
    /// present, and bit 6 indicates "red eye" mode (see Figure 11).
    /// Figure 11 Bit Coding of the Flash Tag
    /// Tag = 37385 (9209.H)
    /// Type = SHORT
    /// Count = 1
    /// Values for bit 0 indicating whether the flash fired.
    /// 0b = Flash did not fire.
    /// 1b = Flash fired.
    /// Values for bits 1 and 2 indicating the status of returned light.
    /// MSB
    /// 7 6 5 4 3 2 1 0
    /// LSB
    /// Flash fired
    /// Flash return
    /// Flash mode
    /// Flash function
    /// Red-eye mode
    /// 00b = No strobe return detection function
    /// 01b = reserved
    /// 10b = Strobe return light not detected.
    /// 11b = Strobe return light detected.
    /// Values for bits 3 and 4 indicating the camera's flash mode.
    /// 00b = unknown
    /// 01b = Compulsory flash firing
    /// 10b = Compulsory flash suppression
    /// 11b = Auto mode
    /// Values for bit 5 indicating the presence of a flash function.
    /// 0b = Flash function present
    /// 1b = No flash function
    /// Values for bit 6 indicating the camera's red-eye mode.
    /// 0b = No red-eye reduction mode or unknown
    /// 1b = Red-eye reduction supported
    /// Resulting Flash tag values.
    /// 0000.H = Flash did not fire.
    /// 0001.H = Flash fired.
    /// 0005.H = Strobe return light not detected.
    /// 0007.H = Strobe return light detected.
    /// 0009.H = Flash fired, compulsory flash mode
    /// 000D.H = Flash fired, compulsory flash mode, return light not detected
    /// 000F.H = Flash fired, compulsory flash mode, return light detected
    /// 0010.H = Flash did not fire, compulsory flash mode
    /// 0018.H = Flash did not fire, auto mode
    /// 0019.H = Flash fired, auto mode
    /// 001D.H = Flash fired, auto mode, return light not detected
    /// 001F.H = Flash fired, auto mode, return light detected
    /// 0020.H = No flash function
    /// 0041.H = Flash fired, red-eye reduction mode
    /// 0045.H = Flash fired, red-eye reduction mode, return light not detected
    /// 0047.H = Flash fired, red-eye reduction mode, return light detected
    /// 0049.H = Flash fired, compulsory flash mode, red-eye reduction mode
    /// 004D.H = Flash fired, compulsory flash mode, red-eye reduction mode, return light not detected
    /// 004F.H = Flash fired, compulsory flash mode, red-eye reduction mode, return light detected
    /// 0059.H = Flash fired, auto mode, red-eye reduction mode
    /// 005D.H = Flash fired, auto mode, return light not detected, red-eye reduction mode
    /// 005F.H = Flash fired, auto mode, return light detected, red-eye reduction mode
    /// Other = reserved
    /// </remarks>
    public class FlashType
    {
        /// <summary>
        /// Values for bit 0 indicating whether the flash fired.
        /// </summary>
        public bool Fired {get;set;}

        /// <summary>
        /// Values for bits 1 and 2 indicating the status of returned light.
        /// </summary>
        public enum FlashReturnType : byte
        {
            /// <summary>
            /// 00b = No strobe return detection function
            /// </summary>
            NoStrobeReturnDetectionFunction = 0,
            /// <summary>
            /// 01b = reserved
            /// </summary>
            Reserved = 1,
            /// <summary>
            /// 10b = Strobe return light not detected.
            /// </summary>
            StrobeReturnLightNotDetected = 2,
            /// <summary>
            /// 11b = Strobe return light detected.
            /// </summary>
            StrobeReturnLightDetected = 3
        }

        /// <summary>
        /// Values for bits 1 and 2 indicating the status of returned light.
        /// </summary>
        public FlashReturnType Return { get; set; }

        /// <summary>
        /// Values for bits 3 and 4 indicating the camera's flash mode.
        /// </summary>
        public enum FlashModeType : byte
        {
            /// <summary>
            /// 00b = unknown
            /// </summary>
            Unknown = 0,

            /// <summary>
            /// 01b = Compulsory flash firing
            /// </summary>
            CompulsoryFiring = 1,

            /// <summary>
            /// 10b = Compulsory flash suppression
            /// </summary>
            CompulsorySuppression = 2,

            /// <summary>
            /// 11b = Auto mode 
            /// </summary>
            Auto = 3  
        }

        /// <summary>
        /// Values for bits 3 and 4 indicating the camera's flash mode.
        /// </summary>
        public FlashModeType Mode { get; set; }

        /// <summary>
        /// Values for bit 5 indicating the presence of a flash function.
        /// </summary>
        public bool Function { get; set; }

        /// <summary>
        /// Values for bit 6 indicating the camera's red-eye mode.
        /// </summary>
        /// <remarks>
        /// 0b = No red-eye reduction mode or unknown
        /// 1b = Red-eye reduction supported
        /// </remarks>
        public bool RedEyeReductionSupport { get; set; }

        public override string ToString()
        {
            return string.Format(
                "\r\n\tFired: {0}\r\n\tReturn: {1}\r\n\tMode: {2}\r\n\tFunction: {3}\r\n\tRedEye: {4}",
                Fired,
                Return,
                Mode,
                Function,
                RedEyeReductionSupport
                );
        }

        public static implicit operator FlashType(short value)
        {
            FlashType flashType = new FlashType();
            flashType.Fired = ((value & 1) == 1);
            flashType.Return = (FlashReturnType)((value & 6) >> 1);
            flashType.Mode = (FlashModeType)((value & 24) >> 3);
            flashType.Function = ((value & 32) == 32);
            flashType.RedEyeReductionSupport = ((value & 64) == 64);

            return flashType;
        }

        public static implicit operator FlashType(int value)
        {
            return (short)value;
        }

    }
}
