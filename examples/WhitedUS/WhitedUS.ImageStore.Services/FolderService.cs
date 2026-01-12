using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Transactions;
using WhitedUS.ImageStore.Data;
using WhitedUS.ImageStore.Models;

namespace WhitedUS.ImageStore.Services
{
    public class FolderService
    {
        public int Save(FolderModel model)
        {
            return model.FolderID == -1
                ? Insert(model)
                : Update(model);
        }

        private int Update(FolderModel model)
        {
            using (var db = ImageStoreEntities.Factory())
            {
                var entity = db.Folders
                               .Single(g => g.FolderID == model.FolderID);

                entity.Name = model.Name;
                entity.ParentFolderID = model.ParentID;
                entity.CreationTime = model.CreationTime;
                entity.LastAccessTime = model.LastAccessTime;
                entity.LastWriteTime = model.LastWriteTime;
                entity.MappedPath = model.MappedPath;

                db.SaveChanges();

                return model.FolderID = entity.FolderID;
            }
        }

        private int Insert(FolderModel model)
        {
            using (var db = ImageStoreEntities.Factory())
            {
                var entity = new Folder
                {
                    Name = model.Name,
                    ParentFolderID = model.ParentID,

                    CreationTime = model.CreationTime,
                    LastAccessTime = model.LastAccessTime,
                    LastWriteTime = model.LastWriteTime,

                    MappedPath = model.MappedPath,
                };
                db.Folders.AddObject(entity);
                db.SaveChanges();

                return model.FolderID = entity.FolderID;
            }
        }

        public void Delete(FolderModel model)
        {
            using (var db = ImageStoreEntities.Factory())
            {
                var entity = db.Folders
                               .Single(g => g.FolderID == model.FolderID);

                db.Folders.DeleteObject(entity);

                db.SaveChanges();
            }
        }

        public IQueryable<FolderModel> List()
        {
            var db = ImageStoreEntities.Factory();

            var query = from entity in db.Folders
                        select new FolderModel
                        {
                            FolderID = entity.FolderID,
                            ParentID = entity.ParentFolderID,
                            Name = entity.Name,
                            MappedPath = entity.MappedPath,
                            CreationTime = entity.CreationTime,
                            LastAccessTime = entity.LastAccessTime,
                            LastWriteTime = entity.LastWriteTime,
                        };

            return query;
        }
    }
}
