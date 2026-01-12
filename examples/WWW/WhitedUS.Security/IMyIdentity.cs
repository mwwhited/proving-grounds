using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Security.Principal;

namespace WhitedUS.Security
{
    public interface IMyIdentity : IIdentity, IMyResource
    {
        Guid MyIdentityID { get; }
    }
}
