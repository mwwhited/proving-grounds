@ECHO OFF

SET STARTPATH_CLOAK=%~dp0

REM Check is Team Foundation PowerTools are Installs
TF >>NUL
IF NOT "%ERRORLEVEL%"=="0" SET PATH=%PATH%;C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\
TF >>NUL
IF NOT "%ERRORLEVEL%"=="0" (
	ECHO Microsoft Visual Studio Team Foundation Server PowerTools are not installed.  Download the Tools and ensure the are in your PATH.
	START /D "%ProgramFiles%\Internet Explorer\" "iexplore.exe" "https://marketplace.visualstudio.com/items?itemName=TFSPowerToolsTeam.MicrosoftVisualStudioTeamFoundationServer2013Power"
	GOTO Error
)

REM Lookup TFS Workspace path
FOR /F "tokens=* USEBACKQ" %%F IN (`TF WORKFOLD $\`) DO (
	SET input=%%F
	SET prefix=!input:~0,3!
	IF XX!prefix!XX==XX$/:XX (
		SET TFS_BASE=!input:~4!
	)
)
IF NOT DEFINED TFS_BASE SET TFS_BASE=c:\tfs
CD /D "%TFS_BASE%"
ECHO TFS_BASE= %TFS_BASE%

SET /P BranchSource=Source Branch Name (Default Ds2): 
IF NOT EXIST BranchSource SET BranchSource=DS2

SET /P BranchTarget=Target Branch Name (Default Projects/CMS): 
IF NOT EXIST BranchTarget SET BranchTarget=Projects/CMS

tf shelvesets
SET /P ShelfName=Shelf set Name: 


ECHO Shelfset: "%ShelfName%" 
ECHO Source: "$/Contract Management/%BranchSource%" 
ECHO Target: "$/Contract Management/%BranchTarget%"
tfpt unshelve "%ShelfName%" /migrate /source:"$/Contract Management/%BranchSource%" /target:"$/Contract Management/%BranchTarget%"

PAUSE