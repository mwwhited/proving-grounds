using CarMaintenanceLog.Data;
using CarMaintenanceLog.Web.Areas.Data.Models;
using System;
using System.Linq;
using System.Linq.Expressions;
using System.Web.Http;

namespace CarMaintenanceLog.Web.Areas.Data.Controllers
{
	[Authorize]
	public class CustomerController : ApiController
	{
		public CustomerController()
		{
		}

		public IQueryable<CustomerModel> Get()
		{
			return
				from c in (new CarMaintenanceLogEntities()).Customers
				select new CustomerModel()
				{
					CustomerID = c.CustomerID,
					CompanyName = c.CompanyName,
					FirstName = c.FirstName,
					LastName = c.LastName,
					Address1 = c.Address1,
					Address2 = c.Address2,
					City = c.City,
					State = c.State,
					PostalCode = c.PostalCode,
					Country = c.Country,
					AccountingEmail = c.AccountingEmail,
					ContractEmail = c.ContractEmail,
					Phone = c.Phone,
					Notes = c.Notes
				};
		}
	}
}