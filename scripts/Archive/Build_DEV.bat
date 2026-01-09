@ECHO OFF

IF "%TFSBASE%"=="" SET TFSBASE=C:\TFS
SET ENVIRONMENT=DEV

SET SETNUGET=%~dp0\SetupNuget.bat
IF EXIST "%SETNUGET%" (
	ECHO === Setup and Configure Nuget
	CALL "%SETNUGET%" %ENVIRONMENT%	
	SET ERR=!ERRORLEVEL!
 	ECHO === End: Setup and Configure Nuget - !ERR!
	IF NOT "!ERR!"=="0" GOTO Error
)

REM -- Script Level Variables

MSBUILD > NUL
IF "%ERRORLEVEL%"=="9009" SET PATH=%PATH%;C:\Windows\Microsoft.NET\Framework\v4.0.30319
NUGET > NUL
IF "%ERRORLEVEL%"=="9009" SET PATH=%PATH%;c:\Program Files (x86)\MSBuild\NuProj

SET LOCAL_NUGET=%TFSBASE%\Contract Management\%ENVIRONMENT%\out
SET LOCALBIN_CMS=%TFSBASE%\Contract Management\%ENVIRONMENT%\LocalBin
SET LOCALBIN_DFE=%TFSBASE%\Originations\%ENVIRONMENT%\LocalBin
SET STARTPATH=%CD%

SETLOCAL ENABLEDELAYEDEXPANSION

IF NOT EXIST "%LOCAL_NUGET%" (
	ECHO Create Local Nuget
	MKDIR "%LOCAL_NUGET%"
)
IF NOT EXIST "%LOCALBIN_CMS%" (
	ECHO Create LocalBin CMS
	MKDIR "%LOCALBIN_CMS%"
)
IF NOT EXIST "%LOCALBIN_DFE%" (
	ECHO Create LocalBin DFE
	MKDIR "%LOCALBIN_DFE%"
)

IF /I "%1"=="Clean" (
	ECHO == Clean and Build
	SET BUILD_PARAMS=/t:Clean,Build /m:8

	ECHO === Ensure Packages are Readonly
	CD /D "%TFSBASE%"
	FOR /R /D %%D IN (packages) DO (
		IF EXIST "%%D" (
			ATTRIB -R "%%D" /S /D >NUL
	 		RD /Q /S "%%D" >NUL
		)
	)
	ECHO Clean Local Nuget
	CD /D "%LOCAL_NUGET%"
        ATTRIB -R "%LOCAL_NUGET%\*.*" /S /D > NUL
	FOR /D %%A IN (*.*) DO RD /Q /S "%%A"
	DEL /F /S /Q *.* > NUL

 	FOR %%A IN ("Contract Management",Originations) DO (
		SET PROJECT=%%A
 		ECHO Clean Local Bin - !PROJECT!
 		SET LOCALBIN=%TFSBASE%\!PROJECT:"=!\%ENVIRONMENT%\LocalBin
		ECHO LocalBin= !LOCALBIN!
 		CD /D "!LOCALBIN!"
 	        ATTRIB -R "!LOCALBIN!\*.*" /S /D > NUL
 		FOR /D %%A IN (*.*) DO RD /Q /S %%A
 		DEL /F /S /Q *.* > NUL
 	)
)
IF /I NOT "%1"=="Clean" (
	ECHO == Build
	SET BUILD_PARAMS=/t:Build /m:8
)

ECHO === Start: Application Common\Contracts
CD /D "%TFSBASE%\Application Common\%ENVIRONMENT%\src\Assets\Contracts"
msbuild Contracts.sln %BUILD_PARAMS% /p:Configuration=Release /property:TeamBuildConstants=_TEAM_BUILD_
ECHO === End: Application Common\Contracts
IF "%ERRORLEVEL%"=="1" GOTO Error

CD /D "%TFSBASE%\Application Common\%ENVIRONMENT%\Nuspec"
FOR %%A IN (*.nuspec) DO (
	ECHO === Build %%A
	nuget pack %%A -OutputDirectory "%LOCAL_NUGET%"
	SET ERR=!ERRORLEVEL!
	REM IF NOT "!ERR!"=="0" GOTO Error
)

ECHO === Build CMS
FOR %%A IN (CMS.Services, CMS.Web, CMS.Batch, CMS.GatewayServices) DO (
	SET BUILDPATH=%TFSBASE%\Contract Management\%ENVIRONMENT%\build\%%A
	ECHO === Start: %%A
	IF EXIST "!BUILDPATH!" (
		CD /D "!BUILDPATH!"
		ECHO !CD!
		msbuild %BUILD_PARAMS%
		SET ERR=!ERRORLEVEL!
 		ECHO === End: %%A - !ERR!
		IF NOT "!ERR!"=="0" GOTO Error
	)
)

REM ECHO === DFE
REM FOR %%A IN (Originations.Services, Originations.Web, Originations.Batch) DO (
REM 	SET BUILDPATH=%TFSBASE%\Originations\%ENVIRONMENT%\build\%%A
REM 	ECHO === Start: %%A
REM 	IF EXIST "!BUILDPATH!" (
REM 		CD /D "!BUILDPATH!"
REM 		ECHO !CD!
REM 		msbuild %BUILD_PARAMS%
REM 		SET ERR=!ERRORLEVEL!
REM  		ECHO === End: %%A - !ERR!
REM 		IF NOT "!ERR!"=="0" GOTO Error
REM 	)
REM )

ECHO ***** Build Complete *****
GOTO Done

:Error
ECHO ***** Build Failed *****
PAUSE
EXIT /B 1

:Done
CD /D "%STARTPATH%"
ENDLOCAL
