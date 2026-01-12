using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WhitedUS.Web.Areas.Administration.Controllers
{
    [Authorize(Roles = "Administrators")]
    public class HomeController : Controller
    {
        //
        // GET: /Administration/Home/

        public ActionResult Index()
        {
            return View();
        }
    }
}
