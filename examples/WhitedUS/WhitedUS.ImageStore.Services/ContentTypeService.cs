using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WhitedUS.ImageStore.Data;
using WhitedUS.ImageStore.Models;

namespace WhitedUS.ImageStore.Services
{
    public class ContentTypeService
    {
        public int Save(ContentTypeModel model)
        {
            return model.ContentTypeID == -1
                ? Insert(model)
                : Update(model);
        }

        private int Update(ContentTypeModel model)
        {
            using (var db = ImageStoreEntities.Factory())
            {
                var entity = db.ContentTypes
                               .Single(g => g.ContentTypeID == model.ContentTypeID);
                
                entity.Name = model.Name;
                entity.Description = model.Description;
                entity.Extension = model.Extension;
                entity.MimeType = model.MimeType;
                entity.IsSingleFrame = model.IsSingleFrame;

                db.SaveChanges();

                return model.ContentTypeID = entity.ContentTypeID;
            }
        }

        private int Insert(ContentTypeModel model)
        {
            using (var db = ImageStoreEntities.Factory())
            {
                var entity = new ContentType
                {
                    Name = model.Name,
                    Description = model.Description,
                    Extension = model.Extension,
                    MimeType = model.MimeType,
                    IsSingleFrame = model.IsSingleFrame,
                };
                db.ContentTypes.AddObject(entity);
                db.SaveChanges();

                return model.ContentTypeID = entity.ContentTypeID;
            }
        }

        public void Delete(ContentTypeModel model)
        {
            using (var db = ImageStoreEntities.Factory())
            {
                var entity = db.ContentTypes
                               .Single(g => g.ContentTypeID == model.ContentTypeID);

                db.ContentTypes.DeleteObject(entity);

                db.SaveChanges();
            }
        }

        public IQueryable<ContentTypeModel> List()
        {
            var db = ImageStoreEntities.Factory();

            var query = from entity in db.ContentTypes
                        select new ContentTypeModel
                        {
                            ContentTypeID = entity.ContentTypeID,
                            Name = entity.Name,
                            Description = entity.Description,
                            Extension = entity.Extension,
                            MimeType = entity.MimeType,
                            IsSingleFrame = entity.IsSingleFrame,
                        };

            return query;
        }
    }
}
