using System;

namespace Originations.DataProviders.SecurityManagement
{
    internal class SecurityLockoutInfo : ISecurityLockoutInfo
    {
        public bool IsLockedout { get; internal set; }
        public DateTime? LockoutTime { get; internal set; }
        public bool IsPasswordExpired { get; internal set; }
    }
}