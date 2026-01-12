using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Security
{
    [Flags]
    public enum MyAccessRightFlag
    {
        /// <summary>
        /// Read content of files or list content of folder
        /// </summary>
        Read        = 0x0001,
        /// <summary>
        /// Execute script or traverse folder
        /// </summary>
        Execute     = 0x0002,
        /// <summary>
        /// Create new file or folder
        /// </summary>
        Create      = 0x0004,
        /// <summary>
        /// Data data to an existing file or create new directory
        /// </summary>
        Append      = 0x0008,
        /// <summary>
        /// Delete file, contents, or directory
        /// </summary>
        Delete      = 0x0010,

        OwnerShip   = -1
    }
}
