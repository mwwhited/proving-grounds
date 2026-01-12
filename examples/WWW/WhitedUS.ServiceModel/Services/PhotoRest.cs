using System;
using System.ComponentModel;
using System.Data.Linq;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Text;
using System.Xml;
using System.Xml.Linq;
using WhitedUS.Common;
using WhitedUS.Data.Photos;
using WhitedUS.Libs.Xml.Linq;
using WhitedUS.ServiceModel.Linq;

//WhitedUS.ServiceModel.Services.PhotoRest
namespace WhitedUS.ServiceModel.Services
{
    /// <summary>
    /// RESTful Service for Photo Albums
    /// </summary>
    [ServiceContract]
    [AspNetCompatibilityRequirements(
        RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    public class PhotoRest
    {
        private static void RangeValue(ref int input)
        {
            if (input == 0) input = 1024;
            else if (input < 100) input = 100;
            else if (input > 3000) input = 3000;
        }

        private static PhotoAlbum GetAlbum(string path)
        {
            return PhotoAlbum.GetAlbum(path);
        }

        private static Photo GetImage(string hash, string path)
        {
            return Photo.GetImage(hash, path);
        }

        private Stream ResizePhoto(string path, 
                                   string hash, 
                                   int width, 
                                   int height)
        {
            if (WebOperationContext.Current != null)
            {
                var outResp = WebOperationContext.Current.OutgoingResponse;
                outResp.LastModified = DateTime.MaxValue;
                outResp.Headers.Add("Expires", 
                                    DateTime.MaxValue.ToString("r"));
            }


            var img = GetImage(hash, path);
            if (img == null)
                return null;

            var ms = new MemoryStream();
            img.Resize(width, height, ms);
            ms.Seek(0, SeekOrigin.Begin);
            return ms;
        }

        //[OperationContract()]
        //[WebGet(UriTemplate = "/headers")]
        //[Description("Gets transport headers")]
        //public XElement GetHeaders()
        //{
        //    var cntx = WebOperationContext.Current;
        //    var xml = new XElement("allHeaders",
        //        new XElement("incomingRequest", cntx.IncomingRequest.Headers.ToXml()),
        //        //new XElement("incomingResponse", cntx.IncomingResponse.Headers.ToXml()),
        //        new XElement("outgoingRequest", cntx.OutgoingRequest.Headers.ToXml()),
        //        new XElement("outgoingResponse", cntx.OutgoingResponse.Headers.ToXml())
        //        );
        //    return xml;
        //}

        /// <summary>
        /// List Services on this Service
        /// </summary>
        /// <returns>XElement of Service Descriptions</returns>
        [OperationContract()]
        [WebGet(UriTemplate = "/")]
        [Description("list all services under this service binding")]
        public XElement ListServices()
        {
            return this.GetWebGetServices();
        }

        /// <summary>
        /// Retrive XML of Photos
        /// </summary>
        /// <param name="path">Path to Scan</param>
        /// <param name="skip">Number of Elements to Skip</param>
        /// <param name="take">Number of Elements to Take</param>
        /// <param name="method">Method to Link</param>
        /// <returns>XElement</returns>
        [OperationContract()]
        [WebGet(
            UriTemplate = "/list/{*path}?skip={skip}" +
                          "&take={take}&method={method}",
            BodyStyle = WebMessageBodyStyle.Bare,
            ResponseFormat = WebMessageFormat.Xml
            )]
        [ContentType(ContentTypes.Text_XML)]
        [Description("list all albums and photos in the given path.  " +
                     "skip and take may be used to enable pagination on "+ 
                     "photo list")]
        public XElement ListPhotos(string path, 
                                   int skip, 
                                   int take, 
                                   string method)
        {
            PhotoAlbum album = GetAlbum(path);

            if (album == null)
                return new XElement("photoAlbums", 
                                    new XAttribute("path", path));
            if (path == null)
                path = string.Empty;

            if (skip > album.Photos.Count)
                skip = 0;

            if (string.IsNullOrEmpty(method))
                method = "get";

            string parent = path.GetParent();

            string service = string.Empty;
            if (WebOperationContext.Current != null)
                service = WebOperationContext.Current
                                             .IncomingRequest
                                             .UriTemplateMatch
                                             .BaseUri.ToString();

            var folders = album.SubFolders;
            var photos = album.Photos.AsEnumerable();
            if (skip > 0)
                photos = photos.Skip(skip);
            if (take > 0)
                photos = photos.Take(take);

            using (var db = new PhotoTagsDataDataContext())
            {
                var tags = db.Tags.Select(t => t.Name).Distinct().AsEnumerable();

                var elm = new XElement("photoAlbums",
                    new XAttribute("path", path),
                    new XAttribute("service", service),
                    new XAttribute("parent", parent),
                    new XAttribute("skip", skip),
                    new XAttribute("take", take),
                    new XAttribute("total", album.Photos.Count),
                    new XAttribute("method", method),
                    folders.Select(a =>
                        new XElement("photoAlbum",
                            new XAttribute("name", a.Name),
                            new XAttribute("path", a.Path))),
                    tags.Select(t =>
                        new XElement("photoTag",
                            new XAttribute("name", t))),
                    photos.Select(p =>
                        new XElement("photo",
                            new XAttribute("name", p.ImageFileName),
                            new XAttribute("path", p.RelativePath),
                            new XAttribute("hash", p.ImagePathHash)))
                    );

                if (album.Photos.Count > skip + take)
                    elm.Add(new XAttribute("next", skip + take));
                if (skip > 0)
                    elm.Add(new XAttribute("prev", Math.Max(skip - take, 0)));

                return elm;
            }
        }

        /// <summary>
        /// Retrive XML of Tags
        /// </summary>
        /// <param name="take">Number of Elements to Take</param>
        /// <param name="method">Method to Link</param>
        /// <returns>XElement</returns>
        [OperationContract()]
        [WebGet(
            UriTemplate = "/tags?take={take}&method={method}",
            BodyStyle = WebMessageBodyStyle.Bare,
            ResponseFormat = WebMessageFormat.Xml
            )]
        [ContentType(ContentTypes.Text_XML)]
        [Description("list all tags.  skip and take may be used to enable " +
                     "pagination on photo list")]
        public XElement GetTag(int take, string method)
        {
            using (var db = new PhotoTagsDataDataContext())
            {

                if (take < 0) take = 0;
                else if (take == 0) take = 1000;

                var tags = db.Tags.GroupBy(t => t.Name).Select(t => new
                {
                    Name = t.Key,
                    Count = t.Count()
                });

                if (tags.Count() == 0)
                    return new XElement("photoAlbums");

                if (string.IsNullOrEmpty(method)) method = "get";
                string service = string.Empty;
                if (WebOperationContext.Current != null)
                    service = WebOperationContext.Current
                                                 .IncomingRequest
                                                 .UriTemplateMatch
                                                 .BaseUri
                                                 .ToString();

                var elm = new XElement("photoAlbums",
                    new XAttribute("service", service),
                    new XAttribute("parent", string.Empty),
                    new XAttribute("take", take),
                    new XAttribute("method", method),
                    tags.Select(t =>
                        new XElement("photoTag",
                            new XAttribute("name", t.Name),
                            new XAttribute("count", t.Count)
                            ))
                            );

                return elm;
            }
        }

        /// <remarks />
        [OperationContract()]
        [WebGet(
            UriTemplate = "/tags/list/{tag}?skip={skip}" +
                          "&take={take}&method={method}",
            BodyStyle = WebMessageBodyStyle.Bare,
            ResponseFormat = WebMessageFormat.Xml
            )]
        [ContentType(ContentTypes.Text_XML)]
        [Description("list all photos in the given tag.  skip and take " +
                     "may be used to enable pagination on photo list")]
        public XElement ListTagPhotos(string tag, 
                                      int skip, 
                                      int take, 
                                      string method)
        {
            using (var db = new PhotoTagsDataDataContext())
            {

                if (take < 0) take = 0;
                else if (take == 0) take = 1000;

                var tags = db.Tags.Select(t => t.Name).Distinct().AsEnumerable();
                var taggedPhotos = (from t in db.Tags
                                    join i in db.Images
                                        on t.ImageID equals i.ImageID
                                    where t.Name == tag
                                    select i);

                var totalCount = taggedPhotos.Count();
                if (skip > totalCount) skip = 0;

                var pagedPhotos = taggedPhotos.Skip(skip).Take(take);

                if (pagedPhotos.Count() == 0)
                    return new XElement("photoAlbums",
                                        new XAttribute("tags", tag));

                if (string.IsNullOrEmpty(method)) method = "get";
                string service = string.Empty;
                if (WebOperationContext.Current != null)
                    service = WebOperationContext.Current
                                                 .IncomingRequest
                                                 .UriTemplateMatch
                                                 .BaseUri.ToString();

                var elm = new XElement("photoAlbums",
                    new XAttribute("path", tag),
                    new XAttribute("service", service),
                    new XAttribute("parent", string.Empty),
                    new XAttribute("skip", skip),
                    new XAttribute("take", take),
                    new XAttribute("total", totalCount),
                    new XAttribute("method", method),
                    tags.Select(t =>
                        new XElement("photoTag",
                            new XAttribute("name", t))),
                    pagedPhotos.Select(p =>
                        new XElement("photo",
                            new XAttribute("name", p.Name),
                            new XAttribute("path", p.Folder),
                            new XAttribute("hash", p.ImageID)))
                    );

                if (totalCount > skip + take)
                    elm.Add(new XAttribute("next", skip + take));
                if (skip > 0)
                    elm.Add(new XAttribute("prev", Math.Max(skip - take, 0)));

                return elm;
            }
        }

        /// <remarks />
        [OperationContract()]
        [WebGet(
            UriTemplate = "/tags/view/{tag}?skip={skip}" +
                          "&take={take}&method={method}",
            BodyStyle = WebMessageBodyStyle.Bare,
            ResponseFormat = WebMessageFormat.Xml
            )]
        [ContentType(ContentTypes.Text_HTML)]
        [Description("transform the given photo album into a web page. skip " +
                     "and take may be used to enable pagination on photo " +
                     "list")]
        public Stream ViewTagPhotos(string tag, 
                                    int skip, 
                                    int take, 
                                    string method)
        {
            if (take == 0) take = 25;

            var ms = new MemoryStream();
            var xw = XmlWriter.Create(ms);
            using (var reader = new MemoryStream(Encoding.UTF8.GetBytes(
                    this.ListTagPhotos(tag, skip, take, method).ToString()
                )))
                "PhotoAlbums.xslt".TransformXML(reader, xw);
            ms.Seek(0, SeekOrigin.Begin);
            return ms;
        }

        /// <remarks />
        [OperationContract()]
        [WebGet(
            UriTemplate = "/view/{*path}?skip={skip}" +
                          "&take={take}&method={method}",
            BodyStyle = WebMessageBodyStyle.Bare,
            ResponseFormat = WebMessageFormat.Xml
            )]
        [ContentType(ContentTypes.Text_HTML)]
        [Description("transform the given photo album into a web page. skip " +
                     "and take may be used to enable pagination on photo " +
                     "list")]
        public Stream ViewPhotos(string path, 
                                 int skip, 
                                 int take, 
                                 string method)
        {
            if (take == 0) take = 25;

            var ms = new MemoryStream();
            var xw = XmlWriter.Create(ms);
            using (var reader = new MemoryStream(Encoding.UTF8.GetBytes(
                        this.ListPhotos(path, skip, take, method).ToString()
                    )))
                "PhotoAlbums.xslt".TransformXML(reader, xw);
            ms.Seek(0, SeekOrigin.Begin);
            return ms;
        }

        /// <remarks />
        [OperationContract()]
        [WebGet(
            UriTemplate = "/get/{hash}/{*path}?width={width}&height={height}",
            BodyStyle = WebMessageBodyStyle.Bare
            )]
        [ContentType(ContentTypes.Image_JPEG)]
        [Description("select an image using path and hash.  that image " +
                     "may be resized based on width and height")]
        public Stream GetPhoto(string path,
                               string hash,
                               int width,
                               int height)
        {
            RangeValue(ref width); RangeValue(ref height);

            return ResizePhoto(path, hash, width, height);
        }

        /// <remarks />
        [OperationContract()]
        [WebGet(
            UriTemplate = "/full/{hash}/{*path}",
            BodyStyle = WebMessageBodyStyle.Bare
            )]
        [ContentType(ContentTypes.Image_JPEG)]
        [Description("select an image using path and hash.  the image will " +
                     "be returned full size but will have better compression" +
                     " and will automaticly be rotated")]
        public Stream GetFullSize(string path, string hash)
        {
            return ResizePhoto(path, hash, 0, 0);
        }

        /// <remarks />
        [OperationContract()]
        [WebGet(
            UriTemplate = "/thumb/{hash}/{*path}",
            BodyStyle = WebMessageBodyStyle.Bare
            )]
        [ContentType(ContentTypes.Image_JPEG)]
        [Description("select an image using path and hash.  the image will " +
                     "be automaticly thumbnailed to the max of 200x200")]
        public Stream GetThumbnail(string path, string hash)
        {
            return GetPhoto(path, hash, 200, 200);
        }

        /// <remarks />
        [OperationContract()]
        [WebGet(
            UriTemplate = "/exif/{hash}/{*path}",
            BodyStyle = WebMessageBodyStyle.Bare
            )]
        [ContentType(ContentTypes.Text_XML)]
        public XElement GetExifData(string path, string hash)
        {
            var img = GetImage(hash, path);
            if (img == null || img.EXIF == null)
                return null;
            return img.EXIF.ToXml();
        }

        /// <remarks />
        [OperationContract()]
        [WebGet(
            UriTemplate = "/clear/{hash}/{*path}",
            BodyStyle = WebMessageBodyStyle.Bare
            )]
        [Description("clear the server side cache for a selected image " +
                     "using path and hash.")]
        public string ClearCache(string path, string hash)
        {
            var img = GetImage(hash, path);
            if (img == null)
                return "No Image Found";

            return img.ClearCache() ? "Success" : "Failed";
        }

        /// <remarks />
        [OperationContract()]
        [WebGet(
            UriTemplate = "/id/{hash}/{*path}",
            BodyStyle = WebMessageBodyStyle.Bare,
            ResponseFormat = WebMessageFormat.Xml
            )]
        [ContentType(ContentTypes.Text_XML)]
        public Guid GetID(string path, string hash)
        {
            var img = GetImage(hash, path);
            if (img == null)
                return Guid.Empty;
            return img.ID;
        }

        /// <remarks />
        [OperationContract()]
        [WebGet(
            UriTemplate = "/tag/get/{hash}/{*path}",
            BodyStyle = WebMessageBodyStyle.Bare
            )]
        [ContentType(ContentTypes.Text_XML)]
        public XElement GetTags(string path, string hash)
        {
            try
            {
                var img = GetImage(hash, path);
                if (img == null)
                    return null;

                return new XElement("tags",
                    new XAttribute("hash", hash),
                    new XAttribute("path", path),
                    new XAttribute("name", img.ImageFileName),
                    from t in img.Tags
                    select new XElement("tag",
                        new XAttribute("name", t.Name)
                        )
                    );
            }
            catch (Exception ex)
            {
                return new XElement("error", ex.ToString());
            }
        }

        /// <remarks />
        [OperationContract()]
        [WebGet(
            UriTemplate = "/tag/add/{tag}/{hash}/{*path}",
            BodyStyle = WebMessageBodyStyle.Bare
            )]
        [ContentType(ContentTypes.Text_XML)]
        public XElement AddTag(string path, string hash, string tag)
        {
            try
            {
                var img = GetImage(hash, path);
                if (img == null)
                    return null;

                img.AddTag(tag);

                return new XElement("tags",
                    new XAttribute("hash", hash),
                    new XAttribute("path", path),
                    new XAttribute("name", img.ImageFileName),
                    from t in img.Tags
                    select new XElement("tag",
                        new XAttribute("name", t.Name)
                        )
                    );
            }
            catch (Exception ex)
            {
                return new XElement("error", ex.ToString());
            }
        }

        /// <remarks />
        [OperationContract()]
        [WebGet(
            UriTemplate = "/tag/remove/{tag}/{hash}/{*path}",
            BodyStyle = WebMessageBodyStyle.Bare
            )]
        [ContentType(ContentTypes.Text_XML)]
        public XElement RemoveTag(string path, string hash, string tag)
        {
            try
            {
                var img = GetImage(hash, path);
                if (img == null)
                    return null;

                img.RemoveTag(tag);

                return new XElement("tags",
                    new XAttribute("hash", hash),
                    new XAttribute("path", path),
                    new XAttribute("name", img.ImageFileName),
                    from t in img.Tags
                    select new XElement("tag",
                        new XAttribute("name", t.Name)
                        )
                    );
            }
            catch (Exception ex)
            {
                return new XElement("error", ex.ToString());
            }
        }

        /// <remarks />
        [OperationContract()]
        [WebGet(
            UriTemplate = "/tag/all/{tag}/{*path}",
            BodyStyle = WebMessageBodyStyle.Bare
            )]
        [ContentType(ContentTypes.Text_XML)]
        public XElement AddAllTag(string path, string tag)
        {
            try
            {
                if (string.IsNullOrEmpty(tag))
                    return null;

                var imgs = GetAlbum(path);
                if (imgs == null && imgs.Photos.Count == 0)
                    return null;

                var folderTags = imgs.Photos.Select(i => new Tag() { 
                                                    ImageID = i.ID, 
                                                    Name = tag });
                var folderImgs = imgs.Photos.Select(i => new Image() { 
                                                    ImageID = i.ID, 
                                                    Folder = path, 
                                                    Name = i.ImageFileName });

                using (var db = new PhotoTagsDataDataContext())
                {

                    var currentImages = db.Images.Where(i => i.Folder == path);
                    var currentTags = currentImages.SelectMany(
                                                    i => i.Tags.Where(t => t.Name == tag)
                                                );

                    var newImgs = folderImgs.Except(currentImages,
                                                new Image.ImageCompare());
                    var newTags = folderTags.Except(currentTags,
                                                new Tag.TagCompare());

                    db.Images.InsertAllOnSubmit(newImgs);
                    db.Tags.InsertAllOnSubmit(newTags);
                    db.SubmitChanges(ConflictMode.FailOnFirstConflict);

                    return new XElement("tags",
                        new XAttribute("path", path),
                            new XAttribute("name", tag),
                            newImgs.Select(i =>
                                new XElement("image",
                                    new XAttribute("hash", i.ImageID),
                                    new XAttribute("path", i.Folder),
                                    new XAttribute("name", i.Name)
                        )));
                }
            }
            catch (Exception ex)
            {
                return new XElement("error", ex.ToString());
            }
        }
    }
}
