using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WhitedUS.Shared.Data;
using System.Web.Security;
using WhitedUS.Shared.Models;

namespace WhitedUS.Web.Areas.Storage.Controllers
{
    [Authorize]
    public class ContentController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult List()
        {
            var user = Membership.GetUser();

            var db = SharedEntities.Factory(userid: (Guid)user.ProviderUserKey);

            var query = from item in db.ContentItems
                        select new ContentModel
                        {
                            ContentItemID = item.ContentItemID,
                            ContentTypeID = item.ContentTypeID,
                            CreationTime = item.CreationTime,
                        }
                            ;

            return View(query);
        }

    }
}
