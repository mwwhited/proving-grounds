using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.PhotoStore.Models
{
    public class DirectoryPageModel
    {
        public string Parent { get; set; }

        public string ParentName { get; set; }

        public string Name { get; set; }

        public string Path { get; set; }

        public IQueryable<IFileSystemModel> Data { get; set; }

        public int Page { get; set; }

        public int PageLength { get; set; }

        public int PageCount { get; set; }

        public OrderBy NameOrder { get; set; }
    }
}
