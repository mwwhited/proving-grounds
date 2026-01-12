using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using WhitedUS.ImageStore.Data;

namespace WhitedUS.ImageStore.Services
{
    public class TileProvider
    {
        public XElement GetDeepZoomImage(int contentFrameID)
        {
            using (var db = ImageStoreEntities.Factory())
            {
                var result = string.Join("",db.GetDeepZoomImage(
                    Globals.TileSize,
                    Globals.Overlap,
                    Globals.Format,
                    contentFrameID));
                if (string.IsNullOrWhiteSpace(result))
                    return null;
                return XElement.Parse(result);
            }
        }

        public XElement GetDeepZoomCollection(int folderid, bool recursive)
        {
            using (var db = ImageStoreEntities.Factory())
            {
                var result = string.Join("", db.GetDeepZoomCollection(
                    Globals.TileSize,
                    Globals.Format,
                    folderid,
                    recursive,
                    null
                    ));
                if (string.IsNullOrWhiteSpace(result))
                    return null;
                return XElement.Parse(result);
            }
        }

        public XElement GetDeepZoomCollection(int contentItemID)
        {
            using (var db = ImageStoreEntities.Factory())
            {
                var result = string.Join("", db.GetDeepZoomCollection(
                    Globals.TileSize,
                    Globals.Format,
                    null,
                    null,
                    contentItemID
                    ));
                if (string.IsNullOrWhiteSpace(result))
                    return null;
                return XElement.Parse(result);
            }
        }
        public XElement GetDeepZoomCollection()
        {
            using (var db = ImageStoreEntities.Factory())
            {
                var result = string.Join("", db.GetDeepZoomCollection(
                    Globals.TileSize,
                    Globals.Format,
                    null,
                    null,
                    null
                    ));
                if (string.IsNullOrWhiteSpace(result))
                    return null;
                return XElement.Parse(result);
            }
        }
    }
}
