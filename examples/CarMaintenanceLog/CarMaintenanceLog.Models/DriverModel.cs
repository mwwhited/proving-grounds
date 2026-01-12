using System;

namespace CarMaintenanceLog.Models
{
    public class DriverModel
    {
        public int DriverId { get; set; }
        public string Name { get; set; }
        public Guid? UserId { get; set; }
    }
}
