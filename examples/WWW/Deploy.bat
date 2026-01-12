SET source=G:\Users\Matthew Whited\CodeSets\whited_us\WWW\WhitedUS_deploy\Release
SET dest=\\trojan\SQLExpress\WWW\AlphaSite

xcopy "%source%" "%dest%" /d /s /c /y

pause