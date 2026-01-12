using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using WhitedUS.StackBoard.Data;
using WhitedUS.StackBoard.Models;

namespace WhitedUS.StackBoard.Services
{
    public class GroupService
    {
        public void Delete(GroupModel model)
        {
            using (var db = new StackBoardEntities())
            {
                var entity = db.Groups
                               .Single(g => g.GroupID == model.GroupID);
                db.Groups.DeleteObject(entity);
                db.SaveChanges();
            }
        }

        public int Save(GroupModel model)
        {
            return model.GroupID == -1
                ? Insert(model)
                : Update(model);
        }

        private int Update(GroupModel model)
        {
            using (var db = new StackBoardEntities())
            {
                var entity = db.Groups
                               .Single(g => g.GroupID == model.GroupID);

                entity.ParentID = model.ParentID;
                entity.Name = model.Name;
                entity.Description = model.Description;

                db.SaveChanges();

                return model.GroupID = entity.GroupID;
            }
        }

        private int Insert(GroupModel model)
        {
            using (var db = new StackBoardEntities())
            {
                var entity = new Group
                {
                    //GroupID = model.GroupID,
                    ParentID = model.ParentID,
                    Name = model.Name,
                    Description = model.Description,
                };
                db.Groups.AddObject(entity);
                db.SaveChanges();

                return model.GroupID = entity.GroupID;
            }
        }

        public IQueryable<GroupModel> List()
        {
            var db = new StackBoardEntities();

            var query = from grp in db.Groups
                        select new GroupModel
                        {
                            GroupID = grp.GroupID,
                            Name = grp.Name,
                            Description = grp.Description,
                            ParentID = grp.ParentID,
                        };

            return query;
        }

        public IQueryable<GroupModel> ListBranch(int groupid)
        {
            var db = new StackBoardEntities();

            var commandText = @"
SELECT [GroupID]
      ,[HId]
      ,[Name]
      ,[Description]
      ,[HIdString]
      ,[HIdLevel]
      ,[ParentID]
  FROM [Groups_GetByDescendantOf]({0})
";

            var resultSet = db.ExecuteStoreQuery<Group>(commandText, (object)groupid);

            var query = from grp in resultSet
                        select new GroupModel
                        {
                            GroupID = grp.GroupID,
                            Name = grp.Name,
                            Description = grp.Description,
                            ParentID = grp.ParentID,
                        };

            return query.AsQueryable();
        }

        public XElement ExportXml()
        {
            using (var db = new StackBoardEntities())
            {
                var result = db.GroupExport().Single();
                var xml = XElement.Parse(result);
                return xml;
            }
        } 
    }
}
