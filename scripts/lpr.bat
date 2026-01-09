@echo off
exit

echo LPR Printer Script for HPLJ2200d

set station=%COMPUTERNAME%
set room=%station:~0,-2%01
set numb=%station:~-2,2%

rem echo %station%
rem echo %room%
rem echo %numb%

if "%1" == "01" goto renamelocal

if "%1" == "help" goto displayhelp
if "%1" == "-help" goto displayhelp
if "%1" == "/help" goto displayhelp
if "%1" == "h" goto displayhelp
if "%1" == "-h" goto displayhelp
if "%1" == "/h" goto displayhelp
if "%1" == "?" goto displayhelp
if "%1" == "-?" goto displayhelp
if "%1" == "/?" goto displayhelp

if "%1" == "" goto nextpart

set room=%1
goto nextpart2

:displayhelp
echo.
echo.
echo lpr {-h | 01 | [computer-name]}
echo.
echo no parameters will work for default configuration
echo.
echo 01 will force the computer you are on to be the lpr server
echo.
echo [computer-name] will point the client to the server referenced as computer-name
echo.

:nextpart

if "%numb%" == "01" goto renamelocal

:nextpart2

if "%room%" == "" goto WRONG

echo Create %room%.reg

echo REGEDIT4 >z:\temp\%room%.reg
echo. >>z:\temp\%room%.reg
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print\Monitors\LPR Port\Ports\%room%:hplj2200d] >>z:\temp\%room%.reg
echo "Server Name"="%room%" >>z:\temp\%room%.reg
echo "Printer Name"="hplj2200d" >>z:\temp\%room%.reg
echo "OldSunCompatibility"=dword:00000000 >>z:\temp\%room%.reg
echo "HpUxCompatibility"=dword:00000000 >>z:\temp\%room%.reg
echo "EnableBannerPage"=dword:00000000 >>z:\temp\%room%.reg
echo. >>z:\temp\%room%.reg
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print\Monitors\LPR Port\Ports\%room%:hplj2200d\Timeouts] >>z:\temp\%room%.reg
echo "CommandTimeout"=dword:00000078 >>z:\temp\%room%.reg
echo "DataTimeout"=dword:0000012c >>z:\temp\%room%.reg

echo Merge %room%.reg
regedit /s z:\temp\%room%.reg

echo Stop TCP/IP Printer Server
net stop lpdsvc

echo Stop Spooler
net stop spooler

echo Start Spooler
net start spooler

echo Install %room%:hplj2200d
RUNDLL32 PRINTUI.DLL,PrintUIEntry  /dl /n "hplj2200d" /q
rundll32 printui.dll,PrintUIEntry /if /b "hplj2200d" /f "Z:\updates\Drivers\Printers\hplj2200d\Win2000_XP\PCL6\hpbf322i.inf" /r "%room%:hplj2200d" /m "HP LaserJet 2200 Series PCL 6" /z /q /u

echo Set Default Printer	
RUNDLL32 PRINTUI.DLL,PrintUIEntry /n "hplj2200d" /y

goto donewithit

:renamelocal

echo Create Registry to Set LPD to Automatic

echo REGEDIT4 >z:\temp\lpd.reg
echo. >>z:\temp\lpd.reg
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LPDSVC] >>z:\temp\lpd.reg
echo "Start"=dword:00000002 >>z:\temp\lpd.reg

echo Merge lpd.reg
regedit /s z:\temp\lpd.reg

echo Stop TCP/IP Printer Server
net stop lpdsvc

echo Start TCP/IP Printer Server
net start lpdsvc

echo Rename Printer HP LaserJet 2200

RUNDLL32 PRINTUI.DLL,PrintUIEntry  /dl /n "HP LaserJet 2200 Series PCL" /q
RUNDLL32 PRINTUI.DLL,PrintUIEntry  /dl /n "hplj2200d" /q
rundll32 printui.dll,PrintUIEntry /if /b "hplj2200d" /f "Z:\updates\Drivers\Printers\hplj2200d\Win2000_XP\PCL6\hpbf322i.inf" /r "lpt1:" /m "HP LaserJet 2200 Series PCL 6" /z /q /u

echo Set Default Printer
RUNDLL32 PRINTUI.DLL,PrintUIEntry /n "hplj2200d" /y

goto donewithit

:Wrong
echo I don't know what happened

:donewithit

REM echo Remove PDF Creator
REM RUNDLL32 PRINTUI.DLL,PrintUIEntry  /dl /n "PDFCreator" /q


echo .
echo Press Any key for a test page or...
echo Press CTRL-C and say yes to terminate to cancel
pause

RUNDLL32 PRINTUI.DLL,PrintUIEntry /n "hplj2200d" /k

echo "DONE"

:reallydone