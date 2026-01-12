using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WhitedUS.ImageStore.Data;
using WhitedUS.ImageStore.Models;

namespace WhitedUS.ImageStore.Services
{
    public class ContentTileService
    {
        public long Save(ContentTileModel model)
        {
            return model.ContentTileID == -1
                ? Insert(model)
                : Update(model);
        }

        private long Update(ContentTileModel model)
        {
            using (var db = ImageStoreEntities.Factory())
            {
                var entity = db.ContentTiles
                               .Single(g => g.ContentTileID == model.ContentTileID);

                entity.Data = model.Data;
                entity.ContentTypeID = model.ContentTypeID;
                entity.ContentFrameID = model.ContentFrameID;
                entity.X = model.X;
                entity.Y = model.Y;
                entity.Level = model.Level;

                db.SaveChanges();

                return model.ContentTileID = entity.ContentTileID;
            }
        }

        private long Insert(ContentTileModel model)
        {
            using (var db = ImageStoreEntities.Factory())
            {
                var entity = new ContentTile
                {
                    Data = model.Data,
                    ContentTypeID = model.ContentTypeID,
                    ContentFrameID = model.ContentFrameID,
                    X = model.X,
                    Y = model.Y,
                    Level = model.Level,
                };
                db.ContentTiles.AddObject(entity);
                db.SaveChanges();

                return model.ContentTileID = entity.ContentTileID;
            }
        }

        public void Delete(ContentTileModel model)
        {
            using (var db = ImageStoreEntities.Factory())
            {
                var entity = db.ContentTiles
                               .Single(g => g.ContentTileID == model.ContentTileID);

                db.ContentTiles.DeleteObject(entity);

                db.SaveChanges();
            }
        }

        public IQueryable<ContentTileSimpleModel> List()
        {
            var db = ImageStoreEntities.Factory();

            var query = from entity in db.ContentTiles
                        select new ContentTileSimpleModel
                        {
                            ContentTileID = entity.ContentTileID,
                            LastWriteTime = entity.LastWriteTime,
                            //Data = entity.Data,
                            ContentTypeID = entity.ContentTypeID,
                            ContentFrameID = entity.ContentFrameID,
                            X = entity.X,
                            Y = entity.Y,
                            Level = entity.Level,
                            Length = entity.Length ?? 0,
                        };

            return query;
        }

        public ContentTileModel Get(long contentTileID)
        {
            var db = ImageStoreEntities.Factory();

            var query = from e in db.ContentTiles
                        select new ContentTileModel
                        {
                            ContentTileID = e.ContentTileID,
                            LastWriteTime = e.LastWriteTime,
                            Data = e.Data,
                            ContentTypeID = e.ContentTypeID,
                            ContentFrameID = e.ContentFrameID,
                            X = e.X,
                            Y = e.Y,
                            Level = e.Level,
                            Length = e.Length ?? 0,
                        };

            var entity = query.Single(e => e.ContentTileID == contentTileID);

            return entity;
        }

        public ContentTileModel Get(int contentFrameID, int level, int x, int y)
        {
            var db = ImageStoreEntities.Factory();

            var query = from e in db.ContentTiles
                        select new ContentTileModel
                        {
                            ContentTileID = e.ContentTileID,
                            LastWriteTime = e.LastWriteTime,
                            Data = e.Data,
                            ContentTypeID = e.ContentTypeID,
                            ContentFrameID = e.ContentFrameID,
                            X = e.X,
                            Y = e.Y,
                            Level = e.Level,
                        };

            var entity = query.SingleOrDefault(e =>
                    e.ContentFrameID == contentFrameID
                    && e.X == x
                    && e.Y == y
                    && e.Level == level
                );

            return entity;
        }
    }
}
