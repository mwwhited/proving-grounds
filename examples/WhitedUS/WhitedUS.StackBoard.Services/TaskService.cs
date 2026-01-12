using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WhitedUS.StackBoard.Data;
using WhitedUS.StackBoard.Models;

namespace WhitedUS.StackBoard.Services
{
    public class TaskService
    {
        public void Delete(TaskModel model)
        {
            using (var db = new StackBoardEntities())
            {
                var entity = db.Tasks
                               .Single(g => g.TaskID == model.TaskID);
                db.Tasks.DeleteObject(entity);
                db.SaveChanges();
            }
        }

        public int Save(TaskModel model)
        {
            return model.TaskID == -1
                ? Insert(model)
                : Update(model);
        }

        private int Update(TaskModel model)
        {
            using (var db = new StackBoardEntities())
            {
                var entity = db.Tasks
                               .Single(g => g.TaskID == model.TaskID);

                entity.Subject = model.Subject;
                entity.Description = model.Description;
                entity.ParentID = model.ParentID;
                entity.DueDate = model.DueDate;
                entity.CreatedDate = model.CreatedDate;
                entity.ModifiedDate = model.ModifiedDate;
                entity.MetaData = model.MetaData;
                entity.GroupID = model.GroupID;
                entity.TaskTypeID = model.TaskTypeID;
                entity.StateID = model.StateID;
                entity.PriorityID = model.PriorityID;

                db.SaveChanges();

                return model.TaskID = entity.TaskID;
            }
        }

        private int Insert(TaskModel model)
        {
            using (var db = new StackBoardEntities())
            {
                var entity = new Task
                {
                    Subject = model.Subject,
                    Description = model.Description,
                    ParentID = model.ParentID,
                    DueDate = model.DueDate,
                    CreatedDate = model.CreatedDate,
                    ModifiedDate = model.ModifiedDate,
                    MetaData = model.MetaData,
                    GroupID = model.GroupID,
                    TaskTypeID = model.TaskTypeID,
                    StateID = model.StateID,
                    PriorityID = model.PriorityID,
                };
                db.Tasks.AddObject(entity);
                db.SaveChanges();

                return model.TaskID = entity.TaskID;
            }
        }

        public IQueryable<TaskModel> List()
        {
            var db = new StackBoardEntities();

            var query = from entity in db.Tasks
                        select new TaskModel
                        {
                            TaskID = entity.TaskID,
                            Subject = entity.Subject,
                            Description = entity.Description,
                            ParentID = entity.ParentID,
                            DueDate = entity.DueDate,
                            CreatedDate = entity.CreatedDate,
                            ModifiedDate = entity.ModifiedDate,
                            MetaData = entity.MetaData,
                            GroupID = entity.GroupID,
                            TaskTypeID = entity.TaskTypeID,
                            StateID = entity.StateID,
                            PriorityID = entity.PriorityID,
                        };

            return query;
        }
    }
}
