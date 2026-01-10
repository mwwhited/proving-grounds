<%
' Copyright 2001 Polonia Online Information Services
' 
' This code is intended for instructional use only.
' 
' This sample searches the Verisign directory for a company, 
' lists its details and allows downloads of the digital
' certificates of that company.

Response.Buffer = True
Response.Expires = 0
Response.CacheControl = "private"

If Request.Form( "DownloadCertDn" ) <> "" Then
	Call DownloadCertDn( Request.Form( "DownloadCertDn" ) )
Else
	If Request.Form( "Search" ) <> "" Then
		Call DisplaySearchResults( CStr( Request.Form( "Search" ) ) )
	Else
		Call DisplaySearchForm
	End If
End If


Sub DisplaySearchForm
%>
<html>
<head>
<title>Verisign Certificate Search</title>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<p><h3>Search Verisign's certificate directory (directory.verisign.com):</h3></p>
<form action="<%= Request.ServerVariables( "SCRIPT_NAME" ) %>" method="post">
company name: <input name="Search" type="text" value="Polonia Online*"> <input type="submit" value="search">
</form>
</body>
</html>
<%
End Sub		

Sub DisplaySearchResults( SearchFilter )
%>
<html>
<head>
<title>Verisign Certificate Search Results</title>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<h3>Found the following certificates:</h3>
<form action="<%= Request.ServerVariables( "SCRIPT_NAME" ) %>" method="post" name="DownloadCertificateForm">		
<input name="DownloadCertDn" type="hidden">
<%
	Set LDAP = Server.CreateObject( "LDAPClient.2" )
	LDAP.Connect "directory.verisign.com"

	' Verisign does not accept search bases.
	Set Entries = LDAP.Search( "", "cn=" + SearchFilter )

	For Each Entry In Entries
%>
	<p>
	<%=  Entry.Attributes("cn").Values(0) %>
	<a href="#" onclick="javascript:DownloadCertDn.value=unescape('<%= Server.HTMLEncode(Entry.dn) %>'); DownloadCertificateForm.submit(); return false;">
		<%= Entry.Attributes("ou").Values(0).Value %>
	</a>
	</p>
<%
	Next
%>
</form>
</body>
</html>
<%
End Sub

Sub DownloadCertDn( SearchDn )
	Set LDAP = Server.CreateObject( "LDAPClient.2" )
	LDAP.Connect "directory.verisign.com"
	
	' There should be exactly one entry that matches this dn.
	' we're using the exact dn of the entry as the search base, then
	' using objectClass=* to simply retrieve whatever is at that dn.
	Set Entry = LDAP.Search( SearchDn, "objectClass=*" ).Item(0)

	' give back a .cer file.
	Response.ContentType = "application/pkix-cert"
	Response.Addheader "Content-Disposition", "inline; filename=" & Entry.Attributes("ou").Values(0).Value + ".cer"
	
	' The certificate has to be encoded in Base64 or it's not valid.
	Response.Write Base64Encode( BinaryToString( Entry.Attributes( "usercertificate;binary" ).Values(0).BinaryValue ) )
	
	Response.End
End Sub

Function ReplaceQuotes( str )
	ReplaceQuotes = Replace( str, """", "''" )
End Function

' The following Base64 encoding function and peripharal functions have
' been copied from http://www.pstruh.cz/tips/detpg_Base64Encode.htm.
' Some modifications were made to comply with Microsoft CryptoAPI 
' certificate validating functionality.
Function Base64Encode(inData)
  'rfc1521
  '2001 Antonin Foller, PSTRUH Software, http://pstruh.cz
  Const Base64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
  Dim cOut, sOut, I
  
  'For each group of 3 bytes
  For I = 1 To Len(inData) Step 3
    Dim nGroup, pOut, sGroup
    
    'Create one long from this 3 bytes.
    nGroup = &H10000 * Asc(Mid(inData, I, 1)) + _
      &H100 * MyASC(Mid(inData, I + 1, 1)) + MyASC(Mid(inData, I + 2, 1))
    
    'Oct splits the long to 8 groups with 3 bits
    nGroup = Oct(nGroup)
    
    'Add leading zeros
    nGroup = String(8 - Len(nGroup), "0") & nGroup
    
    'Convert to base64
    pOut = Mid(Base64, CLng("&o" & Mid(nGroup, 1, 2)) + 1, 1) + _
      Mid(Base64, CLng("&o" & Mid(nGroup, 3, 2)) + 1, 1) + _
      Mid(Base64, CLng("&o" & Mid(nGroup, 5, 2)) + 1, 1) + _
      Mid(Base64, CLng("&o" & Mid(nGroup, 7, 2)) + 1, 1)
    
    'Add the part to output string
    sOut = sOut + pOut
    
    'Add a new line for each 72 chars in dest (72*3/4 = 54)
    If (I + 2) Mod 54 = 0 Then sOut = sOut + vbCr + vbCrLf
  Next
  Select Case Len(inData) Mod 3
    Case 1: '8 bit final
      sOut = Left(sOut, Len(sOut) - 2) + "=="
    Case 2: '16 bit final
      sOut = Left(sOut, Len(sOut) - 1) + "="
  End Select
  Base64Encode = sOut
End Function

Function MyASC(OneChar)
  If OneChar = "" Then MyASC = 0 Else MyASC = Asc(OneChar)
End Function

Function BinaryToString(Binary)
  'Antonin Foller, http://www.pstruh.cz
  'Optimized version of a simple BinaryToString algorithm.
  
  Dim cl1, cl2, cl3, pl1, pl2, pl3
  Dim L
  cl1 = 1
  cl2 = 1
  cl3 = 1
  L = LenB(Binary)
  
  Do While cl1<=L
    pl3 = pl3 & Chr(AscB(MidB(Binary,cl1,1)))
    cl1 = cl1 + 1
    cl3 = cl3 + 1
    If cl3>300 Then
      pl2 = pl2 & pl3
      pl3 = ""
      cl3 = 1
      cl2 = cl2 + 1
      If cl2>200 Then
        pl1 = pl1 & pl2
        pl2 = ""
        cl2 = 1
      End If
    End If
  Loop
  BinaryToString = pl1 & pl2 & pl3
End Function
%>