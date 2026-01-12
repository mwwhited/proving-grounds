using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using PhotoAlbumViewer.WhitedUS.PhotoAlbumService;

namespace PhotoAlbumViewer
{
    public class DirectoryNode : IEnumerable<DirectoryNode>
    {
        private static DirectoryNode _root;

        private string _basePath;
        private DirectoryNode _parent;
        private ObservableCollection<DirectoryNode> _children;
        private ObservableCollection<Photo> _photos;


        private DirectoryNode() { }
        private DirectoryNode(string basePath, DirectoryNode parent)
        {
            _parent = parent;
            _basePath = basePath;
        }

        public static DirectoryNode Root
        {
            get
            {
                if (_root == null)
                    _root = new DirectoryNode();
                return _root;
            }
        }

        public ObservableCollection<DirectoryNode> Children
        {
            get
            {
                if (_children == null)
                    try
                    {
                        using (var client = new PhotoServiceContractClient())
                        {                            
                            _children = new ObservableCollection<DirectoryNode>(client
                                .GetDirectories(_basePath)
                                .Select(n => new DirectoryNode(n, this))
                                );
                        }
                    }
                    catch (Exception e)
                    {
                        Debug.WriteLine(e.ToString());
                    }
                return _children;
            }
        }

        public ObservableCollection<Photo> Photos
        {
            get
            {
                if (_photos == null)
                    try
                    {
                        using (var client = new PhotoServiceContractClient())
                        {
                            _photos = new ObservableCollection<Photo>(client
                                .GetPhotoNames(_basePath)
                                .Select(p => new Photo()
                                {
                                    BasePath = _basePath,
                                    HashKey = p.Key,
                                    Name = p.Value,
                                    Parent = this
                                })
                                );
                        }
                    }
                    catch (Exception e)
                    {
                        Debug.WriteLine(e.ToString());
                    }
                return _photos;
            }
        }

        public string CurrentPath { get { return _basePath; } }
        public string Name { get { 
            if (string.IsNullOrEmpty(_basePath))
                return "Root";
            return Path.GetFileName(_basePath); 
        } }
        public DirectoryNode Parent { get { return _parent; } }

        public void Refresh() { _children = null; _photos = null; }

        public override string ToString() { return Name; }

        #region IEnumerable<DirectoryNode> Members

        public IEnumerator<DirectoryNode> GetEnumerator()
        {
            foreach (var item in Children)
                yield return item;
        }

        #endregion

        #region IEnumerable Members

        IEnumerator IEnumerable.GetEnumerator()
        {
            foreach (var item in Children)
                yield return item;
        }

        #endregion
    }
}
