using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;
using System.IO;

namespace WhitedUS.Data
{
    [DataObject(true)]
    [DefaultProperty("ImagePath")]
    public class Photos
    {
        private static string _imagePath = @"\\trojan\Photos\2008\06212008_RockHouse\";

        [DataObjectField(true)]
        public string ImagePath { get; set; }

        [DataObjectField(false)]
        public string ImageFileName
        {
            get
            {
                if (string.IsNullOrEmpty(ImagePath))
                    return null;
                else
                    return Path.GetFileName(ImagePath);
            }
        }

        public override string ToString() { return ImagePath; }

        //=========================

        [DataObjectMethod(DataObjectMethodType.Select, true)]
        public static IEnumerable<Photos> GetImages()
        {
            IList<Photos> photos = new List<Photos>();
            DirectoryInfo _dir = new DirectoryInfo(_imagePath);
            if (_dir.Exists)
            {
                foreach (var file in _dir.GetFiles("*.jpg"))
                {
                    photos.Add(new Photos() { ImagePath = file.FullName });
                }
            }
            return photos;
        }
    }
}
