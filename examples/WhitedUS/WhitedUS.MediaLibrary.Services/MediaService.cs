using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Linq;
using System.Text;
using WhitedUS.MediaLibrary.Data;
using WhitedUS.MediaLibrary.Models;

namespace WhitedUS.MediaLibrary.Services
{
    public class MediaService
    {
        public MediaService()
        {
            this.ContextFactory = () => new MediaCollectionEntities();
        }

        private Func<MediaCollectionEntities> ContextFactory { get; set; }

        public MediaModel Create()
        {
            var db = this.ContextFactory();

            var media = new MediaModel
            {
                Have = true,

                MediaTypes = from mediaType in db.MediaTypes
                             select new MediaTypeSimpleModel
                             {
                                 LocalID = mediaType.LocalID,
                                 Name = mediaType.Name,
                             },
            };

            return media;
        }

        public IQueryable<MediaModel> List()
        {
            var db = this.ContextFactory();

            var query = from media in db.Media
                        let mediaType = new MediaTypeSimpleModel
                        {
                            LocalID = media.MediaType.LocalID,
                            Name = media.MediaType.Name,
                        }
                        let codeType = new CodeTypeSimpleModel
                        {
                            LocalID = media.MediaType.CodeType.LocalID,
                            Name = media.MediaType.CodeType.Name,
                            Url = media.MediaType.CodeType.Url,
                        }
                        let mediaTypes = from mt in db.MediaTypes
                                         select new MediaTypeSimpleModel
                                         {
                                             LocalID = mt.LocalID,
                                             Name = mt.Name,
                                         }
                        select new MediaModel
                        {
                            LocalID = media.LocalID,
                            Title = media.Title,
                            BoxTitle = media.BoxTitle,
                            Code = media.Code,
                            DiskNumber = media.DiskNumber,
                            Format = media.Format,
                            Have = media.Have,
                            Length = media.Length,
                            Notes = media.Notes,
                            Rating = media.Rating,
                            Year = media.Year,

                            MediaTypeID = media.MediaTypeID,

                            MediaType = mediaType,
                            CodeType = codeType,
                            MediaTypes = mediaTypes,
                        };
            return query;
        }

        public int Save(MediaModel model)
        {
            if (model.LocalID == 0)
                return Insert(model);
            return Update(model);
        }

        public void Delete(MediaModel model)
        {
            using (var db = this.ContextFactory())
            {
                var entity = db.Media
                               .Single(m => m.LocalID == model.LocalID);

                db.Media.DeleteObject(entity);

                db.SaveChanges();
            }
        }

        internal int Update(MediaModel model)
        {
            using (var db = this.ContextFactory())
            {
                var entity = db.Media
                               .Single(m => m.LocalID == model.LocalID);

                entity.BoxTitle = model.BoxTitle;
                entity.Code = model.Code;
                entity.DiskNumber = model.DiskNumber;
                entity.Format = model.Format;
                entity.Have = model.Have;
                entity.Length = model.Length;
                entity.MediaTypeID = model.MediaTypeID;
                entity.Notes = model.Notes;
                entity.Rating = model.Rating;
                entity.Title = model.Title;
                entity.Year = model.Year;

                db.SaveChanges();

                var result = entity.LocalID;
                return result;
            }
        }

        internal int Insert(MediaModel model)
        {
            using (var db = this.ContextFactory())
            {
                var entity = new Medium
                {
                    BoxTitle = model.BoxTitle,
                    Code = model.Code,
                    DiskNumber = model.DiskNumber,
                    Format = model.Format,
                    Have = model.Have,
                    Length = model.Length,
                    MediaTypeID = model.MediaTypeID,
                    Notes = model.Notes,
                    Rating = model.Rating,
                    Title = model.Title,
                    Year = model.Year,
                };
                db.Media.AddObject(entity);

                db.SaveChanges();

                var result = entity.LocalID;
                return result;
            }
        }
    }
}
