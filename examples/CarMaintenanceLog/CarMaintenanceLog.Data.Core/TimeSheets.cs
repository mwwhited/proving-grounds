using System;
using System.Collections.Generic;

namespace CarMaintenanceLog.Data.Core
{
    public partial class TimeSheets
    {
        public int? InvoiceId { get; set; }
        public int ProjectId { get; set; }
        public int? Year { get; set; }
        public int? Month { get; set; }
        public int? Week { get; set; }
        public DateTime? FirstOfWeek { get; set; }
        public double? Miles { get; set; }
        public double? TotalHours { get; set; }
        public double? Saturday { get; set; }
        public double? Sunday { get; set; }
        public double? Monday { get; set; }
        public double? Tuesday { get; set; }
        public double? Wednesday { get; set; }
        public double? Thursday { get; set; }
        public double? Friday { get; set; }
        public long? RowOrder { get; set; }
    }
}
