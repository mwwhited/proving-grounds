using CarMaintenanceLog.Data;
using CarMaintenanceLog.Web.Areas.Data.Models;
using Microsoft.AspNet.Identity;
using System;
using System.Data.Entity;
using System.Linq;
using System.Linq.Expressions;
using System.Runtime.CompilerServices;
using System.Security.Principal;
using System.Web.Http;
using System.Web.Http.Controllers;

namespace CarMaintenanceLog.Web.Areas.Data.Controllers
{
	[Authorize]
	public class DriverController : ApiController
	{
		public DriverController()
		{
		}

		public IQueryable<DriverModel> Get()
		{
			Guid guid = Guid.Parse(base.RequestContext.Principal.Identity.GetUserId());
			CarMaintenanceLogEntities carMaintenanceLogEntity = new CarMaintenanceLogEntities();
			if (!carMaintenanceLogEntity.Drivers.Any<Driver>((Driver d) => d.UserID == (Guid?)guid))
			{
				Driver driver1 = new Driver()
				{
					Name = base.RequestContext.Principal.Identity.GetUserName(),
					UserID = new Guid?(guid)
				};
				carMaintenanceLogEntity.Drivers.Add(driver1);
				carMaintenanceLogEntity.SaveChanges();
			}
			return
				from driver in carMaintenanceLogEntity.Drivers
				where driver.UserID == (Guid?)guid
				select new DriverModel()
				{
					DriverID = driver.DriverID,
					Name = driver.Name
				};
		}
	}
}