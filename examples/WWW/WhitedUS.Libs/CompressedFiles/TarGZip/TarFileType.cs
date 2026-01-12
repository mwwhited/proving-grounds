using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Libs.CompressedFiles.TarGZip
{
    public enum TarFileType : byte
    {
        Normal = 0,
        HardLink = 1,
        SymbolicLink = 2,
        CharacterDevice = 3,
        BlockDevice = 4,
        Directory = 5,
        NamedPipe = 6,
        ContiguousFlie = 7
    }
}
