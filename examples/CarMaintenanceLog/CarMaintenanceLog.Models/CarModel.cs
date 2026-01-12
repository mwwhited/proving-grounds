using System;

namespace CarMaintenanceLog.Models
{
    public class CarModel
    {
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

    }
}
