using CarMaintenanceLog.Data;
using CarMaintenanceLog.Web.Areas.Data.Models;
using Microsoft.AspNet.Identity;
using System;
using System.Linq;
using System.Linq.Expressions;
using System.Runtime.CompilerServices;
using System.Security.Principal;
using System.Web.Http;
using System.Web.Http.Controllers;

namespace CarMaintenanceLog.Web.Areas.Data.Controllers
{
	[Authorize]
	public class PaymentController : ApiController
	{
		public PaymentController()
		{
		}

		public void Delete(int id)
		{
		}

		public IQueryable<PaymentModel> Get(int carid)
		{
			Guid guid = Guid.Parse(base.RequestContext.Principal.Identity.GetUserId());
			return
				from item in (new CarMaintenanceLogEntities()).Payments
				where item.CarID == carid && (item.Car.Driver.UserID == (Guid?)guid)
				select new PaymentModel()
				{
					PaymentID = item.PaymentID,
					CarID = item.CarID,
					Date = item.Date,
					Amount = item.Amount,
					PaidTo = item.PaidTo,
					Notes = item.Notes
				};
		}

		public PaymentModel Get(int carid, int id)
		{
			return this.Get(carid).SingleOrDefault<PaymentModel>((PaymentModel d) => d.PaymentID == id);
		}

		public void Post([FromBody] PaymentModel value)
		{
		}

		public void Put(int id, [FromBody] PaymentModel value)
		{
		}
	}
}