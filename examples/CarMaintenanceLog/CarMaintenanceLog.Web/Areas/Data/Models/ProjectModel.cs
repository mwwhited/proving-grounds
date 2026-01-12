using System;
using System.Runtime.CompilerServices;

namespace CarMaintenanceLog.Web.Areas.Data.Models
{
	public class ProjectModel
	{
		public int CustomerID
		{
			get;
			internal set;
		}

		public double? DefaultMiles
		{
			get;
			internal set;
		}

		public double? HourlyRate
		{
			get;
			internal set;
		}

		public string Name
		{
			get;
			internal set;
		}

		public int ProjectID
		{
			get;
			internal set;
		}

		public ProjectModel()
		{
		}
	}
}