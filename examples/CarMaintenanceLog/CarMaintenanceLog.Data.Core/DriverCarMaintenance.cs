using System;
using System.Collections.Generic;

namespace CarMaintenanceLog.Data.Core
{
    public partial class DriverCarMaintenance
    {
        public int DriverId { get; set; }
        public int CarId { get; set; }
        public int MaintenanceScheduleId { get; set; }
        public string Driver { get; set; }
        public string Make { get; set; }
        public string Model { get; set; }
        public string SubModel { get; set; }
        public decimal TotalMiles { get; set; }
        public decimal ScheduledMiles { get; set; }
        public decimal? DueIn { get; set; }
        public string WorkItems { get; set; }
        public DateTime? CompletedOn { get; set; }
        public bool? IsComplete { get; set; }
    }
}
