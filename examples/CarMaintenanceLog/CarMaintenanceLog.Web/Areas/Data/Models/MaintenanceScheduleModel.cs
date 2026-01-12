using System;
using System.Runtime.CompilerServices;

namespace CarMaintenanceLog.Web.Areas.Data.Models
{
	public class MaintenanceScheduleModel
	{
		public int CarID
		{
			get;
			set;
		}

		public DateTime? CompletedOn
		{
			get;
			set;
		}

		public bool? IsComplete
		{
			get;
			set;
		}

		public int MaintenanceScheduleID
		{
			get;
			set;
		}

		public decimal Miles
		{
			get;
			set;
		}

		public bool PastDue
		{
			get;
			internal set;
		}

		public string WorkItems
		{
			get;
			set;
		}

		public MaintenanceScheduleModel()
		{
		}
	}
}