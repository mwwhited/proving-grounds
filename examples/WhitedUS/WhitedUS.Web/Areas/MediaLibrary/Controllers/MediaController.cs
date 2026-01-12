using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WhitedUS.MediaLibrary.Models;
using WhitedUS.MediaLibrary.Services;

namespace WhitedUS.Web.Areas.MediaLibrary.Controllers
{
    public class MediaController : Controller
    {
        public MediaController()
        {
            this.MediaService = new MediaService();
        }

        private MediaService MediaService { get; set; }

        //
        // GET: /MediaLibrary/Media/
        public ActionResult Index()
        {
            return RedirectToAction("List");
        }

        //
        // GET: /MediaLibrary/Media/Details/5
        public ActionResult Details(int id)
        {
            var model = this.MediaService.List().Single(m => m.LocalID == id);
            return View(model);
        }

        public ActionResult List()
        {
            var models = this.MediaService.List();
            return View(models);
        }

        //
        // GET: /MediaLibrary/Media/Create
        [Authorize(Roles = "MediaLibrary_Admin")]
        public ActionResult Create()
        {
            var model = this.MediaService.Create();
            return View(model);
        }

        //
        // POST: /MediaLibrary/Media/Create
        [Authorize(Roles = "MediaLibrary_Admin")]
        [HttpPost]
        public ActionResult Create(MediaModel model)
        {
            try
            {
                if (this.ModelState.IsValid)
                {
                    var id = this.MediaService.Save(model);
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
        // GET: /MediaLibrary/Media/Edit/5 
        [Authorize(Roles = "MediaLibrary_Admin")]
        public ActionResult Edit(int id)
        {
            var model = this.MediaService.List().Single(m => m.LocalID == id);
            return View(model);
        }

        //
        // POST: /MediaLibrary/Media/Edit/5
        [HttpPost]
        [Authorize(Roles = "MediaLibrary_Admin")]
        public ActionResult Edit(int id, MediaModel model)
        {
            try
            {
                if (this.ModelState.IsValid)
                {
                    this.MediaService.Save(model);
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
        // GET: /MediaLibrary/Media/Delete/5 
        [Authorize(Roles = "MediaLibrary_Admin")]
        public ActionResult Delete(int id)
        {
            var model = this.MediaService.List().Single(m => m.LocalID == id);
            return View(model);
        }

        //
        // POST: /MediaLibrary/Media/Delete/5
        [HttpPost]
        [Authorize(Roles = "MediaLibrary_Admin")]
        public ActionResult Delete(int id, MediaModel model)
        {
            try
            {
                if (this.ModelState.IsValid)
                {
                    this.MediaService.Delete(model);
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
