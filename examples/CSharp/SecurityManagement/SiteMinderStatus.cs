using System;

namespace Originations.DataProviders.SecurityManagement
{
    // https://comm.support.ca.com/kb/policy-server-disable-flag-smauthreason/kb000049509
    [Flags]
    public enum SiteMinderStatus
    {
        /// <remarks>This should be "Enabled" but sonar was complaining</remarks>
        None = 0,

        AdminDisabled = 1,
        MaxLoginFail = 2,
        Inactivity = 4,
        PasswordExpired = 8,
        PeerDisabled = 16,

        PswdMustChange = 16777216,
    }
}
