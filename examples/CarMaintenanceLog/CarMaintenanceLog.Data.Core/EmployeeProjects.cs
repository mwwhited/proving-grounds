using System;
using System.Collections.Generic;

namespace CarMaintenanceLog.Data.Core
{
    public partial class EmployeeProjects
    {
        public int EmployeProjectId { get; set; }
        public int EmployeeId { get; set; }
        public int ProjectId { get; set; }

        public virtual Employees Employee { get; set; }
        public virtual Projects Project { get; set; }
    }
}
