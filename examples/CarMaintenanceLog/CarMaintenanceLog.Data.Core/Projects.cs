using System;
using System.Collections.Generic;

namespace CarMaintenanceLog.Data.Core
{
    public partial class Projects
    {
        public Projects()
        {
            EmployeeProjects = new HashSet<EmployeeProjects>();
            ReportedTimeLogs = new HashSet<ReportedTimeLogs>();
            TimeLogs = new HashSet<TimeLogs>();
        }

        public int ProjectId { get; set; }
        public string Name { get; set; }
        public int CustomerId { get; set; }
        public double? HourlyRate { get; set; }
        public double? DefaultMiles { get; set; }
        public int? DefaultTermId { get; set; }

        public virtual Customers Customer { get; set; }
        public virtual Terms DefaultTerm { get; set; }
        public virtual ICollection<EmployeeProjects> EmployeeProjects { get; set; }
        public virtual ICollection<ReportedTimeLogs> ReportedTimeLogs { get; set; }
        public virtual ICollection<TimeLogs> TimeLogs { get; set; }
    }
}
