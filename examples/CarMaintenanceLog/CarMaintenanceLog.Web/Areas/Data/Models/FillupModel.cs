using System;
using System.Runtime.CompilerServices;

namespace CarMaintenanceLog.Web.Areas.Data.Models
{
	public class FillupModel
	{
		public int CarID
		{
			get;
			set;
		}

		public decimal CostPerGallon
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

		public int FillUpID
		{
			get;
			set;
		}

		public decimal Gallons
		{
			get;
			set;
		}

		public decimal? MilesPerGallon
		{
			get;
			set;
		}

		public string Notes
		{
			get;
			set;
		}

		public int Octane
		{
			get;
			set;
		}

		public string Station
		{
			get;
			set;
		}

		public decimal TankMiles
		{
			get;
			set;
		}

		public decimal TotalMiles
		{
			get;
			set;
		}

		public FillupModel()
		{
		}
	}
}