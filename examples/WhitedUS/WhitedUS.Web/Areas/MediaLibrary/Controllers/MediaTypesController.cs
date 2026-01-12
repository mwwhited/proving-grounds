using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WhitedUS.MediaLibrary.Services;
using WhitedUS.MediaLibrary.Models;

namespace WhitedUS.Web.Areas.MediaLibrary.Controllers
{
    public class MediaTypesController : Controller
    {
        public MediaTypesController()
        {
            this.MediaTypeService = new MediaTypeService();
        }

        private MediaTypeService MediaTypeService { get; set; }

        //
        // GET: /MediaLibrary/Media/
        public ActionResult Index()
        {
            return RedirectToAction("List");
        }

        //
        // GET: /MediaLibrary/MediaTypes/Details/5
        public ActionResult Details(int id)
        {
            var model = this.MediaTypeService.List().Single(m => m.LocalID == id);
            return View(model);
        }

        public ActionResult List()
        {
            var models = this.MediaTypeService.List();
            return View(models);
        }

        //
        // GET: /MediaLibrary/MediaTypes/Create
        [Authorize(Roles = "MediaLibrary_Admin")]
        public ActionResult Create()
        {
            var model = this.MediaTypeService.Create();
            return View(model);
        }

        //
        // POST: /MediaLibrary/MediaTypes/Create
        [Authorize(Roles = "MediaLibrary_Admin")]
        [HttpPost]
        public ActionResult Create(MediaTypeModel model)
        {
            try
            {
                if (this.ModelState.IsValid)
                {
                    var id = this.MediaTypeService.Save(model);
                    model.LocalID = id;
                    return View("Created", model);
                }
            }
            catch (Exception ex)
            {
                this.ViewBag.Exception = ex;
            }
            return View(model);
        }

        //
        // GET: /MediaLibrary/MediaTypes/Edit/5 
        [Authorize(Roles = "MediaLibrary_Admin")]
        public ActionResult Edit(int id)
        {
            var model = this.MediaTypeService.List().Single(m => m.LocalID == id);
            return View(model);
        }

        //
        // POST: /MediaLibrary/MediaTypes/Edit/5
        [HttpPost]
        [Authorize(Roles = "MediaLibrary_Admin")]
        public ActionResult Edit(int id, MediaTypeModel model)
        {
            try
            {
                if (this.ModelState.IsValid)
                {
                    this.MediaTypeService.Save(model);
                    return View("Edited", model);
                }
            }
            catch (Exception ex)
            {
                this.ViewBag.Exception = ex;
            }
            return View(model);
        }

        //
        // GET: /MediaLibrary/MediaTypes/Delete/5 
        [Authorize(Roles = "MediaLibrary_Admin")]
        public ActionResult Delete(int id)
        {
            var model = this.MediaTypeService.List().Single(m => m.LocalID == id);
            return View(model);
        }

        //
        // POST: /MediaLibrary/MediaTypes/Delete/5
        [HttpPost]
        [Authorize(Roles = "MediaLibrary_Admin")]
        public ActionResult Delete(int id, MediaTypeModel model)
        {
            try
            {
                if (this.ModelState.IsValid)
                {
                    this.MediaTypeService.Delete(model);
                    return View("Deleted", model);
                }
            }
            catch (Exception ex)
            {
                this.ViewBag.Exception = ex;
            }
            return View(model);
        }
    }
}
