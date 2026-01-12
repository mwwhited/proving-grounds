using CarMaintenanceLog.Data;
using CarMaintenanceLog.Web.Areas.Data.Models;
using Microsoft.AspNet.Identity;
using System;
using System.Linq;
using System.Web.Http;

namespace CarMaintenanceLog.Web.Areas.Data.Controllers
{
	[Authorize]
	public class OilChangeController : ApiController
	{
		public OilChangeController()
		{
		}

		public IQueryable<OilChangeModel> Get(int id)
		{
			Guid guid = Guid.Parse(base.RequestContext.Principal.Identity.GetUserId());
			return
				from item in (new CarMaintenanceLogEntities()).OilChanges1
				where item.CarID == id && (item.Car.Driver.UserID == (Guid?)guid)
				select new OilChangeModel()
				{
					OilChangeID = item.OilChangeID,
					CarID = item.CarID,
					Date = item.Date,
					ChangeMiles = item.ChangeMiles,
					OilBrand = item.OilBrand,
					FilterBrand = item.FilterBrand,
					Quarts = item.Quarts,
					OilCost = item.OilCost,
					FilterCost = item.FilterCost,
					LaborCost = item.LaborCost,
					TaxRate = item.TaxRate,
					OtherCost = item.OtherCost,
					Location = item.Location,
					Notes = item.Notes,
					ExtendedCost = item.ExtendedCost
				};
		}

		public OilChangeModel Post([FromBody] OilChangeModel value)
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
				OilChange date = carMaintenanceLogEntity.OilChanges1.SingleOrDefault<OilChange>((OilChange f) => f.OilChangeID == value.OilChangeID) ?? new OilChange()
				{
					CarID = value.CarID
				};
				date.Date = value.Date;
				date.ChangeMiles = value.ChangeMiles;
				date.OilBrand = value.OilBrand;
				date.FilterBrand = value.FilterBrand;
				date.Quarts = value.Quarts;
				date.OilCost = value.OilCost;
				date.FilterCost = value.FilterCost;
				date.LaborCost = value.LaborCost;
				date.TaxRate = value.TaxRate;
				date.OtherCost = value.OtherCost;
				date.Location = value.Location;
				OilChange oilChange = date;
				if (string.IsNullOrWhiteSpace(value.Notes))
				{
					notes = null;
				}
				else
				{
					notes = value.Notes;
				}
				oilChange.Notes = notes;
				if (value.CarID != date.CarID)
				{
					throw new InvalidOperationException();
				}
				if (value.OilChangeID == 0)
				{
					value.OilChangeID = carMaintenanceLogEntity.OilChanges1.Add(date).OilChangeID;
				}
				carMaintenanceLogEntity.SaveChanges();
			}
			return value;
		}
	}
}