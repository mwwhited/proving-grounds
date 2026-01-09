@ECHO OFF

SETLOCAL ENABLEDELAYEDEXPANSION
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

SET TF_SWITCHES=/version:T /recursive /overwrite

IF /I "%1"=="Undo" (
	ECHO "Force Undo Checkout"
	tf undo "%TFS_BASE%" /recursive /noprompt 2>NUL
)
IF /I "%1"=="Reconcile" (
	ECHO "Force Reconcile"
	tf reconcile /clean 2>NUL
)

tf undo /recursive "%TFS_BASE%\Contract Management\Dev\out" 2>NUL
tf workfold /cloak "$\Contract Management\Dev\out" 2>NUL
ATTRIB -R /S /D "%TFS_BASE%\Contract Management\Dev\out" 2>NUL
tf undo /recursive "%TFS_BASE%\Contract Management\DS2\out" 2>NUL
tf workfold /cloak "$\Contract Management\DS2\out" 2>NUL
ATTRIB -R /S /D "%TFS_BASE%\Contract Management\DS2\out" 2>NUL

tf undo /recursive "%TFS_BASE%\Contract Management\Dev\LocalBin" 2>NUL
tf workfold /cloak "$\Contract Management\Dev\LocalBin" 2>NUL
ATTRIB -R /S /D "%TFS_BASE%\Contract Management\Dev\LocalBin" 2>NUL
tf undo /recursive "%TFS_BASE%\Contract Management\DS2\LocalBin" 2>NUL
tf workfold /cloak "$\Contract Management\DS2\LocalBin" 2>NUL
ATTRIB -R /S /D "%TFS_BASE%\Contract Management\DS2\LocalBin" 2>NUL

tf undo /recursive "%TFS_BASE%\Contract Management\LocalBin" 2>NUL
tf workfold /cloak "$\Contract Management\LocalBin" 2>NUL
ATTRIB -R /S /D "%TFS_BASE%\Contract Management\LocalBin" 2>NUL

tf undo /recursive "%TFS_BASE%\Contract Management\Dev\src\packages" 2>NUL
tf workfold /cloak "$\Contract Management\Dev\src\packages" 2>NUL
ATTRIB -R /S /D "%TFS_BASE%\Contract Management\Dev\src\packages" 2>NUL

tf undo /recursive "%TFS_BASE%\Contract Management\DS2\src\packages" 2>NUL
tf workfold /cloak "$\Contract Management\DS2\src\packages" 2>NUL
ATTRIB -R /S /D "%TFS_BASE%\Contract Management\DS2\src\packages" 2>NUL

tf undo /recursive "%TFS_BASE%\Contract Management\Dev\src\Tools\RitaDevelopmentToolkit\packages" 2>NUL
tf workfold /cloak "$\Contract Management\Dev\src\Tools\RitaDevelopmentToolkit\packages" 2>NUL
ATTRIB -R /S /D "%TFS_BASE%\Contract Management\Dev\src\Tools\RitaDevelopmentToolkit\packages" 2>NUL

tf undo /recursive "%TFS_BASE%\Contract Management\DS2\src\Tools\RitaDevelopmentToolkit\packages" 2>NUL
tf workfold /cloak "$\Contract Management\DS2\src\Tools\RitaDevelopmentToolkit\packages" 2>NUL
ATTRIB -R /S /D "%TFS_BASE%\Contract Management\DS2\src\Tools\RitaDevelopmentToolkit\packages" 2>NUL


tf undo /recursive "%TFS_BASE%\BizTalk\Dev\LocalBin" 2>NUL
tf workfold /cloak "$\BizTalk\Dev\LocalBin" 2>NUL
ATTRIB -R /S /D "%TFS_BASE%\BizTalk\Dev\LocalBin" 2>NUL

tf undo /recursive "%TFS_BASE%\BizTalk\Projects\CMS\LocalBin" 2>NUL
tf workfold /cloak "$\BizTalk\Projects\CMS\LocalBin" 2>NUL
ATTRIB -R /S /D "%TFS_BASE%\BizTalk\Projects\CMS\LocalBin" 2>NUL


tf undo /recursive "%TFS_BASE%\Contract Management\Projects\CMS\out" 2>NUL
tf workfold /cloak "$\BizTalk\Contract Management\Projects\CMS\out" 2>NUL
ATTRIB -R /S /D "%TFS_BASE%\Contract Management\Projects\CMS\out" 2>NUL

