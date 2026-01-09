@ECHO OFF

SETLOCAL ENABLEDELAYEDEXPANSION

TF >>NUL
IF NOT "%ERRORLEVEL%"=="0" (
	ECHO Microsoft Visual Studio Team Foundation Server PowerTools are not installed.  Download the Tools and ensure the are in your PATH.
	START /D "%ProgramFiles%\Internet Explorer\" "iexplore.exe" "https://marketplace.visualstudio.com/items?itemName=TFSPowerToolsTeam.MicrosoftVisualStudioTeamFoundationServer2013Power"
	GOTO Done
)

REM Lookup TFS Workspace path
FOR /F "tokens=* USEBACKQ" %%F IN (`TF WORKFOLD $\`) DO (
	SET input=%%F
	SET prefix=!input:~0,3!
	IF XX!prefix!XX==XX$/:XX (
		SET TFS_BASE=!input:~4!
	)
)
CD /D "%TFS_BASE%"
ECHO TFS_BASE= %TFS_BASE%


REM ... Do Work Here - Below

REM ... Do Work Here - Above

:Done
ENDLOCAL