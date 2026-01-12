using CarMaintenanceLog.Data;
using CarMaintenanceLog.Web.Areas.Data.Models;
using Microsoft.AspNet.Identity;
using System;
using System.Linq;
using System.Web.Http;

namespace CarMaintenanceLog.Web.Areas.Data.Controllers
{
	[Authorize]
	public class StationController : ApiController
	{
		public StationController()
		{
		}

		public IQueryable<StationModel> Get()
		{
			Guid guid = Guid.Parse(base.RequestContext.Principal.Identity.GetUserId());
			CarMaintenanceLogEntities carMaintenanceLogEntity = new CarMaintenanceLogEntities();
			if (!carMaintenanceLogEntity.Drivers.Any<Driver>((Driver d) => d.UserID == (Guid?)guid))
			{
				Driver driver = new Driver()
				{
					Name = base.RequestContext.Principal.Identity.GetUserName(),
					UserID = new Guid?(guid)
				};
				carMaintenanceLogEntity.Drivers.Add(driver);
				carMaintenanceLogEntity.SaveChanges();
			}
			return
				from item in carMaintenanceLogEntity.Stations
				select new StationModel()
				{
					StationID = item.StationID,
					Name = item.Name,
					Address1 = item.Address1,
					Address2 = item.Address2,
					City = item.City,
					State = item.State,
					ZipCode = item.ZipCode
				};
		}
	}
}