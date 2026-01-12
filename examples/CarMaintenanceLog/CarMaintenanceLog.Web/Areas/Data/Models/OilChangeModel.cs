using System;
using System.Runtime.CompilerServices;

namespace CarMaintenanceLog.Web.Areas.Data.Models
{
	public class OilChangeModel
	{
		public int CarID
		{
			get;
			set;
		}

		public decimal ChangeMiles
		{
			get;
			set;
		}

		public DateTime Date
		{
			get;
			set;
		}

		public decimal? ExtendedCost
		{
			get;
			set;
		}

		public string FilterBrand
		{
			get;
			set;
		}

		public decimal? FilterCost
		{
			get;
			set;
		}

		public decimal? LaborCost
		{
			get;
			set;
		}

		public string Location
		{
			get;
			set;
		}

		public string Notes
		{
			get;
			set;
		}

		public string OilBrand
		{
			get;
			set;
		}

		public int OilChangeID
		{
			get;
			set;
		}

		public decimal? OilCost
		{
			get;
			set;
		}

		public decimal? OtherCost
		{
			get;
			set;
		}

		public decimal? Quarts
		{
			get;
			set;
		}

		public decimal? TaxRate
		{
			get;
			set;
		}

		public OilChangeModel()
		{
		}
	}
}