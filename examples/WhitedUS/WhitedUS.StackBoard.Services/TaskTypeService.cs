using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WhitedUS.StackBoard.Models;
using WhitedUS.StackBoard.Data;

namespace WhitedUS.StackBoard.Services
{
    public class TaskTypeService
    {
        public void Delete(TaskTypeModel model)
        {
            using (var db = new StackBoardEntities())
            {
                var entity = db.TaskTypes
                               .Single(g => g.TaskTypeID == model.TaskTypeID);
                db.TaskTypes.DeleteObject(entity);
                db.SaveChanges();
            }
        }

        public int Save(TaskTypeModel model)
        {
            return model.TaskTypeID == -1
                ? Insert(model)
                : Update(model);
        }

        private int Update(TaskTypeModel model)
        {
            using (var db = new StackBoardEntities())
            {
                var entity = db.TaskTypes
                               .Single(g => g.TaskTypeID == model.TaskTypeID);

                entity.Name = model.Name;
                entity.Description = model.Description;
                entity.HandlerType = model.HandlerType;
                entity.Configuration = model.Configuration;

                db.SaveChanges();

                return model.TaskTypeID = entity.TaskTypeID;
            }
        }

        private int Insert(TaskTypeModel model)
        {
            using (var db = new StackBoardEntities())
            {
                var entity = new TaskType
                {
                    Name = model.Name,
                    Description = model.Description,
                    HandlerType = model.HandlerType,
                    Configuration = model.Configuration,
                };
                db.TaskTypes.AddObject(entity);
                db.SaveChanges();

                return model.TaskTypeID = entity.TaskTypeID;
            }
        }

        public IQueryable<TaskTypeModel> List()
        {
            var db = new StackBoardEntities();

            var query = from entity in db.TaskTypes
                        select new TaskTypeModel
                        {
                            TaskTypeID = entity.TaskTypeID,
                            Name = entity.Name,
                            Description = entity.Description,
                            HandlerType = entity.HandlerType,
                            Configuration = entity.Configuration,
                        };

            return query;
        }
    }
}
