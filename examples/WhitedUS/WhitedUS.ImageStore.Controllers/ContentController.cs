using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using WhitedUS.Drawing;
using WhitedUS.ImageStore.Services;

namespace WhitedUS.ImageStore.Controllers
{
    public class ContentController : Controller
    {
        public ContentController()
        {
            this.ContentItemService = new ContentItemService();
            this.ContentTypeService = new ContentTypeService();
        }

        private ContentItemService ContentItemService { get; set; }
        private ContentTypeService ContentTypeService { get; set; }

        public ActionResult Index()
        {
            return this.View();
        }

        public ActionResult List(int? id)
        {
            var query = this.ContentItemService.List();

            if (id.HasValue)
                query = query.Where(q => q.FolderID == id);

            return this.View(query);
        }

        public ActionResult Item(int id, int? maxsize)
        {
            var model = this.ContentItemService.Get(id);
            var type = this.ContentTypeService.List().First(m => m.ContentTypeID == model.ContentTypeID);

            if (type.MimeType.StartsWith("image/", StringComparison.InvariantCulture))
            {
                var buffer = maxsize.HasValue ? model.Data.AutoRotate().Resize(maxsize.Value) : model.Data.AutoRotate();
                return this.File(buffer, type.MimeType);
            }

            return this.File(model.Data, type.MimeType);
        }
    }
}
