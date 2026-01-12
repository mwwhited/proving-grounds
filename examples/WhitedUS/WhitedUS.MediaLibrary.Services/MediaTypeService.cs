using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WhitedUS.MediaLibrary.Data;
using WhitedUS.MediaLibrary.Models;

namespace WhitedUS.MediaLibrary.Services
{
    public class MediaTypeService
    {
        public MediaTypeService()
        {
            this.ContextFactory = () => new MediaCollectionEntities();
        }

        private Func<MediaCollectionEntities> ContextFactory { get; set; }

        public MediaTypeModel Create()
        {
            var db = this.ContextFactory();

            var media = new MediaTypeModel
            {
            };

            return media;
        }

        public IQueryable<MediaTypeModel> List()
        {
            var db = this.ContextFactory();

            var query = from mediaType in db.MediaTypes
                        let codeTypes = from ct in db.CodeTypes
                                        select new CodeTypeSimpleModel
                                        {
                                            LocalID = ct.LocalID,
                                            Name = ct.Name,
                                            Url = ct.Url,
                                        }
                        let codeType = new CodeTypeSimpleModel
                        {
                            LocalID = mediaType.CodeType.LocalID,
                            Name = mediaType.CodeType.Name,
                            Url = mediaType.CodeType.Url,
                        }
                        select new MediaTypeModel
                        {
                            LocalID = mediaType.LocalID,
                            Name = mediaType.Name,
                            CodeTypeID = mediaType.CodeTypeID,

                            CodeType = codeType,
                            CodeTypes = codeTypes,
                        };
            return query;
        }

        public int Save(MediaTypeModel model)
        {
            if (model.LocalID == 0)
                return Insert(model);
            return Update(model);
        }

        public void Delete(MediaTypeModel model)
        {
            using (var db = this.ContextFactory())
            {
                var entity = db.MediaTypes
                               .Single(m => m.LocalID == model.LocalID);

                db.MediaTypes.DeleteObject(entity);

                db.SaveChanges();
            }
        }

        internal int Update(MediaTypeModel model)
        {
            using (var db = this.ContextFactory())
            {
                var entity = db.MediaTypes
                               .Single(m => m.LocalID == model.LocalID);

                entity.Name = model.Name;
                entity.CodeTypeID = model.CodeTypeID;

                db.SaveChanges();

                var result = entity.LocalID;
                return result;
            }
        }

        internal int Insert(MediaTypeModel model)
        {
            using (var db = this.ContextFactory())
            {
                var entity = new MediaType
                {
                    Name = model.Name,
                    CodeTypeID = model.CodeTypeID,
                };
                db.MediaTypes.AddObject(entity);

                db.SaveChanges();

                var result = entity.LocalID;
                return result;
            }
        }
    }
}
