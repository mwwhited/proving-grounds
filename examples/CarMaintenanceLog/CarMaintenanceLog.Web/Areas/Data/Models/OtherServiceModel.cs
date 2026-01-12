using System;
using System.Runtime.CompilerServices;

namespace CarMaintenanceLog.Web.Areas.Data.Models
{
	public class OtherServiceModel
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

		public decimal? ExtendedCost
		{
			get;
			set;
		}

		public string Item
		{
			get;
			set;
		}

		public string Location
		{
			get;
			set;
		}

		public decimal Miles
		{
			get;
			set;
		}

		public string Notes
		{
			get;
			set;
		}

		public int OtherServiceID
		{
			get;
			set;
		}

		public decimal Rate
		{
			get;
			set;
		}

		public OtherServiceModel()
		{
		}
	}
}