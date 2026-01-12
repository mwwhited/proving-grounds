using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WhitedUS.ImageStore.Models;
using WhitedUS.ImageStore.Data;

namespace WhitedUS.ImageStore.Services
{
    public class ContentItemService
    {
        public int Save(ContentItemModel model)
        {
            return model.ContentItemID == -1
                ? Insert(model)
                : Update(model);
        }

        private int Update(ContentItemModel model)
        {
            using (var db = ImageStoreEntities.Factory())
            {
                var entity = db.ContentItems
                               .Single(g => g.ContentItemID == model.ContentItemID);

                entity.Name = model.Name;
                entity.Description = model.Description;
                entity.CreationTime = model.CreationTime;
                entity.LastAccessTime = model.LastAccessTime;
                entity.LastWriteTime = model.LastWriteTime;
                entity.Data = model.Data;
                entity.ContentTypeID = model.ContentTypeID;
                entity.FolderID = model.FolderID;

                db.SaveChanges();

                return model.ContentItemID = entity.ContentItemID;
            }
        }

        private int Insert(ContentItemModel model)
        {
            using (var db = ImageStoreEntities.Factory())
            {
                var entity = new ContentItem
                {
                    Name = model.Name,
                    Description = model.Description,
                    CreationTime = model.CreationTime,
                    LastAccessTime = model.LastAccessTime,
                    LastWriteTime = model.LastWriteTime,
                    Data = model.Data,
                    ContentTypeID = model.ContentTypeID,
                    FolderID = model.FolderID,
                };
                db.ContentItems.AddObject(entity);
                db.SaveChanges();

                return model.ContentItemID = entity.ContentItemID;
            }
        }

        public void Delete(ContentItemModel model)
        {
            using (var db = ImageStoreEntities.Factory())
            {
                var entity = db.ContentItems
                               .Single(g => g.ContentItemID == model.ContentItemID);

                db.ContentItems.DeleteObject(entity);

                db.SaveChanges();
            }
        }

        public IQueryable<ContentItemSimpleModel> List()
        {
            var db = ImageStoreEntities.Factory();

            var query = from entity in db.ContentItems
                        select new ContentItemSimpleModel
                        {
                            ContentItemID = entity.ContentItemID,
                            Name = entity.Name,
                            Description = entity.Description,
                            CreationTime = entity.CreationTime,
                            LastAccessTime = entity.LastAccessTime,
                            LastWriteTime = entity.LastWriteTime,
                            //Data = entity.Data,
                            FolderID = entity.FolderID,
                            ContentTypeID = entity.ContentTypeID,
                            Length = entity.Length ?? 0,
                        };

            return query;
        }

        public ContentItemModel Get(int contentItemID)
        {
            using (var db = ImageStoreEntities.Factory())
            {

                var query = from e in db.ContentItems
                            select new ContentItemModel
                            {
                                ContentItemID = e.ContentItemID,
                                Name = e.Name,
                                Description = e.Description,
                                CreationTime = e.CreationTime,
                                LastAccessTime = e.LastAccessTime,
                                LastWriteTime = e.LastWriteTime,
                                Data = e.Data,
                                FolderID = e.FolderID,
                                ContentTypeID = e.ContentTypeID,
                                Length = e.Length ?? 0,
                            };

                var entity = query.Single(e => e.ContentItemID == contentItemID);

                db.ContentItemTouch(contentItemID);
                db.SaveChanges();

                return entity;
            }
        }
    }
}
