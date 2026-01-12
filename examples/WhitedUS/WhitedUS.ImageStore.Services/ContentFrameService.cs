using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WhitedUS.ImageStore.Data;
using WhitedUS.ImageStore.Models;

namespace WhitedUS.ImageStore.Services
{
    public class ContentFrameService
    {
        public int Save(ContentFrameModel model)
        {
            return model.ContentFrameID == -1
                ? Insert(model)
                : Update(model);
        }

        private int Update(ContentFrameModel model)
        {
            using (var db = ImageStoreEntities.Factory())
            {
                var entity = db.ContentFrames
                               .Single(g => g.ContentFrameID == model.ContentFrameID);

                entity.Data = model.Data;
                entity.ContentTypeID = model.ContentTypeID;
                entity.ContentItemID = model.ContentItemID;
                entity.Index = model.Index;
                entity.Width = model.Width;
                entity.Height = model.Height;

                db.SaveChanges();

                return model.ContentFrameID = entity.ContentFrameID;
            }
        }

        private int Insert(ContentFrameModel model)
        {
            using (var db = ImageStoreEntities.Factory())
            {
                var entity = new ContentFrame
                {
                    ContentItemID = model.ContentItemID,
                    Data = model.Data,
                    ContentTypeID = model.ContentTypeID,
                    Index = model.Index,
                    Width = model.Width,
                    Height = model.Height,
                };
                db.ContentFrames.AddObject(entity);
                db.SaveChanges();

                return model.ContentFrameID = entity.ContentFrameID;
            }
        }

        public void Delete(ContentFrameModel model)
        {
            using (var db = ImageStoreEntities.Factory())
            {
                var entity = db.ContentFrames
                               .Single(g => g.ContentFrameID == model.ContentFrameID);

                db.ContentFrames.DeleteObject(entity);

                db.SaveChanges();
            }
        }

        public IQueryable<ContentFrameSimpleModel> List()
        {
            var db = ImageStoreEntities.Factory();

            var query = from entity in db.ContentFrames
                        select new ContentFrameSimpleModel
                        {
                            ContentFrameID = entity.ContentFrameID,
                            LastWriteTime = entity.LastWriteTime,
                            //Data = entity.Data,
                            ContentTypeID = entity.ContentTypeID,
                            ContentItemID = entity.ContentItemID,

                            Index = entity.Index,
                            Width = entity.Width,
                            Height = entity.Height,
                            Length = entity.Length ?? 0,
                        };

            return query;
        }

        public ContentFrameModel Get(int contentFrameID)
        {
            using (var db = ImageStoreEntities.Factory())
            {

                var query = from e in db.ContentFrames
                            select new ContentFrameModel
                            {
                                ContentFrameID = e.ContentFrameID,
                                LastWriteTime = e.LastWriteTime,
                                Data = e.Data,
                                ContentTypeID = e.ContentTypeID,
                                ContentItemID = e.ContentItemID,

                                Index = e.Index,
                                Width = e.Width,
                                Height = e.Height,
                                Length = e.Length ?? 0,
                            };

                var entity = query.Single(e => e.ContentFrameID == contentFrameID);
                return entity;
            }
        }
    }
}
