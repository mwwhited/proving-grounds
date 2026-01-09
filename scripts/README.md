# Local Build Scripts

These may require you install 
    
 * [Team Foundation Server Tools](https://marketplace.visualstudio.com/items?itemName=TFSPowerToolsTeam.MicrosoftVisualStudioTeamFoundationServer2013Power)
 * [Nuget Package Project for Visual Studio](https://marketplace.visualstudio.com/items?itemName=NuProjTeam.NuGetPackageProject) <= no longer required

*DO NOT FORGET TO INSTALL IIS*

 * [IIS Install](http://confluence.sfam.americas.bmw.corp:8090/display/SA/Installing+IIS)
 * Setup IIS with this tool [IISWebModuleManager]($\Contract Management\Dev\src\Tools\BookingTestTools\IISWebModuleManager)

## Local Build Scripts

 * [Get and Build - DEV.lnk] - This will get latest and build RITA - CMS DEV
 * [Get and Build - DS2.lnk] - This will get latest and build RITA - CMS DS2
 * [Get, Clean and Build - DEV.lnk] - This will get latest, clean up and build RITA - CMS DEV
 * [Get, Clean and Build - DS2.lnk] - This will get latest, clean up and build RITA - CMS DS2
 * [GetLatest.bat] - This will get latest on select team projects 
 * [GetLatestOverwriteForce.bat] - This will force/get latest on select team projects 
 * [MapE.bat] - This will create a virtual mapping for an E: drive
 * [Set Nuget to Dev.lnk] - This will Ensure that Nuget is configured for DEV and DS2 then set Nuget to Dev
 * [Set Nuget to DS2.lnk] - This will Ensure that Nuget is configured for DEV and DS2 then set Nuget to Dev
 * [InstallIIS.bat] - This will install IIS on your local machine
 * [SetupNuget.bat] - This will Ensure that Nuget is configured for DEV and DS2
 * [SetupWorkspace.bat] - This configure TFS, Nuget and get the base development code

## Starter Scripts
 * [README.md] - This File
 * [GetAndBuild.bat] - This is a base script that should not be ran directly

## Old Scripts
 * [Archive\Build_DEV - Clean.lnk]
 * [Archive\Build_DEV.bat]
 * [Archive\Build_DS2 - Clean.lnk]
 * [Archive\Build_DS2.bat]
 * [Archive\CMS.Web.IISSetup.ps1]
 * [Archive\CopyContracts.bat]
 * [Archive\CheckPowerTools.bat]


### May need to add this to TF.exe.config

C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE

  <system.net>
    <defaultProxy useDefaultCredentials="true" enabled="true">
      <proxy usesystemdefault="True"/>
    </defaultProxy> 
  </system.net>


### Helpful cloaks

 * C:\tfs\Contract Management\Dev\src\Tools\BookingTestTools\packages