using System;
using System.Runtime.CompilerServices;

namespace CarMaintenanceLog.Web.Areas.Data.Models
{
	public class StationModel
	{
		public string Address1
		{
			get;
			set;
		}

		public string Address2
		{
			get;
			set;
		}

		public string City
		{
			get;
			set;
		}

		public string Name
		{
			get;
			set;
		}

		public string State
		{
			get;
			set;
		}

		public int StationID
		{
			get;
			set;
		}

		public string ZipCode
		{
			get;
			set;
		}

		public StationModel()
		{
		}
	}
}