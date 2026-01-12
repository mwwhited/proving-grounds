using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.IO;
using WhitedUS.Libs.Converters;
using System.IO.IsolatedStorage;
using System.Collections;
using System.ComponentModel;

namespace WhitedUS.Data.Photos
{
    [DefaultProperty("Path")]
    public class PhotoAlbum : IEnumerable
    {
        static readonly string[] ImageSearchPaths = new string[]{
            @"D:\Shares\Photos\",
            @"\\homeserver\Photos\",
            @"\\trojan\Photos\",
            @"C:\Inetpub\wwwroot\images"
        };

        static PhotoAlbum()
        {
            DirectoryInfo dir = null;
            foreach (var imageSearchPath in ImageSearchPaths)
            {
                dir = new DirectoryInfo(imageSearchPath);
                if (dir.Exists)
                    break;
            }
            if (dir.Exists)
            {
                ROOT = dir.FullName;
                _rootRegEx = new Regex(@"^" + ROOT.Replace("\\", "\\\\") +
                                        "([0-9]{4}|Favorites)");
            }
            else
                throw new InvalidOperationException(
                    "Photo Search Path Not Found");
        }

        public static readonly string ROOT;
        private static readonly Regex _rootRegEx;
        private static readonly string _rootSearch = "*";

        private string _basePath;
        public PhotoAlbum()
        {
            _basePath = ROOT;
        }

        public PhotoAlbum(string basePath)
        {
            if (!_rootRegEx.IsMatch(basePath) && basePath != ROOT)
                throw new ArgumentException("\"basepath\" is invalid");

            _basePath = basePath;
        }

        private List<PhotoAlbum> _subFolders;
        public List<PhotoAlbum> SubFolders
        {
            get
            {
                if (_subFolders == null)
                {
                    if (_basePath == ROOT)
                    {
                        _subFolders = Directory.GetDirectories(ROOT,
                                                               _rootSearch)
                            .Where(d => _rootRegEx.IsMatch(d))
                            .Select(d => new PhotoAlbum(d))
                            .ToList();
                    }
                    else
                    {
                        _subFolders = Directory.GetDirectories(_basePath)
                            .Where(d => _rootRegEx.IsMatch(d))
                            .Select(d => new PhotoAlbum(d))
                            .ToList();
                    }
                }
                return _subFolders;
            }
        }

        public string Name
        {
            get
            {
                return System.IO.Path.GetFileNameWithoutExtension(_basePath);
            }
        }

        public string Path { get { return _basePath.Replace(ROOT, ""); } }

        public string Parent
        {
            get
            {
                if (string.IsNullOrEmpty(this.Path))
                    return string.Empty;

                return (new DirectoryInfo(
                    System.IO.Path.Combine(ROOT, this.Path))
                        .Parent.FullName + "\\")
                            .Replace(ROOT, "")
                            .Replace("\\", "/");
            }
        }

        private List<Photo> _photo;
        public List<Photo> Photos
        {
            get
            {
                if (_photo == null)
                {
                    _photo = new List<Photo>();

                    foreach (var searchString in new[] { "*.jpg", 
                                                          "*.jpeg", 
                                                          "*.png", 
                                                          "*.gif" })
                        _photo.AddRange(
                            Directory.GetFiles(_basePath, searchString)
                            .Where(d => _rootRegEx.IsMatch(d))
                            .Select(p => new Photo() { ImagePath = p })
                            );
                }
                return _photo;
            }
        }

        public static PhotoAlbum GetAlbum(string relativePath)
        {
            if (!string.IsNullOrEmpty(relativePath) && relativePath.Contains('\\'))
                relativePath = relativePath.Replace('\\', '/');

            string fullPath = ROOT + relativePath;

            if (!Directory.Exists(fullPath))
                return null;

            return new PhotoAlbum(fullPath);
        }

        public override string ToString()
        {
            return Name;
        }

        #region IEnumerable Members

        public IEnumerator GetEnumerator()
        {
            return SubFolders.GetEnumerator();
        }

        #endregion
    }
}
