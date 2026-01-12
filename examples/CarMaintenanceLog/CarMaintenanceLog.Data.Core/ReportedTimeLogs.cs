using System;
using System.Collections.Generic;

namespace CarMaintenanceLog.Data.Core
{
    public partial class ReportedTimeLogs
    {
        public ReportedTimeLogs()
        {
            TimeLogs = new HashSet<TimeLogs>();
        }

        public int ReportedTimeLogId { get; set; }
        public int ProjectId { get; set; }
        public int Year { get; set; }
        public int Month { get; set; }
        public int Week { get; set; }
        public DateTime FirstOfWeek { get; set; }
        public byte[] Rendering { get; set; }
        public int HasRendering { get; set; }

        public virtual Projects Project { get; set; }
        public virtual ICollection<TimeLogs> TimeLogs { get; set; }
    }
}
