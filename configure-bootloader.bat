@ECHO OFF
:: This script needs to be excuted with administration privilige
ECHO ============================
ECHO SET rEFInd AS DEFAULT BOOT LOADER
ECHO ============================
powercfg /h off
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateEnabled"
wmic logicaldisk get name
mountvol S: /S
mountvol -help
cd C:\Users\HP\Downloads\refind-bin-0.12.0 && dir
xcopy /E refind S:\EFI\refind\
cd /d S:\EFI\refind
ECHO REMOVE UNNECESSARY DRIVERS
RMDIR /S /Q drivers_aa64 && del  refind_aa64.efi && RMDIR /S /Q tools_aa64
RMDIR /S /Q drivers_ia32 && del refind_ia32.efi && RMDIR /S /Q tools_ia32
rename refind.conf-sample refind.conf
bcdedit /set "{bootmgr}" path \EFI\refind\refind_x64.efi
bcdedit /set "{bootmgr}" description "rEFInd as the default EFI boot program"
bcdedit /enum
