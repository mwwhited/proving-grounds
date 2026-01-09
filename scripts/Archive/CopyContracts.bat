@ECHO OFF

SET PATH=%PATH%;C:\Windows\Microsoft.NET\Framework\v4.0.30319;
IF "%TFSBASE%"=="" SET TFSBASE=C:\TFS
SET CmsContractsDLL=%TFSBASE%\Contract Management\Dev\LocalBin\CMSContracts\CMSContracts.dll

ECHO Copy to Dev\src\packages
IF not EXIST "%TFSBASE%\Contract Management\Dev\src\packages\CMSContracts.1.0.0\lib\net35\" (
	MKDIR "%TFSBASE%\Contract Management\Dev\src\packages\CMSContracts.1.0.0\lib\net35\" >> NUL
)
COPY "%CmsContractsDLL%" "%TFSBASE%\Contract Management\Dev\src\packages\CMSContracts.1.0.0\lib\net35\"

ECHO Copy to Dev\build\CMS.Services\packages
IF not EXIST "%TFSBASE%\Contract Management\Dev\build\CMS.Services\packages\CMSContracts.1.0.0\lib\net35" (
	mkdir "%TFSBASE%\Contract Management\Dev\build\CMS.Services\packages\CMSContracts.1.0.0\lib\net35" >> NUL
)
COPY "%CmsContractsDLL%" "%TFSBASE%\Contract Management\Dev\build\CMS.Services\packages\CMSContracts.1.0.0\lib\net35\CMSContracts.dll" /Y

ECHO Copy to Dev\build\CMS.Batch\packages
IF NOT EXIST "%TFSBASE%\Contract Management\Dev\build\CMS.Batch\packages\CMSContracts.1.0.0\lib\net35" (
	MKDIR "%TFSBASE%\Contract Management\Dev\build\CMS.Batch\packages\CMSContracts.1.0.0\lib\net35" >> NUL
)
COPY "%CmsContractsDLL%" "%TFSBASE%\Contract Management\Dev\build\CMS.Batch\packages\CMSContracts.1.0.0\lib\net35\CMSContracts.dll" /Y

ECHO Copy to Dev\build\CMS.Web\packages
IF NOT EXIST "%TFSBASE%\Contract Management\Dev\build\CMS.Web\packages\CMSContracts.1.0.0\lib\net35" (
	MKDIR "%TFSBASE%\Contract Management\Dev\build\CMS.Web\packages\CMSContracts.1.0.0\lib\net35" >> NUL
)
COPY "%CmsContractsDLL%" "%TFSBASE%\Contract Management\Dev\build\CMS.Web\packages\CMSContracts.1.0.0\lib\net35\CMSContracts.dll" /Y