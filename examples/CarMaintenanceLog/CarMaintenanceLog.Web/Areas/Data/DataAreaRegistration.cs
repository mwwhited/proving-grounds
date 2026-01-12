using System;
using System.Web.Mvc;

namespace CarMaintenanceLog.Web.Areas.Data
{
	public class DataAreaRegistration : AreaRegistration
	{
		public override string AreaName
		{
			get
			{
				return "Data";
			}
		}

		public DataAreaRegistration()
		{
		}

		public override void RegisterArea(AreaRegistrationContext context)
		{
			context.MapRoute("Data_default", "Data/{controller}/{action}/{id}", new { action = "Index", id = UrlParameter.Optional });
		}
	}
}