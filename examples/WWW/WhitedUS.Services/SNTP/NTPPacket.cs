using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Services.SNTP
{
    public class NTPPacket
    {
        //http://www.ietf.org/rfc/rfc1361.txt
        //The format of the NTP data portion, which immediately follows the UDP
        //header, is shown below along with a description of its fields.

        #region Packet Layout
        //                    1                   2                   3
        //0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
        //+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
        //|LI | VN  |Mode |    Stratum    |     Poll      |   Precision   |
        //+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
        //|                          Root Delay                           |
        //+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
        //|                       Root Dispersion                         |
        //+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
        //|                    Reference Identifier                       |
        //+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
        //|                                                               |
        //|                   Reference Timestamp (64)                    |
        //|                                                               |
        //+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
        //|                                                               |
        //|                   Originate Timestamp (64)                    |
        //|                                                               |
        //+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
        //|                                                               |
        //|                    Receive Timestamp (64)                     |
        //|                                                               |
        //+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
        //|                                                               |
        //|                    Transmit Timestamp (64)                    |
        //|                                                               |
        //+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
        #endregion

        #region Constants
        public const byte BITMASK_LI = 0xC0;
        public const byte OFFSET_LI = 6;
        public const byte BITMASK_VERSION = 0x38;
        public const byte OFFSET_VERSION = 3;
        public const byte BITMASK_MODE = 0x07;
        public const byte OFFSET_MODE = 0;
        #endregion

        public NTPPacket() { }

        public static NTPPacket Create(byte[] packet)
        {
            if (packet == null)
                throw new ArgumentNullException("packet");
            if (packet.Length != 48)
                throw new ArgumentOutOfRangeException(
                    "packet is the incorrect length " +
                    "(only 48 byte SNTP is supported at this time)");

            var resultVal = new NTPPacket();

            var workBuffer = new byte[4];

            resultVal.LeapIndicator = (LeapIndicatorTypes)GetByte(packet[0], 
                                                                  BITMASK_LI, 
                                                                  OFFSET_LI);
            resultVal.VersionNumber = GetByte(packet[0], 
                                              BITMASK_VERSION, 
                                              OFFSET_VERSION);
            resultVal.Mode = (NTPModeTypes)GetByte(packet[0], 
                                                   BITMASK_MODE, 
                                                   OFFSET_MODE);

            resultVal.Stratum = packet[1];
            resultVal.PollingInterval = packet[2];
            resultVal.Precision = packet[3];

            Array.Copy(packet, 4, workBuffer, 0, 4);
            if (BitConverter.IsLittleEndian)
                Array.Reverse(workBuffer);
            var work = BitConverter.ToUInt32(workBuffer, 0);
            resultVal.EstimatedError = work;

            Array.Copy(packet, 8, workBuffer, 0, 4);
            if (BitConverter.IsLittleEndian)
                Array.Reverse(workBuffer);
            work = BitConverter.ToUInt32(workBuffer, 0);
            resultVal.EstimatedDriftRate = work;

            var rci = new byte[4];
            Array.Copy(packet, 12, rci, 0, 4);
            resultVal.ReferenceClockIdentifier = rci;

            resultVal.ReferenceTimestamp = GetTimestamp(packet, 16);
            resultVal.OriginateTimestamp = GetTimestamp(packet, 24);
            resultVal.ReceiveTimestamp = GetTimestamp(packet, 32);
            resultVal.TransmitTimestamp = GetTimestamp(packet, 40);

            return resultVal;
        }

        public byte[] ToBinary()
        {
            var outBuffer = new byte[48];

            outBuffer[0] =
                (byte)(((byte)this.LeapIndicator << OFFSET_LI) |
                ((byte)this.VersionNumber << OFFSET_VERSION) |
                ((byte)this.Mode << OFFSET_MODE));

            outBuffer[1] = this.Stratum;
            outBuffer[2] = this.PollingInterval;
            outBuffer[3] = this.Precision;

            var workBuffer = BitConverter.GetBytes(this.EstimatedError);
            if (BitConverter.IsLittleEndian)
                Array.Reverse(workBuffer);
            Array.Copy(workBuffer, 0, outBuffer, 4, 4);

            workBuffer = BitConverter.GetBytes(this.EstimatedDriftRate);
            if (BitConverter.IsLittleEndian)
                Array.Reverse(workBuffer);
            Array.Copy(workBuffer, 0, outBuffer, 8, 4);

            var rci = this.ReferenceClockIdentifier;
            Array.Copy(rci, 0, outBuffer, 12, 4);

            var timeBuffer = GetTimestamp(this.ReferenceTimestamp);
            Array.Copy(timeBuffer, 0, outBuffer, 16, 8);

            timeBuffer = GetTimestamp(this.OriginateTimestamp);
            Array.Copy(timeBuffer, 0, outBuffer, 24, 8);

            timeBuffer = GetTimestamp(this.ReceiveTimestamp);
            Array.Copy(timeBuffer, 0, outBuffer, 32, 8);

            timeBuffer = GetTimestamp(this.TransmitTimestamp);
            Array.Copy(timeBuffer, 0, outBuffer, 40, 8);

            return outBuffer;
        }

        public static byte GetByte(byte input, byte mask, byte offset)
        {
            return (byte)((input & mask) >> offset);
        }

        public static DateTime? GetTimestamp(byte[] packet, int offset)
        {
            var timeStampBuffer = new byte[8];
            Array.Copy(packet, offset, timeStampBuffer, 0, 8);
            if (BitConverter.IsLittleEndian)
                Array.Reverse(timeStampBuffer);
            var fracPart = (BitConverter.ToUInt32(timeStampBuffer, 
                                                  BitConverter.IsLittleEndian 
                                                    ? 0 
                                                    : 4)
                                                ) / 0x418937;
            var intPart = BitConverter.ToUInt32(timeStampBuffer, 
                                                BitConverter.IsLittleEndian 
                                                    ? 4 
                                                    : 0);
            if (fracPart == 0 && intPart == 0) return null;
            return new DateTime(1900, 1, 1)
                                        .AddSeconds(intPart)
                                        .AddMilliseconds(fracPart);
        }

        public static byte[] GetTimestamp(DateTime? dateTime)
        {
            if (!dateTime.HasValue)
                return new byte[8];

            var tSpan = new TimeSpan(dateTime.Value.Ticks)
                    .Subtract(new TimeSpan(new DateTime(1900, 1, 1).Ticks));
            var tSeconds = (ulong)(tSpan.TotalSeconds);
            var tMills = (ulong)(tSpan.Subtract(TimeSpan.FromSeconds(tSeconds))
                                                        .TotalMilliseconds) 
                                                                    * 0x418937;
            var workBuffer = BitConverter.GetBytes(tSeconds << 32 | tMills);

            if (BitConverter.IsLittleEndian)
                Array.Reverse(workBuffer);

            return workBuffer;
        }

        #region Properties

        /// <summary>
        /// Leap Indicator (LI)
        /// </summary>
        /// <remarks>
        ///  Code warning of impending leap-second to be inserted at the end of
        ///  the last day of the current month.
        /// </remarks>
        public LeapIndicatorTypes LeapIndicator { get; set; }

        /// <summary>
        /// Version Number (VN)
        /// </summary>
        /// <remarks>
        /// This is a three-bit integer indicating the NTP version number, 
        /// currently 3.
        /// </remarks>
        public byte VersionNumber { get; set; }

        /// <summary>
        /// Mode
        /// </summary>
        public NTPModeTypes Mode { get; set; }

        /// <summary>
        /// Stratum: This is a eight-bit integer indicating the stratum 
        /// level of the local clock
        /// </summary>
        /// <remarks>
        /// Values defined as follows:
        ///    Stratum  Meaning
        ///    ----------------------------------------------
        ///    0        unspecified or unavailable
        ///    1        primary reference (e.g., radio clock)
        ///    2-15     secondary reference (via NTP or SNTP)
        ///    16-255   reserved
        /// </remarks>
        public byte Stratum { get; set; }

        //PollingInterval
        public byte PollingInterval { get; set; }

        //Precision
        //  Signed integer in the range +32 to -32 indicating the precision of
        //  the local clock, in seconds to the nearest power of two.
        public byte Precision { get; set; }

        //Estimated Error
        //  Fixed-point number indicating the estimated error of the local
        //  clock at the time last set, in seconds with fraction point between
        //  bits 15 and 16.
        public uint EstimatedError { get; set; }

        //Estimated Drift Rate
        //  Signed fixed-point number indicating the estimated drift rate of
        //  the local clock, in dimensionless units with fraction point to the
        //  left of the high-order bit.
        public uint EstimatedDriftRate { get; set; }

        //Reference Clock Identifier
        //  Code identifying the particular reference clock. In the case of
        //  type 1 (primary reference), this is a left-justified, zero-filled
        //  ASCII string identifying the clock, for example:
        //     WWVB    WWVB radio clock (60 KHz)
        //     GOES    GOES satellite clock (468 HMz)
        //     WWV     WWV radio clock (2.5/5/10/15/20 MHz)
        //     (and others as necessary)
        //  In the case of type 2 (secondary reference) this is the 32-bit
        //  Internet address of the reference host. In other cases this field
        //  is reserved for future use and should be set to zero.
        public byte[] ReferenceClockIdentifier
        {
            get { return _referenceClockIdentifier; }
            set
            {
                if (value == null)
                    _referenceClockIdentifier = null;
                else if (value.Length != 4)
                    throw new ArgumentOutOfRangeException(
                        "ReferenceClockIdentifier must be 4 " +
                        "characters in length");
                else
                    _referenceClockIdentifier = value;
            }
        }
        private byte[] _referenceClockIdentifier;

        //Reference Timestamp
        //  Local time at which the local clock was last set or corrected.
        public DateTime? ReferenceTimestamp { get; set; }

        //Originate Timestamp
        //  Local time at which the request departed the client host for the
        //  service host.
        public DateTime? OriginateTimestamp { get; set; }

        //Receive Timestamp
        //  Local time at which the request arrived at the service host.
        public DateTime? ReceiveTimestamp { get; set; }

        //Transmit Timestamp
        //  Local time at which the reply departed the service host for the
        //  client host.
        public DateTime? TransmitTimestamp { get; set; }

        #endregion
    }
}
