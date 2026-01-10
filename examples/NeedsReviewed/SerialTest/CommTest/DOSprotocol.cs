using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CommTest
{
    public class DOSprotocol
    {
        /* Upgraded to C# by Matthew Whited 04/05/2009 */
        /*******************************************************************************
        Copyright 2008, 2009 Wearable Inc.; An Illinois, United States Corporation
        Licensed under the Apache License, Version 2.0 (the "License");
        you may not use this file except in compliance with the License.
        You may obtain a copy of the License at
        http://www.apache.org/licenses/LICENSE-2.0
        Unless required by applicable law or agreed to in writing, software
        distributed under the License is distributed on an "AS IS" BASIS,
        WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
        See the License for the specific language governing permissions and
        limitations under the License.
        *******************************************************************************/
        /*******************************************************************************
        Name: DOSonCHIP(TM) Host API Definitions
        File Name: DOSprotocol.h
        Description: Host API Protocol Definitions
        *******************************************************************************/

        /* DOSONCHIP IC CONSTANTS */
        public const byte DOS_FIRMWARE_MAJOR = 0x02;/* expected firmware (major) version */
        public const byte DOS_FIRMWARE_MINOR = 0x02;/* expected firmware (minor) version */
        public const byte DOS_MAX_HANDLES = 4; /* Firmware 2.x limit */

        /* PACKET CONSTANTS */
        public const byte DOS_PACKET_LENGTH_HEADER = 1; /* single header byte */
        public const uint DOS_PACKET_LENGTH_PAYLOAD_MAX = 512;/* default & maximum DATA_BLOCK payload length */
        public const byte DOS_PACKET_LENGTH_PAYLOAD_NAME = 12; /* (8+1+3) default & maximum DATA_NAME packet payload length */
        public const byte DOS_PACKET_LENGTH_PAYLOAD_CMDRES = 4; /* command & response payload length */
        public const byte DOS_PACKET_LENGTH_PAYLOAD_HANDSHAKE = 0;/* handshake payload length */
        public const byte DOS_PACKET_LENGTH_FOOTER = 0; /* no footer at this time */

        /* PACKET HEADER DEFINITIONS */
        public const byte DOS_HANDSHAKE_OFF = 0xFF;
        public const byte DOS_HANDSHAKE_WAIT = 0x00;
        public const byte DOS_HANDSHAKE_POLL = DOS_HANDSHAKE_WAIT;
        public const byte DOS_HANDSHAKE_GO = 0xEA;
        public const byte DOS_HANDSHAKE_PAK_NEXT = 0xE0;
        public const byte DOS_HANDSHAKE_PAK_ABORT = 0xE1;
        public const byte DOS_DATA_NAME = 0x7B;
        public const byte DOS_DATA_BLOCK = 0x7C;
        public const byte DOS_DATA_BLOCK_END = 0x7D;
        public const byte DOS_COMMAND_CARD_ACCESS_MIN = 0x5B; /* NON-COMMAND: minimum command header byte value for a command requiring card access */
        public const byte DOS_CMD_GET_ID = 0x40; /* "@" : get the DOSonCHIP silicon version */
        public const byte DOS_CMD_UPDATE = 0x42; /* "B" : update firmware via bootloader */
        public const byte DOS_CMD_GET_NAME = 0x47; /* "G" : get current file/directory name */
        public const byte DOS_CMD_SET_HANDLE = 0x48; /* "H" : set the current handle number */
        public const byte DOS_CMD_SET_BLOCK_LEN = 0x4C;/* "L" : set the byte length for transferring data in a single packet transfer */
        public const byte DOS_CMD_SET_NAME_LEN = 0x4D; /* "M" : set the byte length for the file/ directory name */
        public const byte DOS_CMD_SET_NAME = 0x4E; /* "N" : set the current file/directory name */
        public const byte DOS_CMD_SET_TIME_ON_OFF = 0x52; /* "R" : enable/disable the real-time clock to commence incrementing */
        public const byte DOS_CMD_SET_TIME = 0x53;/* "S" : set the real-time clock date & time */
        public const byte DOS_CMD_GET_TIME = 0x54; /* "T" : get the real-time clock date & time */
        public const byte DOS_CMD_GET_VERSION = 0x56; /* "V" : get the DOSonCHIP firmware versions (bootloader & filesystem) */
        public const byte DOS_CMD_SHUTDOWN = 0x5A; /* "Z" : place the DOSonCHIP into minimal power shut down */
        public const byte DOS_CMD_DIR = 0x5C; /* "\" : retrieve directory entry */
        public const byte DOS_CMD_MOUNT = 0x5F; /* "_" : initialize the card file system */
        public const byte DOS_CMD_WRITE_PREALLOCATE = 0x61; /* "a" : add bytes to current file open for writing */
        public const byte DOS_CMD_CLOSE = 0x63; /* "c" : flush any pending writes to the file, update the modification time stamp, and clear the handle number */
        public const byte DOS_CMD_DELETE = 0x64; /* "d" : delete the current directory entry */
        public const byte DOS_CMD_DIR_GET_PROPERTY = 0x69;/* "i" : get the current directory entry property (used with DOS_CMD_DIR) */
        public const byte DOS_CMD_SET_DIR = 0x6C; /* "l" : set the current directory */
        public const byte DOS_CMD_MAKE_DIR = 0x6D; /* "m" : make a new directory within them current directory */
        public const byte DOS_CMD_OPEN_WRITE = 0x6F;/* "o" : open a file for writing */
        public const byte DOS_CMD_OPEN_READ = 0x70; /* "p" : open a file for reading */
        public const byte DOS_CMD_READ_DATA = 0x72; /* "r" : read data from a file */
        public const byte DOS_CMD_SEEK = 0x73; /* "s" : change the current position pointer in a file for subsequent reading or writing */
        public const byte DOS_CMD_GET_FREE_SECTORS = 0x75; /* "u" : get the amount of available but unused sectors for the current file system */
        public const byte DOS_CMD_WRITE_DATA = 0x77; /* "w" : write data to a file */
        
        /* COMMAND PARAMETER DEFINITIONS */
        public const byte DOS_OFF = 0x00; /* Disable feature */
        public const byte DOS_ON = 0x01; /* Enable feature */
        public const byte DOS_FIRST = 0x00;/* Point to first valid directory entry */
        public const byte DOS_NEXT = 0x01; /* Point to next directory entry */

        /* FILE ATTRIBUTES (not mutually exclusive) */
        public const byte DOS_ATTR_READ_ONLY = 0x01; /* if set, directory entry is read only */
        public const byte DOS_ATTR_HIDDEN = 0x02; /* if set, directory entry is hidden */
        public const byte DOS_ATTR_SYSTEM = 0x04;/* directory entry system tag bit */
        public const byte DOS_ATTR_DIRECTORY = 0x10;/* if set, directory entry is directory (not a file) */
        public const byte DOS_ATTR_ARCHIVE = 0x20; /* directory entry archive tag bit */

        /* DIRECTORY ENTRY PROPERTIES (for DOS_CMD_DIR_GET_PROPERTY) */
        public const byte DOS_PROPERTY_SIZE = 0x00;/* return the current entry's size of file */
        public const byte DOS_PROPERTY_TIME_CREATED = 0x01; /* return the current entry's creation date/ time stamp */
        public const byte DOS_PROPERTY_TIME_MODIFIED = 0x02; /* return the current entry's last modified date/time stamp */

        /* RESPONSE HEADER DEFINITIONS */
        public const byte DOS_RES_NOERROR = 0x80; /* no error */
        public const byte DOS_RES_CARD_ERROR = 0x81; /* card error (card error in payload) */
        public const byte DOS_RES_CARD_NOT_DETECTED = 0x82; /* card not detected */
        public const byte DOS_RES_CARD_INIT_FAILURE = 0x83; /* card could not be initialized */
        public const byte DOS_RES_CARD_BLOCK_LENGTH_FAILURE = 0x84; /* either card block length is improper or card could not have block length set */
        public const byte DOS_RES_CARD_VOLTAGE_OUT_OF_RANGE = 0x85; /* card required voltage not within allowable range */
        public const byte DOS_RES_CARD_NOT_MOUNTED = 0x86; /* card volume is not mounted */
        public const byte DOS_RES_INVALID_COMMAND = 0x90; /* invalid command */
        public const byte DOS_RES_INVALID_PACKET_TYPE = 0x91;/* improper packet type than expected */
        public const byte DOS_RES_INVALID_PARAMETER = 0x92; /* parameter out of range */
        public const byte DOS_RES_INVALID_OPERATION = 0x93; /* cannot perform this operation--not allowed */
        public const byte DOS_RES_DISK_FORMAT_INCOMPATIBLE = 0x98; /* card file system is not supported (please reformat card) */
        public const byte DOS_RES_DISK_FULL = 0x99; /* disk full error */
        public const byte DOS_RES_DISK_ROOT_DIR_FULL = 0x9A; /* root directory full error (FAT16) */
        public const byte DOS_RES_NAME_ERROR = 0xA0;/* invalid directory name/not a directory/ filename error */
        public const byte DOS_RES_NAME_NOT_FOUND = 0xA1; /* file/directory not found; entry does not exist in specified dir */
        public const byte DOS_RES_NAME_DUPLICATE = 0xA2; /* duplicate name error; file/directory already exists */
        public const byte DOS_RES_HANDLE_INVALID = 0xA8; /* invalid handle/handle out of range */
        public const byte DOS_RES_HANDLE_PREVIOUSLY_ASSIGNED = 0xA9; /* handle previously assigned */
        public const byte DOS_RES_FILE_END = 0xB0; /* end-of-file */
        public const byte DOS_RES_FILE_READ_ONLY = 0xB1; /* read-only error/write access is denied */
        public const byte DOS_RES_FILE_OPEN_PREVIOUS = 0xB2; /* file already open */
        public const byte DOS_RES_FILE_NOT_OPEN_FOR_READ = 0xB3; /* not opened for read operation error should this be generic 'cannot apply this operation' ??? */
        public const byte DOS_RES_FILE_NOT_OPEN_FOR_WRITE = 0xB4; /* not opened for write operation error */
        public const byte DOS_RES_FILE_CANNOT_DELETE = 0xB5; /* open file cannot be deleted error */
        public const byte DOS_RES_FILE_TOO_LARGE = 0xB6; /* file would be too large */
        public const byte DOS_RES_DIR_END = 0xC0;/* directory iterator at end */
        public const byte DOS_RES_DIR_NOT_INITIALIZED = 0xC1; /* directory iterator is not initialized */
        /* Highest allowable error code is 0xDF */

    }
}
