using System;
using System.Runtime.CompilerServices;

namespace CarMaintenanceLog.Web.Areas.Data.Models
{
	public class InsurancePaymentModel
	{
		public decimal Amount
		{
			get;
			set;
		}

		public int CarID
		{
			get;
			set;
		}

		public DateTime Date
		{
			get;
			set;
		}

		public int InsurancePaymentID
		{
			get;
			set;
		}

		public string Notes
		{
			get;
			set;
		}

		public string PaidTo
		{
			get;
			set;
		}

		public InsurancePaymentModel()
		{
		}
	}
}