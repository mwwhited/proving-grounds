using System;

namespace Originations.DataProviders.SecurityManagement
{
    public interface ISecurityLockoutInfo
    {
         bool IsLockedout { get; }
         DateTime? LockoutTime { get;  }
         bool IsPasswordExpired { get; }
    }
}