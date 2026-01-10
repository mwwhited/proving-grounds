Imports System
Imports Microsoft.Win32

Public Class WhitedUS

    'Class file for Whited.US IANA Enterprise ID 21371
    'Copyright Matthew Whited (matt@whitedonline.com

    Public Function GetRootKey() As RegistryKey
        'Build Root for Whited.US Products
        Err.Clear()
        Dim uKey As RegistryKey
        uKey = My.Computer.Registry.CurrentUser.OpenSubKey("SOFTWARE", True).OpenSubKey("Whited.US", True)
        If uKey Is Nothing Then
            My.Computer.Registry.CurrentUser.OpenSubKey("SOFTWARE", True).CreateSubKey("Whited.US", RegistryKeyPermissionCheck.ReadWriteSubTree)
            uKey = My.Computer.Registry.CurrentUser.OpenSubKey("SOFTWARE", True).OpenSubKey("Whited.US", True)
            uKey.SetValue("IANA-EnterpriseID", "21371")
            uKey.SetValue("ContactEmail", "matt@whitedonline.com")
        End If
        GetRootKey = uKey
        If Err.Number <> 0 Then
            MsgBox("Problem with Registry (Whited.US)")
            End
        End If

        uKey = Nothing

    End Function

End Class