tf undo /recursive "%TFS_BASE%\Contract Management\Projects\CMS\LocalBin" 2>NUL
tf workfold /cloak "$\BizTalk\Contract Management\Projects\CMS\LocalBin" 2>NUL
ATTRIB -R /S /D "%TFS_BASE%\Contract Management\Projects\CMS\LocalBin" 2>NUL


FOR %%T IN (
	BizTalkCMSServices
	BMWFS.BizTalk.CMS.Booking
	BMWFS.BizTalk.CMS.EOT
	BMWFS.BizTalk.CMS.Payments
	BMWFS.BizTalk.CMS.Servicing
	BMWFSCMSSendAdaptorProxies
	CMSBamAndEmf
) DO (
	SET TFSSolution=%%~T
	ECHO Solution: $\!TFSSolution!
	MKDIR "%TFS_BASE%\BizTalk\Dev\src\BiztalkApps\CMS\src\!TFSSolution!\packages" 2>NUL
	tf undo /recursive "%TFS_BASE%\BizTalk\Dev\src\BiztalkApps\CMS\src\!TFSSolution!\packages" 2>NUL
	tf workfold /cloak "$\BizTalk\Dev\src\BiztalkApps\CMS\src\!TFSSolution!\packages" 2>NUL
	ATTRIB -R /S /D "%TFS_BASE%\BizTalk\Dev\src\BiztalkApps\CMS\src\!TFSSolution!\packages" 2>NUL

REM 	MKDIR "%TFS_BASE%\BizTalk\DS2\src\BiztalkApps\CMS\src\!TFSSolution!\packages" 2>NUL
REM	tf undo /recursive "%TFS_BASE%\BizTalk\DS2\src\BiztalkApps\CMS\src\!TFSSolution!\packages" 2>NUL
REM	tf workfold /cloak "$\BizTalk\DS2\src\BiztalkApps\CMS\src\!TFSSolution!\packages" 2>NUL
REM	ATTRIB -R /S /D "%TFS_BASE%\BizTalk\DS2\src\BiztalkApps\CMS\src\!TFSSolution!\packages" 2>NUL

	MKDIR "%TFS_BASE%\BizTalk\Projects\CMS\src\BiztalkApps\CMS\src\!TFSSolution!\packages" 2>NUL
	tf undo /recursive "%TFS_BASE%\BizTalk\Projects\CMS\src\BiztalkApps\CMS\src\!TFSSolution!\packages" 2>NUL
	tf workfold /cloak "$\BizTalk\Projects\CMS\src\BiztalkApps\CMS\src\!TFSSolution!\packages" 2>NUL
	ATTRIB -R /S /D "%TFS_BASE%\BizTalk\Projects\CMS\src\BiztalkApps\CMS\src\!TFSSolution!\packages" 2>NUL
)


FOR %%T IN (
	CMS.Batch
	CMS.Contracts
	CMS.GatewayServices
	CMS.Services
	CMS.Web
) DO (
	SET TFSSolution=%%~T
	ECHO Solution: $\!TFSSolution!
	tf undo /recursive "%TFS_BASE%\Contract Management\Dev\build\!TFSSolution!\packages"
	tf workfold /cloak "$\Contract Management\Dev\build\!TFSSolution!\packages"
	ATTRIB -R /S /D "%TFS_BASE%\Contract Management\Dev\build\!TFSSolution!\packages"

	tf undo /recursive "%TFS_BASE%\Contract Management\DS2\build\!TFSSolution!\packages"
	tf workfold /cloak "$\Contract Management\DS2\build\!TFSSolution!\packages"
	ATTRIB -R /S /D "%TFS_BASE%\Contract Management\DS2\build\!TFSSolution!\packages"


	tf undo /recursive "%TFS_BASE%\Contract Management\Projects\CMS\build\!TFSSolution!\packages"
	tf workfold /cloak "$\Contract Management\Projects\CMS\build\!TFSSolution!\packages"
	ATTRIB -R /S /D "%TFS_BASE%\Contract Management\Projects\CMS\build\!TFSSolution!\packages"
)


ECHO ***** Cloak Paths Complete *****
GOTO Done

:Error
ECHO ***** Cloak Paths Failed *****
EXIT /B 1

:Done
ENDLOCAL
CD /D "%STARTPATH_CLOAK%"