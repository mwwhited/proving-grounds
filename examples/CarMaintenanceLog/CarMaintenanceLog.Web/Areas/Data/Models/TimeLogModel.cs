using System;
using System.Runtime.CompilerServices;

namespace CarMaintenanceLog.Web.Areas.Data.Models
{
	public class TimeLogModel
	{
		public int? CarID
		{
			get;
			internal set;
		}

		public DateTime Date
		{
			get;
			internal set;
		}

		public TimeSpan? EndBreak
		{
			get;
			internal set;
		}

		public TimeSpan? EndTime
		{
			get;
			internal set;
		}

		public double? Hours
		{
			get;
			internal set;
		}

		public int? InvoiceID
		{
			get;
			internal set;
		}

		public double? Miles
		{
			get;
			internal set;
		}

		public string Note
		{
			get;
			internal set;
		}

		public int ProjectId
		{
			get;
			internal set;
		}

		public int? ReportedTimeLogID
		{
			get;
			internal set;
		}

		public TimeSpan? StartBreak
		{
			get;
			internal set;
		}

		public TimeSpan StartTime
		{
			get;
			internal set;
		}

		public int TimeLogID
		{
			get;
			internal set;
		}

		public TimeLogModel()
		{
		}
	}
}