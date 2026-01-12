using CarMaintenanceLog.Data;
using CarMaintenanceLog.Web.Areas.Data.Models;
using Microsoft.AspNet.Identity;
using System;
using System.Linq;
using System.Web.Http;

namespace CarMaintenanceLog.Web.Areas.Data.Controllers
{
	[Authorize]
	public class TiresController : ApiController
	{
		public TiresController()
		{
		}

		public void Delete(int id)
		{
		}

		public IQueryable<TiresModel> Get(int carid)
		{
			Guid guid = Guid.Parse(base.RequestContext.Principal.Identity.GetUserId());
			return
				from item in (new CarMaintenanceLogEntities()).Tires
				where item.CarID == carid && (item.Car.Driver.UserID == (Guid?)guid)
				select new TiresModel()
				{
					TireID = item.TireID,
					CarID = item.CarID,
					Date = item.Date,
					Miles = item.Miles,
					Make = item.Make,
					Model = item.Model,
					Cost = item.Cost,
					Quantity = item.Quantity,
					TaxRate = item.TaxRate,
					WarrantyMonths = item.WarrantyMonths,
					WarrantyMiles = item.WarrantyMiles,
					Note = item.Note,
					ExpireDate = item.ExpireDate,
					ExpireMiles = item.ExpireMiles,
					ExtendedCost = item.ExtendedCost
				};
		}

		public TiresModel Get(int carid, int id)
		{
			return this.Get(carid).SingleOrDefault<TiresModel>((TiresModel d) => d.TireID == id);
		}

		public void Post([FromBody] TiresModel value)
		{
		}

		public void Put(int id, [FromBody] TiresModel value)
		{
		}
	}
}