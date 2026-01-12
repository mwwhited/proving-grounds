using System;
using System.Collections.Generic;

namespace CarMaintenanceLog.Data.Core
{
    public partial class FillUpsLocations
    {
        public int? StationId { get; set; }
        public int FillUpId { get; set; }
        public int CarId { get; set; }
        public int DriverId { get; set; }
        public string Station { get; set; }
        public string Address1 { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string ZipCode { get; set; }
        public decimal TankMiles { get; set; }
        public DateTime Date { get; set; }
        public int Year { get; set; }
        public string Make { get; set; }
        public string Model { get; set; }
        public long? OrderNumber { get; set; }
    }
}
