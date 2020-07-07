@ECHO OFF
:: This script needs to be excuted with administration privilige
ECHO ============================
ECHO Extract Ubuntu iso to FAT32 disk partition AND Reboot
ECHO ============================
Powershell.exe -executionpolicy remotesigned -file mountdisk.ps1 "%HOMEPATH%\Downloads\ubuntu-20.04-desktop-amd64.iso"
xcopy /S D:\* H:\
Powershell.exe -executionpolicy remotesigned -file dismountdisk.ps1 "%HOMEPATH%\Downloads\ubuntu-20.04-desktop-amd64.iso"
