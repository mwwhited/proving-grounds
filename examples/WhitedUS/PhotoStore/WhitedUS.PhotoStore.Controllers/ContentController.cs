using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Configuration;
using System.Text.RegularExpressions;
using System.IO;
using WhitedUS.PhotoStore.Services;
using System.Threading;
using WhitedUS.Web.Mvc;
using System.Text;
using WhitedUS.PhotoStore.Models;

namespace WhitedUS.PhotoStore.Controllers
{
    public class ContentController : Controller
    {
        public enum ContentType
        {
            Xml,
            Json,
            Default,
        }

        private static readonly int maxRetry = 10;
        private Random Rand { get; set; }

        public ContentController()
        {
            this.PhotoAccessor = new PhotoAccessor(this.BasePath, this.Pattern, this.Extensions);
            this.Rand = new Random();
        }

        private readonly string PhotosBasePathKey = "PhotosBasePath";
        private readonly string PhotosPatternKey = "PhotosPattern";
        private readonly string PhotosExtensionsKey = "PhotosExtensions";

        private const int PageLength = 40;

        private string _basePath;
        public string BasePath
        {
            get { return _basePath ?? (_basePath = ConfigurationManager.AppSettings[PhotosBasePathKey]); }
        }
        private string _pattern;
        public string Pattern
        {
            get { return _pattern ?? (_pattern = ConfigurationManager.AppSettings[PhotosPatternKey]); }
        }
        private string[] _extensions;
        public string[] Extensions
        {
            get { return _extensions ?? (_extensions = (ConfigurationManager.AppSettings[PhotosExtensionsKey] ?? ".JPG|.JPEG|.PNG").Split('|')); }
        }

        public PhotoAccessor PhotoAccessor { get; set; }

        public ActionResult Viewer()
        {
            var model = (this.Access(null, type: ContentType.Json) as JsonResult).Data;
            return this.View(model);
        }

        public ActionResult Access(string pathInfo, byte? factor = null, int page = 0, int pageLength = PageLength, OrderBy nameOrder = OrderBy.None, ContentType type = ContentType.Default)
        {
            try
            {
                var path = System.IO.Path.Combine(this.BasePath, pathInfo ?? "");
                if (this.PhotoAccessor.IsPathDirectory(path))
                {
                    var query = this.PhotoAccessor.ListByPath(path);

                    switch (nameOrder)
                    {
                        case OrderBy.Asc:
                            query = query.OrderBy(q => q.Name);
                            break;
                        case OrderBy.Desc:
                            query = query.OrderByDescending(q => q.Name);
                            break;
                        case OrderBy.None:
                        default:
                            break;
                    }

                    var pageCount = (int)Math.Ceiling((double)query.Count() / pageLength);

                    if (this.Request.IsAjaxRequest() || type == ContentType.Json || type == ContentType.Xml)
                    {
                        var parentPath = Path.GetDirectoryName(pathInfo) ?? "";
                        var parentName = Path.GetFileName(parentPath);
                        if (string.IsNullOrWhiteSpace(parentName))
                            parentName = "Root";

                        return this.Json(new DirectoryPageModel
                        {
                            Parent = parentPath,
                            ParentName = parentName,

                            Name = Path.GetFileName(pathInfo) ?? "Root",
                            Path = pathInfo ?? "",
                            Data = query.Skip(page * pageLength).Take(pageLength),

                            Page = page,
                            PageLength = pageLength,
                            PageCount = pageCount,
                            NameOrder = nameOrder,
                        }, JsonRequestBehavior.AllowGet);
                    }
                    else
                    {
                        this.ViewBag.Path = pathInfo;
                        this.ViewBag.Page = page;
                        this.ViewBag.PageLength = pageLength;
                        this.ViewBag.PageCount = pageCount;

                        this.ViewBag.Tags = this.PhotoAccessor.ListTags();
                        return View("Display", query.Skip(page * pageLength).Take(pageLength).ToList());
                    }
                }
                else if (this.PhotoAccessor.IsPathFile(path))
                {
                    return this.GetFile(pathInfo, factor);
                }
                return this.HttpNotFound();
            }
            catch (Exception ex)
            {
                this.HttpContext.Response.AddHeader("X-Exception-Message", ex.Message);
                this.HttpContext.Response.AddHeader("X-Exception", ex.ToString());
                return this.HttpNotFound(ex.Message);
            }
        }

