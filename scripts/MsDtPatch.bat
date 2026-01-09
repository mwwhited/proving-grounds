
IF NOT "%1"=="" Class%1

ECHO Query existing
reg query HKEY_CLASSES_ROOT\ms-msdt
IF NOT ERRORLEVEL 0 GOTO OnError

ECHO Backup existing 
REM reg export HKEY_CLASSES_ROOT\ms-msdt "%USERPROFILE%\Documents\ms-msdt.reg"
IF NOT ERRORLEVEL 0 GOTO OnError

ECHO Remove existing
REM reg delete HKEY_CLASSES_ROOT\ms-msdt /f
IF NOT ERRORLEVEL 0 GOTO OnError

GOTO OnDone

:Restore

ECHO Restore
reg import "%USERPROFILE%\Documents\ms-msdt.reg"
EXIT /B %ERRORLEVEL%
