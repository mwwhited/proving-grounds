using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;
using System.Drawing;

namespace WhitedUS.PhotoAdapter
{
    [XmlRoot("client")]
    public class PhotoClient
    {
        public PhotoClient()
        {
            this.Port = 80;
            this.Host = "www.whited.us";
            this.BasePath = "AlphaSite/Services/PhotoRest.svc";
        }

        [XmlAttribute("host")]
        public string Host { get; set; }
        [XmlAttribute("port")]
        public int Port { get; set; }
        [XmlAttribute("basePath")]
        public string BasePath { get; set; }

        [XmlIgnore]
        public string Url
        {
            get
            {
                return string.Format("http://{0}:{1}/{2}",
                                     this.Host,
                                     this.Port,
                                     this.BasePath);
            }
        }

        internal PhotoProxy CreateProxy()
        {
            return new PhotoProxy(this.Url);
        }

        #region IPhotoProxy Members

        public PhotoAlbums ListPhotos(string path, int skip, int take, string method)
        {
            using (var proxy = this.CreateProxy())
                return proxy.ListPhotos(path, skip, take, method);
        }

        public PhotoAlbums GetTag(int take, string method)
        {
            using (var proxy = this.CreateProxy())
                return proxy.GetTag(take, method);
        }

        public PhotoAlbums ListTagPhotos(string tag, int skip, int take, string method)
        {
            using (var proxy = this.CreateProxy())
                return proxy.ListTagPhotos(tag, skip, take, method);
        }

        public Bitmap GetPhoto(string path, string hash, int width, int height)
        {
            using (var proxy = this.CreateProxy())
                return proxy.GetPhoto(path, hash, width, height);
        }

        public PhotoTags AddTag(string path, string hash, string tag)
        {
            using (var proxy = this.CreateProxy())
                return proxy.AddTag(path, hash, tag);
        }

        public PhotoTags GetTags(string path, string hash)
        {
            using (var proxy = this.CreateProxy())
                return proxy.GetTags(path, hash);
        }

        public PhotoTags RemoveTag(string path, string hash, string tag)
        {
            using (var proxy = this.CreateProxy())
                return proxy.RemoveTag(path, hash, tag);
        }

        public PhotoTags AddAllTag(string path, string tag)
        {
            using (var proxy = this.CreateProxy())
                return proxy.AddAllTag(path, tag);
        }

        #endregion
    }
}
