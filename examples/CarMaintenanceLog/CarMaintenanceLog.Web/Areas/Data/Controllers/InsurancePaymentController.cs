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
	public class InsurancePaymentController : ApiController
	{
		public InsurancePaymentController()
		{
		}

		public void Delete(int id)
		{
		}

		public IQueryable<InsurancePaymentModel> Get(int carid)
		{
			Guid guid = Guid.Parse(base.RequestContext.Principal.Identity.GetUserId());
			return
				from item in (new CarMaintenanceLogEntities()).InsurancePayments
				where item.CarID == carid && (item.Car.Driver.UserID == (Guid?)guid)
				select new InsurancePaymentModel()
				{
					InsurancePaymentID = item.InsurancePaymentID,
					CarID = item.CarID,
					Date = item.Date,
					Amount = item.Amount,
					PaidTo = item.PaidTo,
					Notes = item.Notes
				};
		}

		public InsurancePaymentModel Get(int carid, int id)
		{
			return this.Get(carid).SingleOrDefault<InsurancePaymentModel>((InsurancePaymentModel d) => d.InsurancePaymentID == id);
		}

		public void Post([FromBody] InsurancePaymentModel value)
		{
		}

		public void Put(int id, [FromBody] InsurancePaymentModel value)
		{
		}
	}
}