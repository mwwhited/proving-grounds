using System;
using System.Collections.Generic;

namespace CarMaintenanceLog.Data.Core
{
    public partial class Employees
    {
        public Employees()
        {
            EmployeeProjects = new HashSet<EmployeeProjects>();
        }

        public int EmployeeId { get; set; }
        public Guid? UserId { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public int? DefaultCarId { get; set; }

        public virtual Cars DefaultCar { get; set; }
        public virtual ICollection<EmployeeProjects> EmployeeProjects { get; set; }
    }
}
