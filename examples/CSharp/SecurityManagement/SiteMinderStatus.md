# Policy Server :: Disable Flag : SmAuthReason
#### Document ID : KB000049509
#### Last Modified Date : 14/09/2018
#### Show Technical Document Details 

## Introduction: 

### Description:
I am configuring Password Policies and I would like to know how the Disable Flag value from the Active Directory User Store and SmAuthReason value are related?

### Solution:
Let’s take an example.

When you configure the Active Directory User Store, and configure the attribute Disable Flag like this:

    Disabled Flag (RW): userAccountControl 

Here is how the Policy Server code will make the SmAuthReason value.

Policy Server will make the SmAuthReason value on the base of the value of userAccountControl. Which means, the authentication is based on the “account state” and not the “password state”.
Now, all the all possible values of the Disable Flag are:

	smdisabledflag=0
	smdisabledflag=1
	smdisabledflag=10
	smdisabledflag=16777216
	smdisabledflag=16777217
	smdisabledflag=16777218
	smdisabledflag=16777220
	smdisabledflag=2
	smdisabledflag=4
	smdisabledflag=6
	smdisabledflag=8
	smdisabledflag=9

which means:

	public static final int DMSUSER_DISABLED_ADMINDISABLED 1
	public static final int DMSUSER_DISABLED_DISABLEDMASK 16777215
	public static final int DMSUSER_DISABLED_ENABLED 0
	public static final int DMSUSER_DISABLED_INACTIVITY 4
	public static final int DMSUSER_DISABLED_MAXLOGINFAIL 2
	public static final int DMSUSER_DISABLED_PEERDISABLED 16
	public static final int DMSUSER_DISABLED_PWEXPIRED 8
	public static final int DMSUSER_DISABLED_PWMUSTCHANGE 16777216

The remaining reason codes are combinations of what you see from the chart above as:

	3 = 1(DMSUSER_DISABLED_ADMINDISABLED) + 2(DMSUSER_DISABLED_MAXLOGINFAIL)
	5 = 4(DMSUSER_DISABLED_INACTIVITY) + 1(DMSUSER_DISABLED_ADMINDISABLED)
	6 = 4(DMSUSER_DISABLED_INACTIVITY) + 2(DMSUSER_DISABLED_MAXLOGINFAIL )
	7=4+2+1
	9=8+1
	16777217=16777216 + 1
	16777218=16777216 + 2
	16777220=16777216 + 4
	16777221=16777216 + 4+ 1
	16777222=16777216 + 4+ 2

Now, in any User Store, the Disabled Flag attribute is a 32-bit integer stored in each user’s directory record.  Policy Server only read and writes value in it.

But for User Stores based on Active Directory, the Policy Server calculates the Disabled Flag value from various Active Directory status values. When the Policy Server sends a Disabled Flag value to Active Directory, it makes a reverse computation of the value, and the Active Directory status value is modified accordingly.

That way, the Policy Server will map the Disable Flag to the SmAuthReason like this:

	Reason Disabled flag SMAUTHREASON
	Admin disabled 1 7
	Inactivity 4 25
	Max login failed 2 4
	PwExpired 8 19
	PwMustChange 16777216 20
	[...]

The most important thing to consider is that if the reason "Admin disable" is set, then you will get SmAuthReason 7, as "Admin disable" is given precedence over any other type of reason.
Disabled flag with values as 1, 5, 7, 9, 11, 13, 15 etc will have SMAuthreason as 7 as all of these will be having '1' (disabled due to admin) as one of reasons.
That is why the return codes 532, 533, and 701 you may get from Active Directory doesn’t correspond to the SmAuthReason value. Policy Server relies on the Disable Flag value and then, if the SmAuthReason is set to 7, this means that the bit 1 is set to the user’s Disable Flag value.

Further, Policy Server treats the "Disabled Flag" integer value as a collection of 32 indicator bits; the low-order 24 bits are reserved as user account disabled bits, and the high-order 8 bits are reserved as user-specific status bits.

