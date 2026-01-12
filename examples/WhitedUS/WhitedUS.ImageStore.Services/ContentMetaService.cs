using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WhitedUS.ImageStore.Data;
using WhitedUS.ImageStore.Models;

namespace WhitedUS.ImageStore.Services
{
    public class ContentMetaService
    {
        public long Save(ContentMetaModel model)
        {
            return model.ContentMetaID == -1
                ? Insert(model)
                : Update(model);
        }

        private long Update(ContentMetaModel model)
        {
            using (var db = ImageStoreEntities.Factory())
            {
                var entity = db.ContentMetaDatas
                               .Single(g => g.ContentMetaID == model.ContentMetaID);

                entity.Name = model.Name;
                entity.Value = model.Value;
                entity.ContentItemID = model.ContentItemID;

                db.SaveChanges();

                return model.ContentMetaID = entity.ContentMetaID;
            }
        }

        private long Insert(ContentMetaModel model)
        {
            using (var db = ImageStoreEntities.Factory())
            {
                var entity = new ContentMetaData
                {
                    Name = model.Name,
                    Value = model.Value,
                    ContentItemID = model.ContentItemID,
                };
                db.ContentMetaDatas.AddObject(entity);
                db.SaveChanges();

                return model.ContentMetaID = entity.ContentMetaID;
            }
        }

        public void Delete(ContentMetaModel model)
        {
            using (var db = ImageStoreEntities.Factory())
            {
                var entity = db.ContentMetaDatas
                               .Single(g => g.ContentMetaID == model.ContentMetaID);

                db.ContentMetaDatas.DeleteObject(entity);

                db.SaveChanges();
            }
        }

        public IQueryable<ContentMetaModel> List()
        {
            var db = ImageStoreEntities.Factory();

            var query = from entity in db.ContentMetaDatas
                        select new ContentMetaModel
                        {
                            Name = entity.Name,
                            Value = entity.Value,
                            ContentItemID = entity.ContentItemID,
                            ContentMetaID = entity.ContentMetaID,
                            CreationDate = entity.CreationDate,
                            LastWriteDate = entity.LastWriteDate,
                        };

            return query;
        }
    }
}
