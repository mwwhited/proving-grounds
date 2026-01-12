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
using System.Web.Http.ModelBinding;

namespace CarMaintenanceLog.Web.Areas.Data.Controllers
{
	[Authorize]
	public class FillupController : ApiController
	{
		public FillupController()
		{
		}

		public IQueryable<FillupModel> Get(int id)
		{
			Guid guid = Guid.Parse(base.RequestContext.Principal.Identity.GetUserId());
			return
				from item in (new CarMaintenanceLogEntities()).FillUps
				where item.CarID == id && (item.Car.Driver.UserID == (Guid?)guid)
				select new FillupModel()
				{
					FillUpID = item.FillUpID,
					CarID = item.CarID,
					Date = item.Date,
					CostPerGallon = item.CostPerGallon,
					Gallons = item.Gallons,
					Octane = item.Octane,
					TankMiles = item.TankMiles,
					TotalMiles = item.TotalMiles,
					Station = item.Station,
					Notes = item.Notes,
					ExtendedCost = item.ExtendedCost,
					MilesPerGallon = item.MilesPerGallon
				};
		}

		[HttpPost]
		public FillupModel Post([FromBody] FillupModel value)
		{
			string notes;
			if (!base.ModelState.IsValid)
			{
				throw new InvalidOperationException();
			}
			if (value.Date == DateTime.MinValue)
			{
				value.Date = DateTime.Today;
			}
			Guid.Parse(base.RequestContext.Principal.Identity.GetUserId());
			using (CarMaintenanceLogEntities carMaintenanceLogEntity = new CarMaintenanceLogEntities())
			{
				FillUp date = carMaintenanceLogEntity.FillUps.SingleOrDefault<FillUp>((FillUp f) => f.FillUpID == value.FillUpID) ?? new FillUp()
				{
					CarID = value.CarID
				};
				date.Date = value.Date;
				date.CostPerGallon = value.CostPerGallon;
				date.Gallons = value.Gallons;
				date.Octane = value.Octane;
				date.TankMiles = value.TankMiles;
				date.TotalMiles = value.TotalMiles;
				date.Station = value.Station;
				FillUp fillUp = date;
				if (string.IsNullOrWhiteSpace(value.Notes))
				{
					notes = null;
				}
				else
				{
					notes = value.Notes;
				}
				fillUp.Notes = notes;
				if (value.CarID != date.CarID)
				{
					throw new InvalidOperationException();
				}
				if (value.FillUpID == 0)
				{
					value.FillUpID = carMaintenanceLogEntity.FillUps.Add(date).FillUpID;
				}
				carMaintenanceLogEntity.SaveChanges();
			}
			return value;
		}
	}
}