The meaning of the bits can be seen in the Sm_Api_DisabledReason_T enumeration in the file SmApi.h found in the SiteMinder SDK:

    /*
    * Clients that use the values below should be aware
    * that multiple reasons can exist concurrently, and
    * that when a user is enabled, all of the flags in the
    * disabled mask should be cleared
    */
    enum Sm_Api_DisabledReason_t
    {
        /* disabled mask */
        Sm_Api_Disabled_DisabledMask = 0x00ffffff
        ,Sm_Api_Disabled_Enabled = 0

        /* disabled bits */
        ,Sm_Api_Disabled_AdminDisabled = 0x00000001
        ,Sm_Api_Disabled_MaxLoginFail = 0x00000002
        ,Sm_Api_Disabled_Inactivity = 0x00000004
        ,Sm_Api_Disabled_PWExpired = 0x00000008

        /* qualifiers */
        ,Sm_Api_Disabled_PWMustChange = 0x01000000

        /* a new disabled bit
        * When the account is natively disabled by the directory, and SM is not able to enable it.
        * For example, AD user will expire when the "accountExpires" time has passed.
        */
        ,Sm_Api_Disabled_DirNativeDisabled = 0x00000010

        ,Sm_Api_Disabled_NetworkError = 0x00000020
        ,Sm_Api_Disabled_UserNotFound = 0x00000040
    };


### Note that:

  1. The bit mask Sm_Api_Disabled_DisabledMask covers the 24 reserved disabled bits.
  2. The Sm_Api_Disabled_PWMustChange bit ("password must change") is a status bit, not one of the disabled bits.
  3. The Sm_Api_Disabled_DirNativeDisabled, Sm_Api_Disabled_NetworkError, and Sm_Api_Disabled_UserNotFound bits are not stored in a user's directory record but may be set in the in-memory version during runtime.

The bits in the Disabled Flag attribute for a user can be changed using the appropriate set/get functions in the Directory API or various Policy Management API functions. The Policy Management API functions are invoked when the "Manage User Accounts" functionality of the Admin UI is used to Enable/Disable a user account, or to set/clear the password-must-change status.
The Sm_Api_Disabled_AdminDisabled bit is usually set by using the Admin UI's disable user button; the Policy Server does not set or clear it during normal operations. When "enable user" is selected through the Admin UI ALL bits covered by Sm_Api_Disabled_DisabledMask are cleared, while the status bits (e.g. Sm_Api_Disabled_PWMustChange) are left unaffected.
It is unusual for more than one of the disabled bits to be set at a time -- The directory provider for Active Directory may return more than one under the right conditions. Normal password services processing sets only one at a time. The most likely way for the Sm_Api_Disabled_AdminDisabled bit to be set when one of the other disabled bits is also set, is for that other bit to have first been set in normal operations (see below) and then the Admin UI's "disable user" button is used to set Sm_Api_Disabled_AdminDisabled.

The basic control flow relating to the Disabled Flag attribute during user authentication is:

  1.  user is challenged for credentials (assume user ID and password)
  2.  Disabled Flag attribute for the user is fetched/calculated
  3.  If any of the disabled bits covered by Sm_Api_Disabled_DisabledMask are already set, authentication fails with the reason code Sm_Api_Reason_UserDisabled (7).
  4.  If the user's credentials are not correct authentication fails and an appropriate reason code is returned depending on password policies, etc. Note that if the maximum number of allowed failed login attempts is exceeded here, the Sm_Api_Disabled_MaxLoginFail disabled bit in the user's Disabled Flag would also be set.
  5.  If the credentials are correct, other statuses checked:

      a.  if the account inactivity limit was exceeded, the Sm_Api_Disabled_Inactivity disabled bit is set and Sm_Api_Reason_AccountInactivity is returned.
      b.  if the password change time limit was exceeded, the Sm_Api_Disabled_PWExpired disabled bit is set and Sm_Api_Reason_PwExpired is returned.
      c.  if the password age is in the must change window, the Sm_Api_Disabled_PWMustChange status bit is set and depending on other settings (e.g. grace period) either Sm_Api_Reason_PwMustChange or Sm_Api_Reason_ImmedPWChangeRequired is returned.

  6.  If the credentatials are correct and none of the above returns were triggered, then if the Sm_Api_Disabled_PWMustChange status bit is set, Sm_Api_Reason_ImmedPWChangeRequired is returned. Note that certain system errors during the above processing would cause Sm_Api_Reason_UnknownUser to be returned.

