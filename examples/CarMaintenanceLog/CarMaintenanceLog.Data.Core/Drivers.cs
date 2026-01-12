using System;
using System.Collections.Generic;

namespace CarMaintenanceLog.Data.Core
{
    public partial class Drivers
    {
        public Drivers()
        {
            Cars = new HashSet<Cars>();
        }

        public int DriverId { get; set; }
        public string Name { get; set; }
        public Guid? UserId { get; set; }

        public virtual ICollection<Cars> Cars { get; set; }
    }
}
