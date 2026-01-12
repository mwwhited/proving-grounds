using System;
using System.Runtime.CompilerServices;

namespace CarMaintenanceLog.Web.Areas.Data.Models
{
	public class PaymentModel
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

		public int PaymentID
		{
			get;
			set;
		}

		public PaymentModel()
		{
		}
	}
}