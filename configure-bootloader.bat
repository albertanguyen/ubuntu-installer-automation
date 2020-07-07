@ECHO OFF
:: This script needs to be excuted with administration privilige
:: UEFI BIOS mode: set rEFInd as default boot loader
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
:: Legacy BIOS mode: set ??? as default boot loader
:: x64-based PC
:: TODO: get value of System Type and compare with "x64-based PC"
RMDIR /S /Q drivers_aa64 && del  refind_aa64.efi && RMDIR /S /Q tools_aa64
RMDIR /S /Q drivers_ia32 && del refind_ia32.efi && RMDIR /S /Q tools_ia32

:: x86-based PC
rename refind.conf-sample refind.conf
bcdedit /set "{bootmgr}" path \EFI\refind\refind_x64.efi
bcdedit /set "{bootmgr}" description "rEFInd as the default EFI boot program"
bcdedit /enum
