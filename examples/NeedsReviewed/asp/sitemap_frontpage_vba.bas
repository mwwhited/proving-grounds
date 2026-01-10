Attribute VB_Name = "sitemap"
Sub CreateSiteMap()
' Creates a Google Sitemap.xml for an open web
'
' Matthew Whited (matt@whited.us)
'
' adaptation of "FrontPage 2003: Simple Google Sitemap VBA Macro"
' http://www.thozie.de/dnn/Webmaster.aspx?PageContentID=7
'
Dim objNavNode As NavigationNode
Dim objParentNode As NavigationNode
Dim objFile As WebFile
Dim baseUrl As String
Dim siteUrl As String
Dim relPath As String, relTime As String
Const sitemapPath = "sitemap.xml" ' Edit if necessary

siteUrl = InputBox("Base URL for published site", "Google Sitemap Generator", "http://www.") + "/"
baseUrl = ActiveWeb.Url + "/"

Set fs = CreateObject("Scripting.FileSystemObject")
Dim ts
Set ts = fs.createtextfile(ActiveWeb.RootFolder.Name + "\\" + sitemapPath, True)

    ts.write "<?xml version='1.0' encoding='UTF-8' ?>" & vbCrLf
    ts.write "<urlset xmlns='http://www.google.com/schemas/sitemap/0.84' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xsi:schemaLocation='http://www.google.com/schemas/sitemap/0.84 http://www.google.com/schemas/sitemap/0.84/ sitemap.xsd'>" & vbCrLf

Dim testvar

On Error Resume Next
For Each objNavNode In ActiveWeb.AllNavigationNodes
  Set objParentNode = objNavNode.Parent
  If objParentNode Is ActiveWeb.RootNavigationNode Then
    Set objParentNode = objNavNode
  End If

  If Not objNavNode.IsLinkBar And Not objParentNode.IsLinkBar And Not objNavNode.File Is Nothing Then
    If objNavNode.File.Properties.Item("vti_donotpublish") = Empty Then
      relPath = ActiveWeb.Application.MakeRel(baseUrl, objNavNode.Url)
      'relTime =
        
        ts.write "<url><loc>"
            ts.write siteUrl + relPath
        ts.write "</loc><lastmod>"
            On Error GoTo 0
            ts.write ConvertTimeStamp(objNavNode.File.Properties("vti_timelastmodified"))
            On Error Resume Next
        ts.write "</lastmod></url>" & vbCrLf
    End If
   End If
Next
ts.write "</urlset>"
ts.Close

Set objFile = ActiveWeb.RootFolder.Files(sitemapPath)
objFile.Open
End Sub

Function ConvertTimeStamp(InputTimeStamp)
    'in: 5/20/2006 12:48:51 PM
    'out: 2006-05-27T03:57:02+00:00
    Dim OutputTimeStamp
    Dim ztemp1 As Variant, ztemp2 As Variant, ztemp3 As Variant
    Dim Year, Month, Day, Hour, Minute, Second, APM
    ztemp1 = Split(InputTimeStamp, " ")
    ztemp2 = Split(ztemp1(0), "/")
    ztemp3 = Split(ztemp1(1), ":")
    
    APM = ztemp1(2)
    
    Month = ztemp2(0)
    If Len(Month) = 1 Then Month = "0" & Month
    Day = ztemp2(1)
    If Len(Day) = 1 Then Day = "0" & Day
    Year = ztemp2(2)
    
    Hour = ztemp3(0)
    If APM = "PM" Then Hour = Val(Hour) + 12
    If Hour = "12" Then Hour = "00"
    If Hour = "24" Then Hour = "12"
    If Len(Hour) = 1 Then Hour = "0" & Hour
    Minute = ztemp3(1)
    Second = ztemp3(2)
    
    OutputTimeStamp = Year & "-" & Month & "-" & Day & "T"
    OutputTimeStamp = OutputTimeStamp & Hour & ":" & Minute & ":" & Second
    OutputTimeStamp = OutputTimeStamp & "+00:00"
    
    ConvertTimeStamp = OutputTimeStamp
    
    'OutputTimeStamp = Nothing
    'ztemp1 = Nothing: ztemp2 = Nothing: ztemp3 = Nothing
    'Year = Nothing: Month = Nothing: Day = Nothing
    'Hour = Nothing: Minute = Nothing: Second = Nothing
    'APM = Nothing
    
    
End Function

