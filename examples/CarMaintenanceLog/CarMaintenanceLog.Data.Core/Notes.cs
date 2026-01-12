using System;
using System.Collections.Generic;

namespace CarMaintenanceLog.Data.Core
{
    public partial class Notes
    {
        public int NoteId { get; set; }
        public DateTime Date { get; set; }
        public string Note { get; set; }
        public bool? Complete { get; set; }
    }
}
