using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using System.ServiceModel.Web;
using System.IO;
using System.ServiceModel;
using WhitedUS.ImageStore.Services;

namespace WhitedUS.ImageStore.ServiceModel
{
    [ServiceContract]
    public class TileService
    {
        public TileService()
        {
            this.TileProvider = new TileProvider();
        }

        private TileProvider TileProvider { get; set; }

        [WebGet(UriTemplate = "Tiles/All.dzc")]
        [OperationContract]
        public XElement GetAllDzc()
        {
            return this.TileProvider.GetDeepZoomCollection();
        }
        [WebGet(UriTemplate = "Tiles/All/{level}/{x}_{y}.{ext}")]
        [OperationContract]
        public Stream GetAllDzcTile(string level, string x, string y, string ext)
        {
            throw new NotImplementedException();
        }

        [WebGet(UriTemplate = "Folder/{folderid}.dzc?includeChildren={includeChildren}")]
        [OperationContract]
        public XElement GetFolderDzc(string folderid, bool includeChildren = true)
        {
            return this.TileProvider.GetDeepZoomCollection(int.Parse(folderid), includeChildren);
        }
        [WebGet(UriTemplate = "Tiles/Folder/{folderid}/{level}/{x}_{y}.{ext}?includeChildren={includeChildren}")]
        [OperationContract]
        public Stream GetFolderDzcTile(string folderid, string level, string x, string y, string ext, bool includeChildren = true)
        {
            throw new NotImplementedException();
        }

        [WebGet(UriTemplate = "Content/{contentid}.dzc")]
        [OperationContract]
        public XElement GetContentDzc(string contentid)
        {
            return this.TileProvider.GetDeepZoomCollection(int.Parse(contentid));
        }
        [WebGet(UriTemplate = "Tiles/Content/{contentid}/{level}/{x}_{y}.{ext}")]
        [OperationContract]
        public Stream GetContentDzcTile(string contentid, string level, string x, string y, string ext)
        {
            throw new NotImplementedException();
        }

        [WebGet(UriTemplate = "Frame/{frameid}.dzi")]
        [OperationContract]
        public XElement GetContentDzi(string frameid)
        {
            return this.TileProvider.GetDeepZoomImage(int.Parse(frameid));
        }
        [WebGet(UriTemplate = "Tiles/Frame/{frameid}/{level}/{x}_{y}.{ext}")]
        [OperationContract]
        public Stream GetContentDziTile(string frameid, string level, string x, string y, string ext)
        {
            throw new NotImplementedException();
        }
    }
}
