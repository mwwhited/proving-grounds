@ECHO OFF
SETLOCAL

set path=%path%;C:\CCMSprint\Contract Management\src\Tools\Scripts\bin

SET OCTO_API_KEY=API-EUMDQ27LSULIQPZMBWEQE8HK9E
SET OCTO_API_URI=http://octopusdeploy.bmwgroup.net/

SET OCTO_CHANNEL=CCMSprint

octo create-release -apikey=%OCTO_API_KEY% -server=%OCTO_API_URI% -channel="%OCTO_CHANNEL%" -project=CMS-Middleware
octo create-release -apikey=%OCTO_API_KEY% -server=%OCTO_API_URI% -channel="%OCTO_CHANNEL%" -project=Middleware
octo create-release -apikey=%OCTO_API_KEY% -server=%OCTO_API_URI% -channel="%OCTO_CHANNEL%" -project="Contract Management Web"
octo create-release -apikey=%OCTO_API_KEY% -server=%OCTO_API_URI% -channel="%OCTO_CHANNEL%" -project="CMS-BizTalk"
octo create-release -apikey=%OCTO_API_KEY% -server=%OCTO_API_URI% -channel="%OCTO_CHANNEL%" -project="BizTalk"

ENDLOCAL