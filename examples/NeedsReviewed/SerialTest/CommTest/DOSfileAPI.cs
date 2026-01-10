using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CommTest
{
    public static class DOSfileAPI
    {
        /* CONSTANTS */
        public const int DOS_ERROR_RANGE_MAX = 0xDF;    /* highest allowable error number */
        public const int DOS_HOST_ERROR_TIMEOUT = DOSprotocol.DOS_HANDSHAKE_OFF;  /* host-side error if DOSonCHIP does fails to respond */
        public const int DOS_HOST_READ_NOT_COMPLETE = 0xD0;
        public const int DOS_HOST_WRITE_NOT_COMPLETE = 0xD1;
        public const int DOS_HOST_COMMUNICATION_ERROR = 0xD2;

        /* DATA STRUCTURES */
        /* Time & Date Structure */
        public struct DOStime
        {
            public byte second; /* seconds after the minute: [0,59]  */
            public byte minute; /* minutes after the hour:   [0,59]  */
            public byte hour;   /* hours since midnight:     [0,23]  */
            public byte day;    /* day of the month:         [1,31]  */
            public byte month;  /* months since January:     [1,12]  */
            public byte year;   /* years since 1980:         [0,58]  */
        };

        /* GLOBAL VARIABLES */
        /* The folowing buffer holds command/response header + payload to/from the DOSonCHIP IC. */
        public static byte[] DOScommandResponse = new byte[DOSprotocol.DOS_PACKET_LENGTH_HEADER + DOSprotocol.DOS_PACKET_LENGTH_PAYLOAD_CMDRES];

        /* The following variables are used to minimize commands sent to DOSonCHIP IC by mirroring last value sent */
        public static byte DOSpacketPayloadLengthName = DOSprotocol.DOS_PACKET_LENGTH_PAYLOAD_NAME; /* current DATA_NAME packet payload length */
        public static uint DOSpacketPayloadLengthBlock = DOSprotocol.DOS_PACKET_LENGTH_PAYLOAD_MAX;  /* current DATA_BLOCK packet payload length */
        public static byte DOScurrentHandle = 0;                              /* current handle */

        /******************************************************************************/
        /**
           Converts the binary date & time to a usable data structure.

           \param[in]  binaryDateTime 32-bit date & time value retrieved from DOSonCHIP.

           \param[out] dateTime       Pointer to a structure containing the date & time
                                      (based upon DOStime_Struct in DOSfileAPI.h).
        */
        /******************************************************************************/
        /* The array represents the number of days in one non-leap year at the beginning of each month */
        public static readonly ushort[] DAYS_TO_MONTH = new ushort[13] { 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365 };

        public static void DOSdateTimeConvert(ulong binaryDateTime, out DOStime dateTime)
        {
            ulong wholeMinutes;
            ulong wholeHours;
            ulong wholeDays;
            ulong wholeDaysSince1968;
            byte leapYearPeriods;
            ushort daysSinceCurrentLeapYear;
            byte wholeYears;
            ushort daysSinceFirstOfYear;     /* days since January 1: [0,365] */
            ushort daysToMonth;
            /* byte dayOfWeek; */
            /* days since Sunday: [0,6] */

            wholeMinutes = binaryDateTime / 60;
            dateTime.second = (byte)(binaryDateTime - (60 * wholeMinutes)); /* leftover seconds */

            wholeHours = wholeMinutes / 60;
            dateTime.minute = (byte)(wholeMinutes - (60 * wholeHours)); /* leftover minutes */

            wholeDays = wholeHours / 24;
            dateTime.hour = (byte)(wholeHours - (24 * wholeDays));    /* leftover hours */

            wholeDaysSince1968 = wholeDays + 365 + 366;
            leapYearPeriods = (byte)(wholeDaysSince1968 / ((4 * 365) + 1));

            daysSinceCurrentLeapYear = (byte)(wholeDaysSince1968 % ((4 * 365) + 1));

            /* if days are after a current leap year then add a leap year period */
            if ((daysSinceCurrentLeapYear >= (31 + 29))) leapYearPeriods++;

            wholeYears = (byte)((wholeDaysSince1968 - leapYearPeriods) / 365);
            daysSinceFirstOfYear = (byte)(wholeDaysSince1968 - (ulong)(wholeYears * 365) - leapYearPeriods);

            if ((daysSinceCurrentLeapYear <= 365) && (daysSinceCurrentLeapYear >= 60)) daysSinceFirstOfYear++;
            dateTime.year = (byte)(wholeYears + 68 /* adjust for DOS epoch */ - 80);

            /* search for what month it is based on how many days have past within the current year */
            dateTime.month = 13;
            daysToMonth = 366;
            while (daysSinceFirstOfYear < daysToMonth)
            {
                dateTime.month--;
                daysToMonth = DAYS_TO_MONTH[dateTime.month];
                if ((dateTime.month >= 2) && ((dateTime.year % 4) == 0)) daysToMonth++;
            }
            dateTime.month++;
            dateTime.day = (byte)(daysSinceFirstOfYear - daysToMonth + 1);

            /* dayOfWeek = (wholeDays  + 4) % 7; */
        }

        /*******************************************************************************/
        /**
           Set's the current file/directory name for subsequent operations.

           \param[in] name    Pointer to a buffer containing the file/directory name.
                              This must be a null-terminated string.
                              The string length must not exceed DOS_PACKET_LENGTH_PAYLOAD_NAME.
                              File/directory name must be in FAT 8.3 format.

           \return    byte

           \retval    0       If the name was accepted by the DOSonCHIP IC
                              & no errors were encountered.

           \retval    error # If an error occurred (see DOSprotocol.h).

           \remark    This command sets the current name for subsequent file or
                      directory commands. It is retained by the DOSonCHIP IC until
                      it is changed or until a reset or power-down condition occurs.

           \remark    This function does not need to be directly called
                      as it is called by other functions.
        */
        /*******************************************************************************/
        public static byte DOSsetName(byte[] name)
        {
            byte len;

            /* Set current name */
            /* (1 of 2) Set length */
            len = 1; // strlen(name); /* get byte length (must be < 256 bytes AND < DOS_PACKET_LENGTH_PAYLOAD_NAME) */

            if (len != DOSpacketPayloadLengthName)
            {
                DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 0] = 0;
                DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 1] = 0;
                DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 2] = 0;
                DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 3] = len;
                if (DOSpacket.DOSpacketPut(DOSprotocol.DOS_CMD_SET_NAME_LEN, null) != 0) return (DOScommandResponse[0]);
                if (DOSpacket.DOSpacketGet(null) != DOSprotocol.DOS_RES_NOERROR) return (DOScommandResponse[0]);
                DOSpacketPayloadLengthName = len; /* keep last name length sent to DOSonCHIP IC */
            }

            /* (2 of 2) Send name string */
            if (DOSpacket.DOSpacketPut(DOSprotocol.DOS_CMD_SET_NAME, null) != 0) return (DOScommandResponse[0]);
            if (DOSpacket.DOSpacketPut(DOSprotocol.DOS_DATA_NAME, name) != 0) return (DOScommandResponse[0]);
            if (DOSpacket.DOSpacketGet(null) != DOSprotocol.DOS_RES_NOERROR) return (DOScommandResponse[0]);

            return 0; /* no error */
        }

        /*******************************************************************************/
        /**
           Get the current file/directory name for subsequent operations.

           \param[out] name    Pointer to a buffer that will contain the file/directory name.
                               The maximum name size returned will be DOS_PACKET_LENGTH_PAYLOAD_NAME + 1.
                               The string will be null-terminated.

           \return     byte

           \retval     0       If the name was successfully received from the DOSonCHIP IC
                               & no errors were encountered.

           \retval     error # If an error occurred (see DOSprotocol.h).

           \remark     This command retrieves the current name for subsequent file or
                       directory commands. It is retained by the DOSonCHIP IC until
                       it is changed or until a reset or power-down condition occurs.
        */
        /*******************************************************************************/
        public static byte DOSgetName(byte[] name)
        {
            /* Send command */
            if (DOSpacket.DOSpacketPut(DOSprotocol.DOS_CMD_GET_NAME, null) != 0) return (DOScommandResponse[0]);

            /* Get name string length */
            if (DOSpacket.DOSpacketGetResponse() != DOSprotocol.DOS_CMD_SET_NAME_LEN) return (DOSprotocol.DOS_RES_INVALID_PACKET_TYPE);
            DOSpacketPayloadLengthName = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 3]; /* keep last name length sent to DOSonCHIP IC */
            name[DOSpacketPayloadLengthName] = 0; /* null-terminate string */

            /* Get name string */
            if (DOSpacket.DOSpacketGet(name) != DOSprotocol.DOS_DATA_NAME) return (DOScommandResponse[0]);
            if (DOSpacket.DOSpacketGetResponse() != DOSprotocol.DOS_RES_NOERROR) return (DOScommandResponse[0]);

            return 0; /* no error */
        }


        /*******************************************************************************/
        /**
           Sets the handle number for subsequent operations.

           \param[in]  handle  Handle number byte.

           \return     byte

           \retval     0       If the name was accepted by the DOSonCHIP IC
                               & no errors were encountered.

           \retval     error # If an error occurred (see DOSprotocol.h).

           \remark     This command sets the current handle for subsequent file
                       commands. It is retained by the DOSonCHIP IC until
                       it is changed or until a reset or power-down condition occurs.

           \remark     This function does not need to be directly called
                       as it is called by other functions.
        */
        /*******************************************************************************/
        public static byte DOSsetHandle(byte handle)
        {
            byte response;

            /* Set handle */
            if (handle != DOScurrentHandle)
            {
                DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 0] = 0;
                DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 1] = 0;
                DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 2] = 0;
                DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 3] = handle;
                if ((response = DOSpacket.DOSpacketPut(DOSprotocol.DOS_CMD_SET_HANDLE, DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != 0) return (response);
                if ((response = DOSpacket.DOSpacketGet(DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != DOSprotocol.DOS_RES_NOERROR) return (response);
                DOScurrentHandle = handle; /* keep last handle sent to DOSonCHIP IC */
            }

            return 0; /* no error */
        }


        /*******************************************************************************/
        /**
           Initialize the memory card and mounts the DOS volume.
           Retrieves memory card's unique volume ID.
           The unique volume ID is used to determine if the card DOS volume
           is the same as the previously mounted volume.

           \param[in]  freeAllocateSize 32-bit value indicating the maximum number of
                                        sectors DOSonCHIP should allocate to the free
                                        pool for writing to the card at a later time
                                        (note 1 sector = 512 bytes).
                                        The larger the number, the longer amount of time
                                        to complete this function.
                                        A zero value can be used, which will skip the 
                                        free chain build during mount for quick mounting
                                        of the card. The free space allocation will
                                        occur at the first writing to the card (creating a
                                        new file, writing to an existing file, or creating
                                        a new directory), so there is no escaping some delay
                                        at some point.
                                        Setting to a value beyond the size of the card will
                                        allocate the maximum available.
                                        If one is unsure how to use this value, either use
                                        a 0 value (delay later) or use the maximum
                                        0xFFFFFFFF (delay now) value.
                                        If one knows the total amount of writing to be done
                                        then this is the amount to set to minimize mount
                                        time while preventing later delays because of an
                                        empty free sector pool.

           \param[out] volumeID Pointer to a buffer containing the unique ID number. 

           \return     byte

           \retval     0        If the directory was properly changed
                                & no errors were encountered.

           \retval     error #  If an error occurred (see DOSprotocol.h).

           \remark     The unique ID is generated when the card is formatted.
                       It is used to verify that the card has not been exchanged.

           \remark     When using a large freeAllocateSize value, slow, large capacity,
                       and heavily fragmented cards will take longer to complete this function.
        */
        /*******************************************************************************/
        public static byte DOSmount(ulong freeAllocateSize, uint volumeID)
        {
            byte response;

            /* Mount card */
            Array.Copy(BitConverter.GetBytes(freeAllocateSize), 0, DOScommandResponse, DOSprotocol.DOS_PACKET_LENGTH_HEADER, 4);
            //DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 0] = WORDHIGH_BYTEHIGH(freeAllocateSize);
            //DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 1] = WORDHIGH_BYTELOW  (freeAllocateSize);
            //DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 2] = WORDLOW_BYTEHIGH  (freeAllocateSize);
            //DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 3] = WORDLOW_BYTELOW   (freeAllocateSize);
            if ((response = DOSpacket.DOSpacketPut(DOSprotocol.DOS_CMD_MOUNT, DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != 0) return (response);
            if ((response = DOSpacket.DOSpacketGet(DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != DOSprotocol.DOS_RES_NOERROR) return (response);

            /* Return card volume ID */
            volumeID = BitConverter.ToUInt32(DOScommandResponse, DOSprotocol.DOS_PACKET_LENGTH_HEADER);
            //WORDHIGH_BYTEHIGH (volumeID) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 0]; /* set to proper endian order */
            //WORDHIGH_BYTELOW  (volumeID) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 1];
            //WORDLOW_BYTEHIGH  (volumeID) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 2];
            //WORDLOW_BYTELOW   (volumeID) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 3];

            return 0; /* no error */
        }


        /*******************************************************************************/
        /**
           Changes the current directory location.
           Analogous to the 'cd' command in DOS.

           \param[in]  directory Pointer to a buffer containing the directory name
                                 to change to. This must be a null-terminated string. 

           \return     byte

           \retval     0         If the directory was properly changed
                                 & no errors were encountered.

           \retval     error #   If an error occurred (see DOSprotocol.h).

           \remark     This function may only be called after DOSmount() has been
                       successfully executed.
                       
           \remark     The directory name must contain a single directory name
                       that is found in the current directory listing,
                       i.e., it cannot contain a nested directory string,
                       e.g., NEWDIR is valid, TEMP\NEWDIR is not.
                       
           \remark     "\"  (jump to root directory) is supported.
                       ".." (go to parent directory) is supported.
                       "."  (stay in same directory) is supported.

           \remark   <b>KNOWN ISSUE: Currently "\", "..", & "." return an error.</b>
        */
        /*******************************************************************************/
        public static byte DOSchangeDirectory(byte[] directory)
        {
            byte response;

            /* Set directory name */
            if ((response = DOSsetName(directory)) != 0) return (response);

            /* Set directory */
            if ((response = DOSpacket.DOSpacketPut(DOSprotocol.DOS_CMD_SET_DIR, 0)) != 0) return (response);
            if ((response = DOSpacket.DOSpacketGet(DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != DOSprotocol.DOS_RES_NOERROR) return (response);

            return 0; /* no error */
        }


        /*******************************************************************************/
        /**
           Creates a new directory in the current directory location.
           Analogous to the 'md' command in DOS.

           \param[in]  directory Pointer to a buffer containing the directory name
                                 to change to. This must be a null-terminated string. 

           \return     byte

           \retval     0         If the directory was properly changed
                                 & no errors were encountered.
           \retval     Error #   If an error occurred (see DOSprotocol.h).

           \remark     This function may only be called after DOSmount() has been
                       successfully executed.
           \remark     Single-level creation is the only type supported. That is,
                       new directories may only be created in the current directory,
                       not in any lower or upper level ones relative to the current
                       directory.

                       For example, if the current directory is '\\TEMP\\APPLICATION',
                       then

                       \code DOSmakeDirectory("NEWDIR"); \endcode

                       is valid, but

                       \code DOSmakeDirectory("\\TEMP\\NEWDIR"); \endcode

                       is not.
        */
        /*******************************************************************************/
        public static byte DOSmakeDirectory(ref byte[] directory)
        {
            byte response;

            /* Set directory name */
            if ((response = DOSsetName(directory)) != 0) return (response);

            /* Create directory */
            if ((response = DOSpacket.DOSpacketPut(DOSprotocol.DOS_CMD_MAKE_DIR, 0)) != 0) return (response);
            if ((response = DOSpacket.DOSpacketGet(DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != DOSprotocol.DOS_RES_NOERROR) return (response);

            return 0; /* no error */
        }


        /*******************************************************************************/
        /**
           Retrieves a single directory entry from the current directory.
           This entry becomes the current file/directory name for subsequent operations
           (it has a similar effect as DOSsetName).

           \param[in]  mode      Byte indicating the traversal mode.
                                 The following values are supported:
                             \li DOS_FIRST : Point to first valid directory entry.
                             \li DOS_NEXT  : Point to next directory entry.

           \param[out] attribute Byte containing the FAT attributes of the retrieved directory entry.

           \return     byte

           \retval     0         If the directory entry was properly retrieved
                                 & no errors were encountered.

           \retval     error #   If an error occurred (see DOSprotocol.h).

           \remark     This function may only be called after DOSmount() has been
                       successfully executed.

           \remark     Subsequent operations will apply to this entry until it is changed.
                       For example, a following DOSchangeDirectory function call will
                       apply to the entry retrieved by this command (check the attribute
                       byte or an error will occur). Similarly, a DOSgetName function call
                       will get the name of the entry retrieved by this command.
        */
        /*******************************************************************************/
        public static byte DOSlistDirectory(byte mode, ref byte attribute)
        {
            byte response;

            /* DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 0] = 0; */
            /* don't care values */
            /* DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 1] = 0; */
            /* DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 2] = 0; */
            DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 3] = mode;
            if ((response = DOSpacket.DOSpacketPut(DOSprotocol.DOS_CMD_DIR, DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != 0) return (response);
            if ((response = DOSpacket.DOSpacketGet(DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != DOSprotocol.DOS_RES_NOERROR) return (response);
            attribute = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 3]; /* directory entry attribute byte */

            return 0; /* no error */
        }


        /*******************************************************************************/
        /**
           Retrieves the last modified time stamp of the current directory entry.

           \param[in]  mode      Byte indicating which date/time property should be retrieved.
                                 The following values are supported:
                             \li DOS_PROPERTY_TIME_CREATED  : Retrieve date/time directory entry was created.
                             \li DOS_PROPERTY_TIME_MODIFIED : Retrieve date/time directory entry was last modified.

           \param[out] dateTime  Pointer to a structure containing the date/time stamp
                                 when the current directory entry was last modified.

           \return     byte

           \retval     0         If the date/time stamp was properly retrieved
                                 & no errors were encountered.

           \retval     error #   If an error occurred (see DOSprotocol.h).
        */
        /*******************************************************************************/
        public static byte DOSgetPropertyTime(byte mode, out DOStime dateTime)
        {
            dateTime = default(DOStime);
            byte response;
            uint binaryTime;

            /* DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 0] = 0; */
            /* don't care values */
            /* DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 1] = 0; */
            /* DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 2] = 0; */
            DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 3] = mode;
            if ((response = DOSpacket.DOSpacketPut(DOSprotocol.DOS_CMD_DIR_GET_PROPERTY, DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != 0) return (response);
            if ((response = DOSpacket.DOSpacketGet(DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != DOSprotocol.DOS_RES_NOERROR) return (response);

            binaryTime = BitConverter.ToUInt32(DOScommandResponse, DOSprotocol.DOS_PACKET_LENGTH_HEADER);
            //WORDHIGH_BYTEHIGH(binaryTime) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 0]; /* set to proper endian order */
            //WORDHIGH_BYTELOW (binaryTime) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 1];
            //WORDLOW_BYTEHIGH (binaryTime) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 2];
            //WORDLOW_BYTELOW  (binaryTime) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 3];

            DOSdateTimeConvert(binaryTime, out dateTime); /* convert 32-bit time/date to usable data structure */

            return 0; /* no error */
        }


        /*******************************************************************************/
        /**
           Retrieves the file size of the current directory entry.

           \param[out] size     Pointer to the 32-bit file size.

           \return     byte

           \retval     0        If the date/time stamp was properly retrieved
                                & no errors were encountered.

           \retval     error #  If an error occurred (see DOSprotocol.h).

           \remark     The returned size value is only valid for files.
                       It is not valid for directories.
        */
        /*******************************************************************************/
        public static byte DOSgetPropertySize(out uint size)
        {
            byte response;
            size = 0;

            /* DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 0] = 0; */
            /* don't care values */
            /* DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 1] = 0; */
            /* DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 2] = 0; */
            DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 3] = DOSprotocol.DOS_PROPERTY_SIZE;
            if ((response = DOSpacket.DOSpacketPut(DOSprotocol.DOS_CMD_DIR_GET_PROPERTY, DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != 0) return (response);
            if ((response = DOSpacket.DOSpacketGet(DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != DOSprotocol.DOS_RES_NOERROR) return (response);

            size = BitConverter.ToUInt32(DOScommandResponse, DOSprotocol.DOS_PACKET_LENGTH_HEADER);
            //WORDHIGH_BYTEHIGH(size) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 0]; /* set to proper endian order */
            //WORDHIGH_BYTELOW(size) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 1];
            //WORDLOW_BYTEHIGH(size) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 2];
            //WORDLOW_BYTELOW(size) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 3];

            return 0; /* no error */
        }


        /*******************************************************************************/
        /**
           Retrieves the number of used sectors on the current card.

           \param[out] size     Pointer to the number of unused sectors on the card.
                                Each sector is 512 bytes.

           \return     byte

           \retval     0        If the date/time stamp was properly retrieved
                                & no errors were encountered.

           \retval     error #  If an error occurred (see DOSprotocol.h).
        */
        /*******************************************************************************/
        public static byte DOSgetFreeSectorCount(out uint freeSectors)
        {
            byte response;
            freeSectors = 0;

            if ((response = DOSpacket.DOSpacketPut(DOSprotocol.DOS_CMD_GET_FREE_SECTORS, DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != 0) return (response);
            if ((response = DOSpacket.DOSpacketGet(DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != DOSprotocol.DOS_RES_NOERROR) return (response);

            freeSectors = BitConverter.ToUInt32(DOScommandResponse, DOSprotocol.DOS_PACKET_LENGTH_HEADER);

            //WORDHIGH_BYTEHIGH(freeSectors) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 0]; /* set to proper endian order */
            //WORDHIGH_BYTELOW(freeSectors) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 1];
            //WORDLOW_BYTEHIGH(freeSectors) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 2];
            //WORDLOW_BYTELOW(freeSectors) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 3];

            return 0; /* no error */
        }


        /*******************************************************************************/
        /**
           Opens or creates a file in the current directory. Files may be opened
           for reading or writing, but not both. 

           \param[in]  fileName Buffer containing the name of the file to open. 
                                Must be null-terminated string.

           \param[in]  mode     Byte indicating the open mode. The following values are
                                supported:
                            \li DOS_CMD_OPEN_READ  : Read mode
                            \li DOS_CMD_OPEN_WRITE : Write mode

           \param[in]  handle   A file handle to be used for all subsequent 
                                operations on this file.

           \param[out] numBytes The size of the file in bytes.

           \return     byte

           \retval     0        If the directory was properly changed
                                & no errors were encountered.

           \retval     error #  If an error occurred (see DOSprotocol.h).

           \remark     This function may only be called after DOSmount() has been
                       successfully executed.

           \remark     If the file is opened in Read mode, then the file pointer is 
                       initially set to the beginning of the file.

           \remark     If the file is opened in the Write mode and the indicated file
                       does not exist, then the file is created.

           \remark     If the file is opened in Write mode, then the file pointer is
                       set to the end of the file.
        */
        /*******************************************************************************/
        public static byte DOSopen(byte mode, byte[] fileName, byte handle, out int numBytes)
        {
            byte response;
            numBytes = 0;

            /* Set file name */
            if ((response = DOSsetName(fileName)) != 0) return (response);

            /* Set handle */
            if ((response = DOSsetHandle(handle)) != 0) return (response);

            /* Open file */
            DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 0] = 0; /* seek to beginning of file (read mode) */
            DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 1] = 0;
            DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 2] = 0;
            DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 3] = 0;
            if ((response = DOSpacket.DOSpacketPut(mode, DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != 0) return (response);
            if ((response = DOSpacket.DOSpacketGet(DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != DOSprotocol.DOS_RES_NOERROR) return (response);

            /* Return the file size */
            numBytes = BitConverter.ToInt32(DOScommandResponse, DOSprotocol.DOS_PACKET_LENGTH_HEADER);
            //WORDHIGH_BYTEHIGH(*numBytes) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 0]; /* set to proper endian order */
            //WORDHIGH_BYTELOW (*numBytes) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 1];
            //WORDLOW_BYTEHIGH (*numBytes) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 2];
            //WORDLOW_BYTELOW  (*numBytes) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 3];

            return 0; /* no error */
        }


        /*******************************************************************************/
        /**
           Allocate the specified number of bytes for the current handle
           at its current seek position. This optional command reduces
           the beginning overhead time when DOS_CMD_WRITE_DATA needs to
           allocate a new cluster.

           \param[out] handle   The file handle to apply this operation.
           
           \param[in]  numBytes The number of bytes to add to the file
                                starting from the current seek position.

           \param[out] fileSize The new size of the file with the added, preallocated
                                bytes.

           \return     byte

           \retval     0        If the directory was properly changed
                                & no errors were encountered.

           \retval     error #  If an error occurred (see DOSprotocol.h).

           \remark     The file length and date & time stamp are updated.

           \remark     If there is not enough card free space to allocate the specified
                       number of bytes (numBytes), then the file size will be increased
                       to the remaining card free space and the DOS_RES_CARD_FULL error
                       will be returned. The fileSize return value will be valid.

           \remark     If many DOS_CMD_WRITE_DATA commands will subsequently occur, then
                       executing this command will reduce the overhead for each
                       DOS_CMD_WRITE_DATA command (as long as the DOS_CMD_WRITE_DATA
                       command does not go past the pre-allocated bytes). With this
                       command the total delay to allocate additional bytes for the file
                       will be incurred at this point rather than distributed among each
                       DOS_CMD_WRITE_DATA command.
        */
        /*******************************************************************************/
        public static byte DOSwritePreallocate(byte handle, uint numBytes, out int fileSize)
        {
            byte response;
            fileSize = 0;

            /* Set handle */
            if ((response = DOSsetHandle(handle)) != 0) return (response);

            /* Send the number of bytes to preallocate/append to the file */
            Array.Copy(BitConverter.GetBytes(numBytes), 0, DOScommandResponse, DOSprotocol.DOS_PACKET_LENGTH_HEADER, 4);
            //DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 0] = WORDHIGH_BYTEHIGH(numBytes); /* set to proper endian order */
            //DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 1] = WORDHIGH_BYTELOW(numBytes);
            //DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 2] = WORDLOW_BYTEHIGH(numBytes);
            //DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 3] = WORDLOW_BYTELOW(numBytes);
            if ((response = DOSpacket.DOSpacketPut(DOSprotocol.DOS_CMD_WRITE_PREALLOCATE, DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != 0) return (response);
            if ((response = DOSpacket.DOSpacketGet(DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != DOSprotocol.DOS_RES_NOERROR) return (response);

            /* Return the new file size */
            fileSize = BitConverter.ToInt32(DOScommandResponse, DOSprotocol.DOS_PACKET_LENGTH_HEADER);
            //WORDHIGH_BYTEHIGH(*fileSize) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 0]; /* set to proper endian order */
            //WORDHIGH_BYTELOW (*fileSize) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 1];
            //WORDLOW_BYTEHIGH (*fileSize) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 2];
            //WORDLOW_BYTELOW  (*fileSize) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 3];

            return 0; /* no error */
        }


        /******************************************************************************/
        /**
           Closes an open file. The file handle representing the open file is
           freed.

           \param[in]  handle File handle of file to be closed.
        */
        /******************************************************************************/
        public static byte DOSclose(byte handle)
        {
            byte response;

            /* Set handle */
            if ((response = DOSsetHandle(handle)) != 0) return (response);

            if ((response = DOSpacket.DOSpacketPut(DOSprotocol.DOS_CMD_CLOSE, DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != 0) return (response);
            if ((response = DOSpacket.DOSpacketGet(DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != DOSprotocol.DOS_RES_NOERROR) return (response);

            return 0; /* no error */
        }


        /*******************************************************************************/
        /**
           Moves the data pointer within an open file. 

           \param[in] handle   File handle of file in which the data pointer is
                               to be moved.

           \param[in] numBytes The number of bytes forward to move the data 
                               pointer. Backward seeking is not supported. This
                               must be a positive number.

           \return    byte

           \retval    0        If the data pointer in the file was moved successfully and 
                               no errors were encountered.

           \retval    error #  If an error occurred (see DOSprotocol.h).

           \remark    This function may only be called after DOSopen ()
                      has been successfully called.

           \remark    Backward seeking is not supported.

           \remark    Attempting to seek beyond the end of file results in the
                      data pointer being set to the end of the file.
        */
        /*******************************************************************************/
        public static byte DOSseek(byte handle, uint numBytes)
        {
            byte response;

            /* Set handle */
            if ((response = DOSsetHandle(handle)) != 0) return (response);

            /* Send seek command */
            Array.Copy(BitConverter.GetBytes(numBytes), 0, DOScommandResponse, DOSprotocol.DOS_PACKET_LENGTH_HEADER, 4);
            //DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 0] = WORDHIGH_BYTEHIGH(numBytes); /* set to proper endian order */
            //DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 1] = WORDHIGH_BYTELOW (numBytes);   
            //DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 2] = WORDLOW_BYTEHIGH (numBytes);
            //DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 3] = WORDLOW_BYTELOW  (numBytes);
            if ((response = DOSpacket.DOSpacketPut(DOSprotocol.DOS_CMD_SEEK, DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != 0) return (response);
            if ((response = DOSpacket.DOSpacketGet(DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != DOSprotocol.DOS_RES_NOERROR) return (response);

            return 0; /* no error */
        }


        /******************************************************************************/
        /**
           Reads data from an open file. Reading starts at the current data
           pointer location.

           \param[in]  handle   File handle of file to be read.

           \param[out] buffer   Pointer to a buffer of at least numBytes length
                                into which the read data will be placed.

           \param[in]  numBytes The number of bytes to read.

           \return     byte

           \retval     0        If the data was read from the file successfully
                                and no errors were encountered.

           \retval     error #  If an error occurred (see DOSprotocol.h).

           \remark     This function may only be called after DOSopen ()
                       has been successfully called and the file to read
                       must have been opened using DOS_CMD_OPEN_READ.
           \remark     Attempting to read beyond the end of file results in all 
                       data prior to the end of file being read, and the data pointer
                       being left at the end of file location.
        */
        /******************************************************************************/
        public static byte DOSread(byte handle,
                               byte[] buffer,
                               uint numBytes) /* read data from file into buffer */
        {
            byte response;
            byte err;

            /* Set handle */
            if ((response = DOSsetHandle(handle)) != 0) return (response);

            /* Send read command */
            Array.Copy(BitConverter.GetBytes(numBytes), 0, DOScommandResponse, DOSprotocol.DOS_PACKET_LENGTH_HEADER, 4);
            //DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 0] = WORDHIGH_BYTEHIGH(numBytes); /* set to proper endian order */
            //DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 1] = WORDHIGH_BYTELOW(numBytes);
            //DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 2] = WORDLOW_BYTEHIGH(numBytes);
            //DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 3] = WORDLOW_BYTELOW(numBytes);
            if ((err = DOSpacket.DOSpacketPut(DOSprotocol.DOS_CMD_READ_DATA, DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != 0) return (err);

            var tempBuffer = new byte[DOSpacketPayloadLengthBlock];

            do
            {
                if (numBytes > 0)
                    response = DOSpacket.DOSpacketGet(buffer); /* utilizes unused "buffer" memory for payload */
                else
                    response = DOSpacket.DOSpacketGetResponse(); /* prevent overrunning end-of-buffer for block end packet */

                switch (response)
                {
                    case DOSprotocol.DOS_CMD_SET_BLOCK_LEN:
                        DOSpacketPayloadLengthBlock = BitConverter.ToUInt16(DOScommandResponse, DOSprotocol.DOS_PACKET_LENGTH_HEADER + 2);
                        //BYTEHIGH(DOSpacketPayloadLengthBlock) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 2]; /* update global parameter if no error */
                        //BYTELOW(DOSpacketPayloadLengthBlock) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 3];
                        if ((err = DOSpacket.DOSpacketPut(DOSprotocol.DOS_HANDSHAKE_PAK_NEXT, 0)) != 0) return (err); /* parameter is don't care */
                        break;
                    case DOSprotocol.DOS_DATA_BLOCK:
                        Array.Copy(buffer, numBytes, tempBuffer, 0, DOSpacketPayloadLengthBlock);
                        //buffer += DOSpacketPayloadLengthBlock; /* point to next free memory location */
                        if ((err = DOSpacket.DOSpacketPut(DOSprotocol.DOS_HANDSHAKE_PAK_NEXT, 0)) != 0) return (err); /* parameter is don't care */
                        numBytes -= DOSpacketPayloadLengthBlock; /* keep track of number of bytes received */
                        break;
                    case DOSprotocol.DOS_DATA_BLOCK_END:
                        if (numBytes == 0) return (0); /* no error */
                        else return (DOS_HOST_READ_NOT_COMPLETE); /* did not complete reading the specified number of bytes */
                        break;
                    default:
                        if ((response > DOSprotocol.DOS_RES_NOERROR) && (response <= DOS_ERROR_RANGE_MAX)) return (response);
                        return (DOSprotocol.DOS_RES_INVALID_PACKET_TYPE); /* packet number is out of range */
                        break;
                }
            } while (true); /* loop exit is within switch */
        }


        /******************************************************************************/
        /**
           Writes data to an open file. Writing starts at the current data
           pointer location.

           \param[in]  handle   File handle of file to write to.

           \param[out] buffer   Pointer to a buffer of at least numBytes length
                                from which the data to be written will be retrieved 
                                from.

           \param[in]  numBytes The number of bytes to write.

           \return     byte

           \retval     0        If the data was written to the file successfully and 
                                no errors were encountered.

           \retval     error    If an error occurred (see DOSprotocol.h).

           \remark     This function may only be called after DOSopen ()
                       has been successfully called and the file to write
                       must have been opened using DOS_CMD_OPEN_WRITE.
        */
        /******************************************************************************/
        public static byte DOSwrite(byte handle, byte[] buffer, out uint numBytes)
        {
            byte response;
            byte err;
            numBytes = 0;

            /* Set handle */
            if ((response = DOSsetHandle(handle)) != 0) return (response);

            /* Send write command */
            Array.Copy(BitConverter.GetBytes(numBytes), 0, DOScommandResponse, DOSprotocol.DOS_PACKET_LENGTH_HEADER, 4);
            //DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 0] = WORDHIGH_BYTEHIGH(numBytes); /* set to proper endian order */
            //DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 1] = WORDHIGH_BYTELOW (numBytes);   
            //DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 2] = WORDLOW_BYTEHIGH (numBytes);
            //DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 3] = WORDLOW_BYTELOW  (numBytes);
            if ((err = DOSpacket.DOSpacketPut(DOSprotocol.DOS_CMD_WRITE_DATA, DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != 0) return (err);

                        var tempBuffer = new byte[DOSpacketPayloadLengthBlock] ;
            do
            {
                response = DOSpacket.DOSpacketGetResponse();
                switch (response)
                {
                    case DOSprotocol.DOS_CMD_SET_BLOCK_LEN:
                        DOSpacketPayloadLengthBlock = BitConverter.ToUInt16(DOScommandResponse, DOSprotocol.DOS_PACKET_LENGTH_HEADER + 2);
                        //BYTEHIGH(DOSpacketPayloadLengthBlock) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 2]; /* update global parameter if no error */
                        //BYTELOW (DOSpacketPayloadLengthBlock) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 3];
                        break;
                    case DOSprotocol.DOS_HANDSHAKE_GO:
                        Array.Copy(buffer, numBytes, tempBuffer, 0, DOSpacketPayloadLengthBlock);
                        DOSpacket.DOSpacketPutBlock(tempBuffer); /* send data to DOSonCHIP */
                        //buffer += DOSpacketPayloadLengthBlock; /* point to next block of data to send */
                        numBytes -= DOSpacketPayloadLengthBlock; /* adjust number of bytes left to send */
                        break;
                    case DOSprotocol.DOS_DATA_BLOCK_END:
                        if (numBytes == 0) return (0); /* no error */
                        else return (DOS_HOST_WRITE_NOT_COMPLETE); /* did not complete writing the specified number of bytes */
                        break;
                    default:
                        if ((response > DOSprotocol.DOS_RES_NOERROR) && (response <= DOS_ERROR_RANGE_MAX)) return (response);
                        return (DOSprotocol.DOS_RES_INVALID_PACKET_TYPE); /* packet number is out of range */
                        break;
                }
            } while (true); /* loop exit is within switch */
        }


        /******************************************************************************/
        /**
           Deletes a file or existing directory from the current directory location.

           \param[in] directory Pointer to a buffer containing the name of the
                                directory to delete. This must be a null-terminated 
                                string. 

           \return    byte

           \retval    0         If the file or directory was properly deleted and no
                                errors were encountered.

           \retval    error #   If an error occurred (see DOSprotocol.h).

           \remark    Single-level deletion is the only type supported. That is,
                      existing directories may only be deleted from the current directory,
                      not in any lower or upper level ones relative to the current
                      directory.

                      For example, if the current directory is '\\TEMP\\APPLICATION',
                      and this directory contains just one directory entry, 'NEWDIR',
                      then

                      \code DOSdelete ("NEWDIR"); \endcode

                      is valid, but

                      \code DOSdelete ("\\TEMP\\NEWDIR"); \endcode

                      is not since deleting directories located anywhere other than 
                      the current directory is not supported.

           \remark   <b>KNOWN ISSUE: Currently directories cannot be deleted.</b>
        */
        /******************************************************************************/
        public static byte DOSdelete(byte[] name)
        {
            byte response;

            /* Set file/directory name */
            if ((response = DOSsetName(name)) != 0) return (response);

            /* Delete file/directory */
            if ((response = DOSpacket.DOSpacketPut(DOSprotocol.DOS_CMD_DELETE, 0)) != 0) return (response);
            if ((response = DOSpacket.DOSpacketGet(DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != DOSprotocol.DOS_RES_NOERROR) return (response);

            return 0; /* no error */
        }


        /******************************************************************************/
        /**
           Sets the DOSonCHIP time and date.

           \param[in] dateTime Pointer to a buffer containing the date/time to set
                               (based upon DOStime_Struct in DOSfileAPI.h).

           \retval    0        If the time was set successfully and no errors were
                               encountered.

           \retval    error #  If an error occurred (see DOSprotocol.h).
           
           \remarks            Valid date range: January 1, 1980 to January 18, 2038
                               (based upon intersection of Unix Epoch and DOS Epoch).
        */
        /******************************************************************************/
        public static byte DOSsetTime(ref DOStime dateTime)
        {
            byte response;
            uint day;
            uint binaryTime;

            /* +80 adjustment near dateTime.year is conversion from DOS Epoch year to Unix Epoch year */

            /* Calculate number of non-leap year days since January 1, 1970 */
            day = (uint)(365 * (dateTime.year - 70 + 80) + DAYS_TO_MONTH[dateTime.month - 1] + (dateTime.day - 1));

            /* Add extra days for the number of leap year periods since 1970 */
            day += (uint)((dateTime.year - 69 + 80) / 4);

            /* Add extra day If the current year is a leap year and past February */
            if ((dateTime.month > 2) && ((dateTime.year % 4) == 0)) day++;

            binaryTime = (24 * day);
            binaryTime += dateTime.hour;
            binaryTime *= 60;
            binaryTime += dateTime.minute;
            binaryTime *= 60;
            binaryTime += dateTime.second;

            Array.Copy(BitConverter.GetBytes(binaryTime), 0, DOScommandResponse, DOSprotocol.DOS_PACKET_LENGTH_HEADER, 4);

            //DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 0] = WORDHIGH_BYTEHIGH(binaryTime); /* set to proper endian order */
            //DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 1] = WORDHIGH_BYTELOW(binaryTime);
            //DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 2] = WORDLOW_BYTEHIGH(binaryTime);
            //DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 3] = WORDLOW_BYTELOW(binaryTime);
            if ((response = DOSpacket.DOSpacketPut(DOSprotocol.DOS_CMD_SET_TIME, DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != 0) return (response);
            if ((response = DOSpacket.DOSpacketGet(DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != DOSprotocol.DOS_RES_NOERROR) return (response);

            return 0; /* no error */
        }


        /******************************************************************************/
        /**
           Returns the DOSonCHIP time and date.

           \param[in] dateTime Pointer to a buffer containing the date/time to set
                               (based upon DOStime_Struct in DOSfileAPI.h).

           \retval    0        If the time was set successfully and no errors were
                               encountered.

           \retval    error #  If an error occurred (see DOSprotocol.h).
        */
        /******************************************************************************/
        public static byte DOSgetTime(ref DOStime dateTime)
        {
            byte response;
            uint binaryTime;

            if ((response = DOSpacket.DOSpacketPut(DOSprotocol.DOS_CMD_GET_TIME, DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != 0) return (response);
            if ((response = DOSpacket.DOSpacketGet(DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != DOSprotocol.DOS_RES_NOERROR) return (response);

            binaryTime = BitConverter.ToUInt32(DOScommandResponse, DOSprotocol.DOS_PACKET_LENGTH_HEADER);

            //WORDHIGH_BYTEHIGH(binaryTime) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 0]; /* set to proper endian order */
            //WORDHIGH_BYTELOW(binaryTime) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 1];
            //WORDLOW_BYTEHIGH(binaryTime) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 2];
            //WORDLOW_BYTELOW(binaryTime) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 3];

            DOSdateTimeConvert(binaryTime, out dateTime); /* convert 32-bit time/date to usable data structure */

            return 0; /* no error */
        }


        /******************************************************************************/
        /**
           Turns the DOSonCHIP real-time clock on or off.

           \param[in]  mode     Byte indicating the clock mode.
                                The following values are supported:
                            \li DOS_ON  : Start incrementing clock.
                            \li DOS_OFF : Stop incrementing clock.
           
           \retval    0         If the clock was turned on or off successfully
                                & no errors were encountered.

           \retval    error #   If an error occurred (see DOSprotocol.h).
        */
        /******************************************************************************/
        public static byte DOStimeOnOff(byte mode)
        {
            byte response;

            /* DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 0] = 0; */
            /* DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 1] = 0; */
            /* DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 2] = 0; */
            DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 3] = (byte)mode;

            if ((response = DOSpacket.DOSpacketPut(DOSprotocol.DOS_CMD_SET_TIME_ON_OFF, DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != 0) return (response);
            if ((response = DOSpacket.DOSpacketGet(DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != DOSprotocol.DOS_RES_NOERROR) return (response);

            return 0; /* no error */
        }

        /******************************************************************************/
        /**
           Puts DOSonCHIP into shutdown mode.

           \retval   0       If the chip was put into shutdown mode successfully and no 
                             errors were encountered.

           \retval   error # If an error occurred (see DOSprotocol.h).

           \remark   <b>CAN ONLY GET OUT OF SHUTDOWN BY HARDWARE RESET</b>

           \remark   <b>KNOWN ISSUE: Real-time clock may be reset,
                     depending upon the silicon version.
                     NO WORKAROUND.</b>
        */
        /******************************************************************************/
        public static byte DOSshutdown()
        {
            byte response;

            if ((response = DOSpacket.DOSpacketPut(DOSprotocol.DOS_CMD_SHUTDOWN, DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != 0) return (response);
            if ((response = DOSpacket.DOSpacketGet(DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != DOSprotocol.DOS_HANDSHAKE_OFF) return (response);

            return 0; /* no error */
        }


        /******************************************************************************/
        /**
           Returns the verion number of the DOSonCHIP silicon IC.

           \param[out] versionIC Pointer to a 1 byte buffer
                                 which will receive the silicon IC version number.

           \retval     0         If the chip returned the version numbers without error.

           \retval     error #   If an error occurred (see DOSprotocol.h).
        */
        /******************************************************************************/
        public static byte DOSgetIC(out byte versionIC)
        {
            byte response;
            versionIC = 0;

            if ((response = DOSpacket.DOSpacketPut(DOSprotocol.DOS_CMD_GET_ID, DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != 0) return (response);
            if ((response = DOSpacket.DOSpacketGet(DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != DOSprotocol.DOS_RES_NOERROR) return (response);
            versionIC = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 3]; /* DOSonCHIP IC identifier byte */

            return 0; /* no error */
        }


        /******************************************************************************/
        /**
           Returns the verion numbers of the firmware on the DOSonCHIP device.

           \param[out] versionBoot  Pointer to a 2 byte buffer
                                    which will receive the bootloader version number.

           \param[out] versionFile  Pointer to a 2 byte buffer
                                    which will receive the firmware version number.

           \retval     0            If the chip returned the version numbers without error.

           \retval     error #      If an error occurred (see DOSprotocol.h).

           \remark     The bytes are in the following consecutive order:
                       bootloader major version, bootloader minor version,
                       firmware major version, firmware minor version.
        */
        /******************************************************************************/
        public static byte DOSgetVersion(out ushort versionBoot, out ushort versionFile)
        {
            byte response;
            versionBoot = 0;
            versionFile = 0;

            if ((response = DOSpacket.DOSpacketPut(DOSprotocol.DOS_CMD_GET_VERSION, DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != 0) return (response);
            if ((response = DOSpacket.DOSpacketGet(DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != DOSprotocol.DOS_RES_NOERROR) return (response);

            versionBoot = BitConverter.ToUInt16(DOScommandResponse, DOSprotocol.DOS_PACKET_LENGTH_HEADER);
            versionFile = BitConverter.ToUInt16(DOScommandResponse, DOSprotocol.DOS_PACKET_LENGTH_HEADER + 2);

            //BYTEHIGH(versionBoot) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 0]; /* major version number */
            //BYTELOW(versionBoot) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 1]; /* minor version number */
            //BYTEHIGH(versionFile) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 2]; /* major version number */
            //BYTELOW(versionFile) = DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 3]; /* minor version number */

            return 0; /* no error */
        }


        /******************************************************************************/
        /**
           Puts DOSonCHIP into firware update mode.

           \retval   0       If the chip was put into update mode successfully and no 
                             errors were encountered.

           \retval   error # If an error occurred (see DOSprotocol.h).

           \remark   <b>CAN ONLY ABORT UPDATE MODE BY HARDWARE RESET</b>

           \remark   <b>KNOWN ISSUE: The firmware update is only through
                     the DOSonCHIP UART.</b>
        */
        /******************************************************************************/
        public static byte DOSupdateFirmware()
        {
            byte response;

            if ((response = DOSpacket.DOSpacketPut(DOSprotocol.DOS_CMD_UPDATE, DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != 0) return (response);
            if ((response = DOSpacket.DOSpacketGet(DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER])) != DOSprotocol.DOS_HANDSHAKE_OFF) return (response);

            return 0; /* no error */
        }

    }
}
