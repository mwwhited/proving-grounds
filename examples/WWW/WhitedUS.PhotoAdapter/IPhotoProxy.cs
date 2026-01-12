using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using System.Xml.Linq;

namespace WhitedUS.PhotoAdapter
{
    [ServiceContract]
    [XmlSerializerFormat]
    public interface IPhotoProxy
    {
        [OperationContract()]
        [WebGet(
            UriTemplate = "/list/{*path}?skip={skip}&take={take}&method={method}",
            BodyStyle = WebMessageBodyStyle.Bare,
            ResponseFormat = WebMessageFormat.Xml
            )]
        PhotoAlbums ListPhotos(string path, int skip, int take, string method);

        [OperationContract()]
        [WebGet(
            UriTemplate = "/tags?take={take}&method={method}",
            BodyStyle = WebMessageBodyStyle.Bare,
            ResponseFormat = WebMessageFormat.Xml
            )]
        PhotoAlbums GetTag(int take, string method);

        [OperationContract()]
        [WebGet(
            UriTemplate = "/tags/list/{tag}?skip={skip}&take={take}&method={method}",
            BodyStyle = WebMessageBodyStyle.Bare,
            ResponseFormat = WebMessageFormat.Xml
            )]
        PhotoAlbums ListTagPhotos(string tag, int skip, int take, string method);

        [OperationContract()]
        [WebGet(
            UriTemplate = "/get/{hash}/{*path}?width={width}&height={height}",
            BodyStyle = WebMessageBodyStyle.Bare
            )]
        Stream GetPhoto(string path, string hash, int width, int height);

        [OperationContract()]
        [WebGet(
            UriTemplate = "/tag/add/{tag}/{hash}/{*path}",
            BodyStyle = WebMessageBodyStyle.Bare
            )]
        PhotoTags AddTag(string path, string hash, string tag);

        [OperationContract()]
        [WebGet(
            UriTemplate = "/tag/get/{hash}/{*path}",
            BodyStyle = WebMessageBodyStyle.Bare
            )]
        PhotoTags GetTags(string path, string hash);

        [OperationContract()]
        [WebGet(
            UriTemplate = "/tag/remove/{tag}/{hash}/{*path}",
            BodyStyle = WebMessageBodyStyle.Bare
            )]
        PhotoTags RemoveTag(string path, string hash, string tag);

        [OperationContract()]
        [WebGet(
            UriTemplate = "/tag/all/{tag}/{*path}",
            BodyStyle = WebMessageBodyStyle.Bare
            )]
        PhotoTags AddAllTag(string path, string tag);
    }
}
