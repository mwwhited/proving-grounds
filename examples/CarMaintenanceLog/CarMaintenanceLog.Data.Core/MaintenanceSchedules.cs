using System;
using System.Collections.Generic;

namespace CarMaintenanceLog.Data.Core
{
    public partial class MaintenanceSchedules
    {
        public int MaintenanceScheduleId { get; set; }
        public int CarId { get; set; }
        public decimal Miles { get; set; }
        public string WorkItems { get; set; }
        public DateTime? CompletedOn { get; set; }
        public bool? IsComplete { get; set; }

        public virtual Cars Car { get; set; }
    }
}
