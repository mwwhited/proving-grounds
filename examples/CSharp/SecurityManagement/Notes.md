## Secure Management

 This data access provider was originally branched from $/Dealer and Funding/DevOps/DF3/Sprint/src/Middleware/libInfoBahn/SecurityManagement/src/SecurityManagement

## New LDAP Schema

    dc=oobfs,dc=internal
        ou=InfoBahn
            ou=<<Dealer Market>> (USA, CAN, MEX, BRA)
                cn=<<firstname>>.<<lastname>>
            ou=Internal
                cn=<<Q#>>

    -- user object
        schemaClass : user
        cn : <<Q#>> || <<firstname>>.<<lastname>> 
    
## Related Notes
    
   * [Set or Modify the Password of an AD LDS User](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731012(v=ws.10))
   * [How to find out which naming contexts and application partitions are hosted by an AD LDS instance](https://adamsync.wordpress.com/2012/06/21/how-to-find-out-which-naming-contexts-and-application-partitions-are-hosted-by-an-ad-lds-instance/)

      * Powershell: (Get-ADRootDSE -Server localhost:389).namingContexts
      * ldifde: ldifde -f con -s localhost:389 -d “” -p base -l namingContexts
      * GUI: ldp.exe localhost:389
   * https://www.free-online-training-courses.com/configuring-and-using-ad-lds/
   * https://thesharepointfarm.com/2012/01/active-directory-lightweight-directory-services-application-data-partitions/
   * http://www.selfadsi.org/index.htm


## if need to work with AD LDS timestamps later 

    private static DateTime GetTimeStampProperty(DirectoryEntry entry, string propertyName)
    {
        var propertyReference = entry.Properties[propertyName];
        if (propertyReference.Count == 1)
        {
            var propertyValue = ConvertADSLargeIntegerToInt64(propertyReference.Value);
            var timestamp = DateTime.FromFileTimeUtc(propertyValue);
            return timestamp;
        }
        return DateTime.MinValue;
    }
    private static long ConvertADSLargeIntegerToInt64(object adsLargeInteger)
    {
        var objType = adsLargeInteger.GetType();
        var highPart = (int)objType.InvokeMember("HighPart", BindingFlags.GetProperty, null, adsLargeInteger, null);
        var lowPart = (int)objType.InvokeMember("LowPart", BindingFlags.GetProperty, null, adsLargeInteger, null);
        return highPart * ((long)uint.MaxValue + 1) + lowPart;
    }


## other notes

 * https://stackoverflow.com/questions/32353869/ldap-server-policy-hints-oid-control-not-working-in-ad-lds-windows-server-2012r2
 * https://stackoverflow.com/questions/1394025/active-directory-ldap-check-account-locked-out-password-expired
 * https://stackoverflow.com/questions/18615958/ldap-pwdlastset-unable-to-change-without-error-showing
 * http://erlend.oftedal.no/blog/?blogid=57
 * http://www.informit.com/articles/article.aspx?p=474649&seqNum=3


password age, 
force password change 
last login
expired date? 
locktime 

badpassword
badpasswordcount

lockouttime

lastLogonTimestamp
modifyTimeStamp
msDS-UserPasswordExpired
pwdLastSet 
whenChanged
