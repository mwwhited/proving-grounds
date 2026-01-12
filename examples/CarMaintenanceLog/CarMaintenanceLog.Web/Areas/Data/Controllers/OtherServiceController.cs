using CarMaintenanceLog.Data;
using CarMaintenanceLog.Web.Areas.Data.Models;
using Microsoft.AspNet.Identity;
using System;
using System.Linq;
using System.Web.Http;

namespace CarMaintenanceLog.Web.Areas.Data.Controllers
{
	[Authorize]
	public class OtherServiceController : ApiController
	{
		public OtherServiceController()
		{
		}

		public void Delete(int id)
		{
		}

		public IQueryable<OtherServiceModel> Get(int carid)
		{
			Guid guid = Guid.Parse(base.RequestContext.Principal.Identity.GetUserId());
			return
				from item in (new CarMaintenanceLogEntities()).OtherServices
				where item.CarID == carid && (item.Car.Driver.UserID == (Guid?)guid)
				select new OtherServiceModel()
				{
					OtherServiceID = item.OtherServiceID,
					CarID = item.CarID,
					Date = item.Date,
					Miles = item.Miles,
					Item = item.Item,
					Cost = item.Cost,
					Rate = item.Rate,
					Location = item.Location,
					Notes = item.Notes,
					ExtendedCost = item.ExtendedCost
				};
		}

		public OtherServiceModel Get(int carid, int id)
		{
			return this.Get(carid).SingleOrDefault<OtherServiceModel>((OtherServiceModel d) => d.OtherServiceID == id);
		}

		public void Post([FromBody] OtherServiceModel value)
		{
		}

		public void Put(int id, [FromBody] OtherServiceModel value)
		{
		}
	}
}