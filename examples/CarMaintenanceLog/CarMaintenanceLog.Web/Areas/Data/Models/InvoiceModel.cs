using System;
using System.Runtime.CompilerServices;

namespace CarMaintenanceLog.Web.Areas.Data.Models
{
	public class InvoiceModel
	{
		public string Comment
		{
			get;
			internal set;
		}

		public int CustomerID
		{
			get;
			internal set;
		}

		public DateTime? DueDate
		{
			get;
			internal set;
		}

		public int HasRenderedInvoice
		{
			get;
			internal set;
		}

		public DateTime? InvoiceDate
		{
			get;
			internal set;
		}

		public int InvoiceID
		{
			get;
			internal set;
		}

		public int? InvoiceNumber
		{
			get;
			internal set;
		}

		public string InvoiceStatusCode
		{
			get;
			internal set;
		}

		public string Notes
		{
			get;
			internal set;
		}

		public DateTime? PaidDate
		{
			get;
			internal set;
		}

		public string TermsAndConditions
		{
			get;
			internal set;
		}

		public int TermsID
		{
			get;
			internal set;
		}

		public InvoiceModel()
		{
		}
	}
}