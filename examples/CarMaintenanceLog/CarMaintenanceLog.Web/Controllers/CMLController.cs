using System;
using System.Web.Mvc;

namespace CarMaintenanceLog.Web.Controllers
{
	[Authorize]
	public class CMLController : Controller
	{
		public CMLController()
		{
		}

		public ActionResult Accounting()
		{
			return base.View();
		}

		public ActionResult Index()
		{
			return base.View();
		}
	}
}