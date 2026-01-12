using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WhitedUS.Web.Areas.MediaLibrary.Controllers
{
    public class HomeController : Controller
    {
        //
        // GET: /MediaLibrary/Home/

        public ActionResult Index()
        {
            return View();
        }

    }
}
