using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using WhitedUS.ImageStore.Services;
using WhitedUS.ImageStore.Models;

namespace WhitedUS.ImageStore.Controllers
{
    public class FolderWithChildrenModel
    {
        public int FolderID { get; set; }
        public int? ParentID { get; set; }
        public string Name { get; set; }
        public DateTime CreationTime { get; set; }
        public DateTime LastAccessTime { get; set; }
        public DateTime LastWriteTime { get; set; }
        public string MappedPath { get; set; }


        public FolderWithChildrenModel(FolderModel model, IEnumerable<FolderModel> items)
        {
            this.FolderID = model.FolderID;
            this.ParentID = model.ParentID;
            this.Name = model.Name;
            this.CreationTime = model.CreationTime;
            this.LastAccessTime = model.LastAccessTime;
            this.LastWriteTime = model.LastWriteTime;
            this.MappedPath = model.MappedPath;
            this.Children = (from item in items
                             where item.ParentID == model.FolderID
                             select new FolderWithChildrenModel(item, items)).ToList();
        }

        public IEnumerable<FolderWithChildrenModel> Children { get; set; }
    }

    public class FolderController : Controller
    {
        public FolderController()
        {
            this.FolderService = new FolderService();
        }

        private FolderService FolderService { get; set; }

        public ActionResult Index()
        {
            var items = this.FolderService.List().ToList();
            var root = items.SingleOrDefault(r => r.ParentID == null);

            var model = new FolderWithChildrenModel(root, items);

            return this.View(model);
        }

        public ActionResult List()
        {
            var model = this.FolderService.List();
            return this.View(model);
        }

        //[ChildActionOnly]
        //public ActionResult Tree()
        //{
        //    var root = this.FolderService
        //                   .List()
        //                   .SingleOrDefault(r => r.ParentID == null);

        //    var model = new FolderWithChildrenModel(root, this.FolderService);

        //    return this.View(root);
        //}
    }
}
