using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using PhotoAlbumViewer.WhitedUS.PhotoAlbumService;
using System.Drawing;
using System.IO;

namespace PhotoAlbumViewer
{
    public class Photo
    {
        public string BasePath { get; set; }
        public string Name { get; set; }
        public string HashKey { get; set; }
        public DirectoryNode Parent { get; set; }

        public byte[] ImageData
        {
            get
            {
                using (var client = new PhotoServiceContractClient())
                    return client.GetImageResized(HashKey, BasePath, 200, 200);
            }
        }
    }
}
