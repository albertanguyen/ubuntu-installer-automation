@ECHO OFF
:: This script needs to be excuted with administration privilige
:: UEFI BIOS mode: set rEFInd as default boot loader
ECHO ============================
ECHO CONFIGURE BOOT MANAGER
ECHO ============================
GOTO decisionMaker

:decisionMaker
FOR /F "tokens=4,5 delims=: " %%a IN ("%_os_name%") DO ( SET osname=%%a %%b )
SET year=%_bios_ver:~-4%
SET systype=%_system_type:~-12%
IF "%year%" LESS "2007" GOTO legacy IF NOT GOTO exitMsg
IF "%year%" GRT "2007" GOTO uefi IF NOT GOTO exitMsg

:uefi
ECHO ============================
ECHO SET rEFInd AS DEFAULT BOOT LOADER
ECHO ============================
GOTO turnoffHibernate
GOTO mountESP
GOTO configureESP
GOTO configureBootMgr

:legacy
ECHO ============================
ECHO SET SOMETHING ELSE AS DEFAULT BOOT LOADER
ECHO ============================


:turnoffHibernate
powercfg /h off
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateEnabled"
wmic logicaldisk get name

:mountESP
ECHO ============================
ECHO Mount ESP
ECHO ============================
mountvol S: /S
mountvol -help


:configureESP
cd C:\Users\HP\Downloads\refind-bin-0.12.0 && dir
xcopy /E refind S:\EFI\refind\
cd /d S:\EFI\refind
ECHO REMOVE UNNECESSARY DRIVERS
IF /I "%systype%"=="x86-based PC" GOTO x86Arch IF NOT GOTO exitMsg
IF /I "%systype%"=="x64-based PC" GOTO x64Arch IF NOT GOTO exitMsg

:x64Arch
RMDIR /S /Q drivers_aa64 && del  refind_aa64.efi && RMDIR /S /Q tools_aa64
RMDIR /S /Q drivers_ia32 && del refind_ia32.efi && RMDIR /S /Q tools_ia32

:x86Arch
RMDIR /S /Q drivers_aa64 && del  refind_aa64.efi && RMDIR /S /Q tools_aa64
RMDIR /S /Q drivers_x64 && del refind_x64.efi && RMDIR /S /Q tools_x64

:configureBootMgr
rename refind.conf-sample refind.conf
bcdedit /set "{bootmgr}" path \EFI\refind\refind_x64.efi
bcdedit /set "{bootmgr}" description "rEFInd as the default EFI boot program"
bcdedit /enum

:exitMsg
ECHO cannot make a decision on Current System
EXIT /b 1
