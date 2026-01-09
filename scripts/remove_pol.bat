@echo off
echo Windows Registry Editor Version 5.00 > POLICY_REMOVE.REG
echo. >> POLICY_REMOVE.REG
echo [-HKEY_CURRENT_USER\Software\Policies] >> POLICY_REMOVE.REG
echo. >> POLICY_REMOVE.REG
echo [-HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies] >> POLICY_REMOVE.REG
echo. >> POLICY_REMOVE.REG
echo [-HKEY_LOCAL_MACHINE\Software\Policies] >> POLICY_REMOVE.REG
echo. >> POLICY_REMOVE.REG
echo [-HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies] >> POLICY_REMOVE.REG

regedit /s POLICY_REMOVE.REG