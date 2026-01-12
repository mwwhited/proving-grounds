using System;
using System.Runtime.CompilerServices;

namespace CarMaintenanceLog.Web.Areas.Data.Models
{
	public class CarModel
	{
		public int CarID
		{
			get;
			set;
		}

		public int DriverID
		{
			get;
			set;
		}

		public string Make
		{
			get;
			set;
		}

		public string Model
		{
			get;
			set;
		}

		public string Notes
		{
			get;
			set;
		}

		public DateTime? PurchasedDate
		{
			get;
			set;
		}

		public decimal StartingMiles
		{
			get;
			set;
		}

		public string SubModel
		{
			get;
			set;
		}

		public decimal? TotalMiles
		{
			get;
			internal set;
		}

		public int Year
		{
			get;
			set;
		}

		public CarModel()
		{
		}
	}
}