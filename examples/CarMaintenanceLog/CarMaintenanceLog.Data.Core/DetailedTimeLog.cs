using System;
using System.Collections.Generic;

namespace CarMaintenanceLog.Data.Core
{
    public partial class DetailedTimeLog
    {
        public int TimeLogId { get; set; }
        public int? InvoiceId { get; set; }
        public int ProjectId { get; set; }
        public int? CarId { get; set; }
        public int? Year { get; set; }
        public int? Month { get; set; }
        public int? Week { get; set; }
        public int? DoW { get; set; }
        public string DayOfWeek { get; set; }
        public DateTime Date { get; set; }
        public TimeSpan StartTime { get; set; }
        public TimeSpan? StartBreak { get; set; }
        public TimeSpan? EndBreak { get; set; }
        public TimeSpan? EndTime { get; set; }
        public string Note { get; set; }
        public double? Miles { get; set; }
        public double? Hours { get; set; }
    }
}
