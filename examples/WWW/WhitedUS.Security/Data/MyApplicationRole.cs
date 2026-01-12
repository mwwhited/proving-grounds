using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Security.Data
{
    public partial class MyApplicationRole
    {
        partial void OnCreated()
        {
            this.UniqueID = Guid.NewGuid();
            this.DateCreated = DateTime.UtcNow;
        }
    }
}