        public ActionResult Tag(string tag, byte? factor = null, int page = 0, int pageLength = PageLength, OrderBy nameOrder = OrderBy.None)
        {
            var tags = tag.Replace('\\', '/').Split('/');
            var query = this.PhotoAccessor.ListByTags(tags);

            switch (nameOrder)
            {
                case OrderBy.Asc:
                    query = query.OrderBy(q => q.Name);
                    break;
                case OrderBy.Desc:
                    query = query.OrderByDescending(q => q.Name);
                    break;
                case OrderBy.None:
                default:
                    break;
            }

            if (this.Request.IsAjaxRequest())
            {
                return this.Json(new
                {
                    Tags = tags,
                    Data = query,
                }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                var pageCount = (int)Math.Ceiling((double)query.Count() / pageLength);

                this.ViewBag.Tag = tag;
                this.ViewBag.Page = page;
                this.ViewBag.PageLength = pageLength;
                this.ViewBag.PageCount = pageCount;

                this.ViewBag.Tags = this.PhotoAccessor.ListTags();
                return View("Display", query.Skip(page * pageLength).Take(pageLength).ToList());
            }
        }

        [HttpPost]
        [ActionName("Tag")]
        [Authorize(Roles = "PhotoStore_Admin")]
        public ActionResult TagAdd(string pathInfo, string tag)
        {
            var path = System.IO.Path.Combine(this.BasePath, pathInfo ?? "");
            if (this.PhotoAccessor.IsPathDirectory(path))
            {
                return this.HttpNotFound("Can not tag folders");
            }
            else if (this.PhotoAccessor.IsPathFile(path))
            {
                return this.GetData(new
                {
                    Result = this.PhotoAccessor.TagAdd(path, tag)
                });

            }
            return this.HttpNotFound();
        }

        [HttpDelete]
        [ActionName("Tag")]
        [Authorize(Roles = "PhotoStore_Admin")]
        public ActionResult TagRemove(string pathInfo, string tag)
        {
            var path = System.IO.Path.Combine(this.BasePath, pathInfo ?? "");
            if (this.PhotoAccessor.IsPathDirectory(path))
            {
                return this.HttpNotFound("Can not tag folders");
            }
            else if (this.PhotoAccessor.IsPathFile(path))
            {
                return this.GetData(new
                {
                    Result = this.PhotoAccessor.TagAdd(path, tag)
                });
            }
            return this.HttpNotFound();
        }

        public ActionResult EXIF(string pathInfo, ContentType type = ContentType.Xml)
        {
            try
            {
                var path = System.IO.Path.Combine(this.BasePath, pathInfo ?? "");
                if (this.PhotoAccessor.IsPathFile(path))
                {
                    var metaData = this.PhotoAccessor.GetMetaData(pathInfo);
                    if (metaData != null)
                    {
                        //this.Response.AddHeader("X-ContentType", type.ToString());
                        //this.Response.AddHeader("X-MetaData", metaData.ToString());

                        switch (type)
                        {
                            case ContentType.Json:
                                return this.Json(metaData, JsonRequestBehavior.AllowGet);
                            case ContentType.Xml:
                            default:
                                return new XmlResult(metaData);
                        }
                    }
                }

                return this.HttpNotFound();
            }
            catch (Exception ex)
            {
                return this.File(Encoding.ASCII.GetBytes(ex.ToString()), "text/plain");
            }
        }

        private ActionResult ViewOrJson<TModel>(string viewName, TModel model = null) where TModel : class
        {
            if (this.Request.IsAjaxRequest())
                return this.Json(model);
            else
                return this.View(viewName, model);
        }

        private ActionResult GetData<T>(T model)
        {
            if (this.Request.IsAjaxRequest())
                return this.Json(model);
            else
                return new XmlResult(model);
        }

        private ActionResult GetFile(string pathInfo, byte? factor)
        {
            int tryCount = 0;
        tryagain:
            try
            {
                string mimeType;
                var stream = this.PhotoAccessor.GetFile(pathInfo, factor, out mimeType);

                if (mimeType == "image/x-raw")
                    mimeType = "image/jpeg";

                return this.File(stream, mimeType);
            }
            catch (Exception ex)
            {
                if (tryCount++ < maxRetry
                    && ex.InnerException != null
                    && (ex.InnerException.Message.Contains("deadlocked")
                        || ex.InnerException.Message.Contains("duplicate key")
                    ))
                {
                    Thread.Sleep(Math.Min(100 * tryCount + this.Rand.Next(100), 500));
                    goto tryagain;
                }

                if (ex.InnerException != null)
                    return this.HttpNotFound(ex.InnerException.Message);
                return this.HttpNotFound(ex.Message);
            }
        }
    }
}
