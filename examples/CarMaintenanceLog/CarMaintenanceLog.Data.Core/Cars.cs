using System;
using System.Collections.Generic;

namespace CarMaintenanceLog.Data.Core
{
    public partial class Cars
    {
        public Cars()
        {
            Employees = new HashSet<Employees>();
            FillUps = new HashSet<FillUps>();
            InsurancePayments = new HashSet<InsurancePayments>();
            MaintenanceSchedules = new HashSet<MaintenanceSchedules>();
            OilChanges = new HashSet<OilChanges>();
            OtherServices = new HashSet<OtherServices>();
            Payments = new HashSet<Payments>();
            TimeLogs = new HashSet<TimeLogs>();
            Tires = new HashSet<Tires>();
        }

        public int CarId { get; set; }
        public int DriverId { get; set; }
        public string Make { get; set; }
        public string Model { get; set; }
        public int Year { get; set; }
        public string SubModel { get; set; }
        public decimal StartingMiles { get; set; }
        public string Notes { get; set; }
        public DateTime? PurchasedDate { get; set; }
        public DateTime? SoldDate { get; set; }

        public virtual Drivers Driver { get; set; }
        public virtual ICollection<Employees> Employees { get; set; }
        public virtual ICollection<FillUps> FillUps { get; set; }
        public virtual ICollection<InsurancePayments> InsurancePayments { get; set; }
        public virtual ICollection<MaintenanceSchedules> MaintenanceSchedules { get; set; }
        public virtual ICollection<OilChanges> OilChanges { get; set; }
        public virtual ICollection<OtherServices> OtherServices { get; set; }
        public virtual ICollection<Payments> Payments { get; set; }
        public virtual ICollection<TimeLogs> TimeLogs { get; set; }
        public virtual ICollection<Tires> Tires { get; set; }
    }
}
