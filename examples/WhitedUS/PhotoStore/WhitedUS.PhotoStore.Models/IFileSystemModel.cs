using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.PhotoStore.Models
{
    public interface IFileSystemModel
    {
        string Type { get; }
        string Parent { get; set; }
        string Path { get; set; }
        string Name { get; set; }
    }
}
