using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhitedUS.PhotoStore.Models
{
    public class DirectoryModel : IFileSystemModel
    {
        public string Type { get { return "Directory"; } }
        public string Parent { get; set; }
        public string Path { get; set; }
        public string Thumbnail { get; set; }
        public string Name { get; set; }
    }
}