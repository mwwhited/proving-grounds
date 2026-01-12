using System;
using System.Collections.Generic;

namespace CarMaintenanceLog.Data.Core
{
    public partial class TimeLogs
    {
        public int TimeLogId { get; set; }
        public DateTime Date { get; set; }
        public TimeSpan StartTime { get; set; }
        public TimeSpan? StartBreak { get; set; }
        public TimeSpan? EndBreak { get; set; }
        public TimeSpan? EndTime { get; set; }
        public string Note { get; set; }
        public int? InvoiceId { get; set; }
        public int ProjectId { get; set; }
        public double? Miles { get; set; }
        public double? Hours { get; set; }
        public int? CarId { get; set; }
        public int? ReportedTimeLogId { get; set; }

        public virtual Cars Car { get; set; }
        public virtual Projects Project { get; set; }
        public virtual ReportedTimeLogs ReportedTimeLog { get; set; }
    }
}