It should be apparent from the above sequence that the Sm_Api_Disabled_PWMustChange status bit might be set during an authentication attempt and a subsequent attempt could cause a disabled bit to then be set as well. Also, the Admin UI can be used to set/clear the Sm_Api_Disabled_PWMustChange status bit for a user independently of the state of any of the other bits.
When Directory Mapping is used then during user's authorization phase the Disabled Flag attribute for the user is refetched/recalculated. If any of the disabled bits covered by Sm_Api_Disabled_DisabledMask are set, authorization fails with the reason code Sm_Api_Reason_UserDisabled (7).

### Appendix
    SmAuthReason: :
        Sm_Api_Reason_None = 0
        Sm_Api_Reason_PwMustChange = 1
        Sm_Api_Reason_InvalidSession = 2
        Sm_Api_Reason_RevokedSession = 3
        Sm_Api_Reason_ExpiredSession = 4
        Sm_Api_Reason_AuthLevelTooLow = 5
        Sm_Api_Reason_UnknownUser = 6
        Sm_Api_Reason_UserDisabled = 7
        Sm_Api_Reason_InvalidSessionId = 8
        Sm_Api_Reason_InvalidSessionIp = 9
        Sm_Api_Reason_CertificateRevoked = 10
        Sm_Api_Reason_CRLOutOfDate = 11
        Sm_Api_Reason_CertRevokedKeyCompromised = 12
        Sm_Api_Reason_CertRevokedAffiliationChange = 13
        Sm_Api_Reason_CertOnHold = 14
        Sm_Api_Reason_TokenCardChallenge = 15
        Sm_Api_Reason_ImpersonatedUserNotInDir = 16
        Sm_Api_Reason_Anonymous = 17
        Sm_Api_Reason_PwWillExpire = 18
        Sm_Api_Reason_PwExpired = 19
        Sm_Api_Reason_ImmedPWChangeRequired = 20
        Sm_Api_Reason_PWChangeFailed = 21
        Sm_Api_Reason_BadPWChange = 22
        Sm_Api_Reason_PWChangeAccepted = 23
        Sm_Api_Reason_ExcessiveFailedLoginAttempts = 24
        Sm_Api_Reason_AccountInactivity = 25
        Sm_Api_Reason_NoRedirectConfigured = 26
        Sm_Api_Reason_ErrorMessageIsRedirect = 27
        Sm_Api_Reason_Next_Tokencode = 28
        Sm_Api_Reason_New_PIN_Select = 29
        Sm_Api_Reason_New_PIN_Sys_Tokencode = 30
        Sm_Api_Reason_New_User_PIN_Tokencode = 31
        Sm_Api_Reason_New_PIN_Accepted = 32
        Sm_Api_Reason_Guest = 33
        Sm_Api_Reason_PWSelfChange = 34
        Sm_Api_Reason_ServerException = 35
        Sm_Api_Reason_UnknownScheme = 36
        Sm_Api_Reason_UnsupportedScheme = 37
        Sm_Api_Reason_Misconfigured = 38
        Sm_Api_Reason_BufferOverflow = 39
        Sm_Api_Reason_SetPersistentSessionFailed = 40
        Sm_Api_Reason_UserLogout = 41
        Sm_Api_Reason_IdleSession = 42
        Sm_Api_Reason_PolicyServerEnforcedTimeout = 43
        Sm_Api_Reason_PolicyServerEnforcedIdle = 44
        Sm_Api_Reason_ImpersonationNotAllowed = 45
        Sm_Api_Reason_ImpersonationNotAllowedUser = 46
        Sm_Api_Reason_FederationNoLoginID = 47
        Sm_Api_Reason_FederationUserNotInDir = 48
        Sm_Api_Reason_FederationInvalidMessage = 49
        Sm_Api_Reason_FederationUnacceptedMessage  = 50
        Sm_Api_Reason_ADnativeUserDisabled  = 51

### Instructions: 

Please Update This Required Field 