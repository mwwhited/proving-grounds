using System;
using System.Runtime.CompilerServices;

namespace CarMaintenanceLog.Web.Areas.Data.Models
{
	public class TiresModel
	{
		public int CarID
		{
			get;
			set;
		}

		public decimal Cost
		{
			get;
			set;
		}

		public DateTime Date
		{
			get;
			set;
		}

		public DateTime? ExpireDate
		{
			get;
			set;
		}

		public decimal? ExpireMiles
		{
			get;
			set;
		}

		public decimal? ExtendedCost
		{
			get;
			set;
		}

		public string Make
		{
			get;
			set;
		}

		public decimal Miles
		{
			get;
			set;
		}

		public string Model
		{
			get;
			set;
		}

		public string Note
		{
			get;
			set;
		}

		public int Quantity
		{
			get;
			set;
		}

		public decimal TaxRate
		{
			get;
			set;
		}

		public int TireID
		{
			get;
			set;
		}

		public decimal WarrantyMiles
		{
			get;
			set;
		}

		public int WarrantyMonths
		{
			get;
			set;
		}

		public TiresModel()
		{
		}
	}
}