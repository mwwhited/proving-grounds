using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WhitedUS.StackBoard.Data;
using WhitedUS.StackBoard.Models;

namespace WhitedUS.StackBoard.Services
{
    public class StateService
    {
        public void Delete(StateModel model)
        {
            using (var db = new StackBoardEntities())
            {
                var entity = db.States
                               .Single(g => g.StateID == model.StateID);
                db.States.DeleteObject(entity);
                db.SaveChanges();
            }
        }

        public int Save(StateModel model)
        {
            return model.StateID == -1
                ? Insert(model)
                : Update(model);
        }

        private int Update(StateModel model)
        {
            using (var db = new StackBoardEntities())
            {
                var entity = db.States
                               .Single(g => g.StateID == model.StateID);

                entity.Name = model.Name;
                entity.Description = model.Description;
                entity.TaskTypeID = model.TaskTypeID;

                db.SaveChanges();

                return model.StateID = entity.StateID;
            }
        }

        private int Insert(StateModel model)
        {
            using (var db = new StackBoardEntities())
            {
                var entity = new State
                {
                    Name = model.Name,
                    Description = model.Description,
                    TaskTypeID = model.TaskTypeID,
                };
                db.States.AddObject(entity);
                db.SaveChanges();

                return model.StateID = entity.StateID;
            }
        }

        public IQueryable<StateModel> List()
        {
            var db = new StackBoardEntities();

            var query = from entity in db.States
                        select new StateModel
                        {
                            StateID = entity.StateID,
                            Name = entity.Name,
                            Description = entity.Description,
                            TaskTypeID = entity.TaskTypeID,
                        };

            return query;
        }
    }
}
