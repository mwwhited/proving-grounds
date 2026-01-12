using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Security.Data
{
    public partial class MyRole
    {
        partial void OnCreated()
        {
            this.DateCreated = DateTime.UtcNow;
            this.DateModified = DateTime.UtcNow;
            this.UniqueID = Guid.NewGuid();
        }

        partial void OnRoleNameChanged()
        {
            this.DateModified = DateTime.UtcNow;
        }

        partial void OnNotesChanged()
        {
            this.DateModified = DateTime.UtcNow;
        }
    }
}
