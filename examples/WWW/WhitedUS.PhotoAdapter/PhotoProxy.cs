using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.ServiceModel;
using System.ServiceModel.Description;
using System.Text;

namespace WhitedUS.PhotoAdapter
{
    internal class PhotoProxy : ClientBase<IPhotoProxy>
    {
        public PhotoProxy(string uri)
            : base(new WebHttpBinding(), new EndpointAddress(uri))
        {
            this.Endpoint.Behaviors.Add(new WebHttpBehavior());
        }

        #region IPhotoProxy Members

        public PhotoAlbums ListPhotos(string path, int skip, int take, string method)
        {
            return this.Channel.ListPhotos(path, skip, take, method);
        }

        public PhotoAlbums GetTag(int take, string method)
        {
            return this.Channel.GetTag(take, method);
        }

        public PhotoAlbums ListTagPhotos(string tag, int skip, int take, string method)
        {
            return this.Channel.ListTagPhotos(tag, skip, take, method);
        }

        public Bitmap GetPhoto(string path, string hash, int width, int height)
        {
            using (var stream = this.Channel.GetPhoto(path, hash, width, height))
                return new Bitmap(stream);
        }

        public PhotoTags AddTag(string path, string hash, string tag)
        {
            return this.Channel.AddTag(path, hash, tag);
        }

        public PhotoTags GetTags(string path, string hash)
        {
            return this.Channel.GetTags(path, hash);
        }

        public PhotoTags RemoveTag(string path, string hash, string tag)
        {
            return this.Channel.RemoveTag(path, hash, tag);
        }

        public PhotoTags AddAllTag(string path, string tag)
        {
            return this.Channel.AddAllTag(path, tag);
        }

        #endregion
    }
}
