using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;
using System.IO.IsolatedStorage;
using System.Linq;
using System.Reflection;
using WhitedUS.Libs.Converters;
using WhitedUS.Libs.Graphics.Exif;

namespace WhitedUS.Data.Photos
{
    [DataObject(true)]
    [DefaultProperty("ImagePath")]
    [DefaultValue("ImagePathHash")]
    public class Photo
    {
        public Photo() { }

        private static readonly object _appIdentity =
                            Assembly.GetExecutingAssembly().Evidence;
        private static readonly string[] ImageSearchPaths = new string[]{
            @"D:\Shares\Photos\2008\06212008_RockHouse\",
            @"\\trojan\Photos\2008\06212008_RockHouse\",
            @"C:\Inetpub\wwwroot\images"
        };
        private static readonly int _maxWidth = 200;
        private static readonly int _maxHeight = 200;
        private static readonly string _fileNameFormat = "{0}_{1}x{2}.jpg";
        private static readonly string _fileNameFormatWild = "{0}_*.jpg";

        private string _imagePath;
        private string _imagePathHash;
        private string _imageFileName;

        [DataObjectField(true)]
        public string ImagePathHash
        {
            get
            {
                if (string.IsNullOrEmpty(_imagePathHash))
                {                    
                    _imagePathHash = ImagePath.Replace(@"\\homeserver\Photos\", @"D:\Shares\Photos\").GetMD5Hash();
                }
                return _imagePathHash;
            }
        }

        public Guid ID
        {
            get
            {
                return new Guid(ImagePathHash);
            }
        }

        public byte[] Image
        {
            get
            {
                if (string.IsNullOrEmpty(ImageFileName))
                    return null;
                else
                {
                    if (!File.Exists(ImagePath))
                        return null;
                    byte[] imgBuffer = null;
                    using (FileStream fsImage = File.Open(ImagePath,
                                                          FileMode.Open,
                                                          FileAccess.Read,
                                                          FileShare.Read))
                    {
                        using (MemoryStream ms = new MemoryStream())
                        {
                            byte[] buffer = new byte[100];
                            int bufferLen = 1;

                            while (bufferLen > 0)
                            {
                                bufferLen = fsImage.Read(buffer,
                                                         0,
                                                         buffer.Length);
                                if (bufferLen > 0)
                                    ms.Write(buffer, 0, bufferLen);
                            }
                            imgBuffer = ms.ToArray();
                        }
                    }
                    return imgBuffer;
                }
            }
        }

        private ExifData _exifData;
        public ExifData EXIF
        {
            get
            {
                if (_exifData != null)
                    return _exifData;

                if (Image == null || Image.Length < 1)
                    return null;

                using (var ms = new MemoryStream(Image))
                using (var bmp = new Bitmap(ms))
                    _exifData = ExifData.CreateInstance(bmp);
                return _exifData;
            }
        }

        public bool ClearCache()
        {
            using (var isoStore =
                                IsolatedStorageFile.GetMachineStoreForDomain())
            {
                var result = true;
                string isoFileName = string.Format(_fileNameFormatWild,
                                                   ImagePathHash);
                var files = isoStore.GetFileNames(isoFileName);
                foreach (var file in files)
                {
                    try
                    {
                        isoStore.DeleteFile(file);
                    }
                    catch (IOException) { result = false; }
                }
                return result;
            }
        }

        //public static bool ClearOldCache(TimeSpan minAge)
        //{
        //    using (IsolatedStorageFile isoStore = IsolatedStorageFile.GetMachineStoreForDomain())
        //    {
        //        var result = true;
        //        var files = isoStore.GetFileNames("*.*");
        //        foreach (var file in files)
        //        {
        //            try
        //            {
        //                var fi = new FileInfo(file);
        //                var life = DateTime.Now.Subtract(minAge);

        //                if (fi.CreationTime < life && fi.LastAccessTime < life)
        //                    isoStore.DeleteFile(file);
        //            }
        //            catch (UnauthorizedAccessException uae)
        //            {
        //                Debug.Print(uae.ToString());
        //                result = false;
        //            }
        //        }
        //        return result;
        //    }
        //}

        public byte[] Resize(int maxWidth, int maxHeight)
        {
            using (var ms = new MemoryStream())
            {
                this.Resize(maxWidth, maxHeight, ms);
                ms.Seek(0, SeekOrigin.Begin);
                return ms.ToArray();
            }
        }

        public void Resize(int maxWidth, int maxHeight, Stream stream)
        {
            //MAGIC: Too much magic... REFACTOR!!!
            lock (this)
            {
                if (string.IsNullOrEmpty(ImageFileName))
                    return;
                else
                {
                    if (!File.Exists(ImagePath))
                        return;


                    //C:\ProgramData\IsolatedStorage\t5lxso2g.vzf\jfxcwvku.avs\StrongName.5qinle25dwsuuhwxabfdrpecfzk3v5j2\StrongName.ofirqbjht0xrkqb2xyil5wqg0033luyq\Files
                    using (IsolatedStorageFile isoStore =
                                IsolatedStorageFile.GetMachineStoreForDomain())
                    {
                        string isoFileName = string.Format(_fileNameFormat,
                                                           ImagePathHash,
                                                           maxWidth,
                                                           maxHeight);
                        var names = isoStore.GetFileNames(isoFileName);

                        if (isoStore.GetFileNames(isoFileName).Length <= 0)
                        {
                            //Thumbbail File Doesn't Exist
                            using (var fsThumb = new IsolatedStorageFileStream(
                                                            isoFileName,
                                                            FileMode.Create,
                                                            FileAccess.Write,
                                                            isoStore))
                            {
                                if (fsThumb.Length == 0)
                                {
                                    using (var fsImage = File.Open(
                                                            ImagePath,
                                                            FileMode.Open,
                                                            FileAccess.Read,
                                                            FileShare.Read))
                                    using (var existing = new Bitmap(fsImage))
                                    {
                                        var exifData = ExifData.CreateInstance(
                                                    existing.PropertyItems);

                                        if (exifData != null &&
                                            exifData.Orientation.HasValue &&
                                            exifData.Orientation.Value !=
                                                    OrientationType.LeftTop &&
                                            existing.Width > existing.Height
                                            )
                                        {
                                            if (exifData.Orientation.Value == OrientationType.LeftBottom)
                                                existing.RotateFlip(RotateFlipType.Rotate270FlipNone);
                                            else if (exifData.Orientation.Value == OrientationType.RightTop)
                                                existing.RotateFlip(RotateFlipType.Rotate90FlipNone);
                                        }

                                        byte[] resizeBuffer = new byte[1024];
                                        float pScaleWidth = maxWidth == 0 ? 1f : (float)maxWidth / (float)existing.Width;
                                        float pScaleHeight = maxHeight == 0 ? 1f : (float)maxHeight / (float)existing.Height;
                                        float pScale = pScaleHeight < pScaleWidth ? pScaleHeight : pScaleWidth;
                                        int scaleWidth = (int)(existing.Width * pScale);
                                        int scaleHeight = (int)(existing.Height * pScale);

                                        using (Bitmap scaledBitmap = new Bitmap(scaleWidth, scaleHeight, existing.PixelFormat))
                                        {
                                            Graphics resizeGraphic = Graphics.FromImage(scaledBitmap);
                                            resizeGraphic.Clear(Color.Transparent);
                                            resizeGraphic.InterpolationMode = InterpolationMode.HighQualityBicubic;
                                            resizeGraphic.DrawImage(
                                                existing,
                                                new Rectangle(0, 0, scaleWidth, scaleHeight),
                                                new Rectangle(0, 0, existing.Width, existing.Height),
                                                GraphicsUnit.Pixel
                                                );

                                            scaledBitmap.Save(fsThumb, ImageFormat.Jpeg);
                                        }
                                    }
                                }
                            }
                        }
                        using (var fsThumb = new IsolatedStorageFileStream(
                            isoFileName,
                            FileMode.Open,
                            FileAccess.Read,
                            isoStore
                            ))
                        {
                            int bufferLen = 1;
                            var buffer = new byte[1024];

                            while (bufferLen > 0)
                            {
                                bufferLen = fsThumb.Read(buffer, 0, 1024);
                                if (bufferLen > 0)
                                    stream.Write(buffer, 0, bufferLen);
                            }
                        }
                    }
                }
            }
        }

        public byte[] ThumbNail
        {
            get
            {
                return Resize(_maxWidth, _maxHeight);
            }
        }

        [DataObjectField(false)]
        public string ThumbNailBase64
        {
            get { return ThumbNail.ToBase64(); }
        }

        [DataObjectField(false)]
        public string ImagePath
        {
            get { return _imagePath; }
            set
            {
                if (value != _imagePath)
                {
                    _imagePath = PhotoAlbum.ROOT +
                                 Path.GetDirectoryName(
                                        value.Replace(PhotoAlbum.ROOT, "")
                                    ) +
                                 "\\" + Path.GetFileName(value);
                    _imagePathHash = null;
                    _imageFileName = null;
                }
            }
        }

        [DataObjectField(false)]
        public string RelativePath
        {
            get
            {
                if (string.IsNullOrEmpty(_imagePath))
                    return null;
                else
                    return System.IO.Path.GetDirectoryName(_imagePath)
                                         .Replace(PhotoAlbum.ROOT, "");
            }
        }

        [DataObjectField(false)]
        public string ImageFileName
        {
            get
            {
                if (string.IsNullOrEmpty(_imageFileName))
                {
                    if (string.IsNullOrEmpty(ImagePath))
                        _imageFileName = null;
                    else
                        _imageFileName = Path.GetFileName(ImagePath);
                }
                return _imageFileName;
            }
        }

        public IEnumerable<Tag> Tags
        {
            get
            {
                using (var db = new PhotoTagsDataDataContext())
                {
                    var img = db.Images.Where(i => i.ImageID == this.ID)
                                       .FirstOrDefault();
                    if (img == null)
                    {
                        db.Images.InsertOnSubmit(new Image()
                        {
                            ImageID = this.ID,
                            Folder = this.RelativePath.Replace('\\', '/'),
                            Name = this.ImageFileName
                        });
                        db.SubmitChanges();
                    }
                    return db.Tags.Where(i => i.ImageID == this.ID);
                }
            }
        }

        public void AddTag(string tag)
        {
            if (string.IsNullOrEmpty(tag))
                return;

            using (var db = new PhotoTagsDataDataContext())
            {
                var tags = db.Tags;
                var currentTag = tags.Where(i => i.ImageID == this.ID &&
                                                 i.Name == tag)
                                     .FirstOrDefault();
                if (currentTag == null)
                {
                    tags.InsertOnSubmit(new Tag()
                    {
                        ImageID = this.ID,
                        Name = tag
                    });
                    db.SubmitChanges();
                }
            }
        }

        public void RemoveTag(string tag)
        {
            if (string.IsNullOrEmpty(tag))
                return;

            using (var db = new PhotoTagsDataDataContext())
            {
                var tags = db.Tags;
                var currentTag = tags.Where(i => i.ImageID == this.ID &&
                                                 i.Name == tag)
                                     .FirstOrDefault();
                if (currentTag != null)
                {
                    tags.DeleteOnSubmit(currentTag);
                    db.SubmitChanges();
                }
            }
        }

        public override string ToString() { return ImagePath; }

        //=========================

        [DataObjectMethod(DataObjectMethodType.Select, true)]
        public static IEnumerable<Photo> GetImages()
        {
            IList<Photo> photos = new List<Photo>();
            DirectoryInfo dir = null;

            foreach (var imageSearchPath in ImageSearchPaths)
            {
                dir = new DirectoryInfo(imageSearchPath);
                if (dir.Exists)
                    break;
            }

            if (dir.Exists)
            {
                foreach (var file in dir.GetFiles(
                                                "*.jpg",
                                                SearchOption.TopDirectoryOnly)
                                        .OrderBy(f => f.FullName))
                    photos.Add(new Photo() { ImagePath = file.FullName });
            }
            return photos;
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public static Photo GetImage(string hashKey)
        {
            return GetImages().Where(i => i.ImagePathHash == hashKey)
                              .FirstOrDefault();
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public static Photo GetImage(string hashKey, string relativePath)
        {
            if (!string.IsNullOrEmpty(hashKey) && hashKey.Contains("-"))
                hashKey = hashKey.Replace("-", "");
            var images = GetImages(relativePath);
            var filtered = images.Where(i => i.ImagePathHash == hashKey);
            var selected = filtered.FirstOrDefault();
            return selected;
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public static IEnumerable<Photo> GetImages(string relativePath)
        {
            PhotoAlbum album = PhotoAlbum.GetAlbum(relativePath);
            if (album != null)
                return album.Photos;
            else
                return null;
        }
    }
}
