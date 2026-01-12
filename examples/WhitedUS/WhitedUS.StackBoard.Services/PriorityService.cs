using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WhitedUS.StackBoard.Data;
using WhitedUS.StackBoard.Models;

namespace WhitedUS.StackBoard.Services
{
    public class PriorityService
    {
        public void Delete(PriorityModel model)
        {
            using (var db = new StackBoardEntities())
            {
                var entity = db.Priorities
                               .Single(g => g.PriorityID == model.PriorityID);
                db.Priorities.DeleteObject(entity);
                db.SaveChanges();
            }
        }

        public int Save(PriorityModel model)
        {
            return model.PriorityID == -1
                ? Insert(model)
                : Update(model);
        }

        private int Update(PriorityModel model)
        {
            using (var db = new StackBoardEntities())
            {
                var entity = db.Priorities
                               .Single(g => g.PriorityID == model.PriorityID);

                entity.Name = model.Name;
                entity.Description = model.Description;
                entity.Weight = model.Weight;

                db.SaveChanges();

                return model.PriorityID = entity.PriorityID;
            }
        }

        private int Insert(PriorityModel model)
        {
            using (var db = new StackBoardEntities())
            {
                var entity = new Priority
                {
                    Name = model.Name,
                    Description = model.Description,
                    Weight = model.Weight,
                };
                db.Priorities.AddObject(entity);
                db.SaveChanges();

                return model.PriorityID = entity.PriorityID;
            }
        }

        public IQueryable<PriorityModel> List()
        {
            var db = new StackBoardEntities();

            var query = from entity in db.Priorities
                        select new PriorityModel
                        {
                            PriorityID = entity.PriorityID,
                            Name = entity.Name,
                            Description = entity.Description,
                            Weight = entity.Weight,
                        };

            return query;
        }
    }
}
