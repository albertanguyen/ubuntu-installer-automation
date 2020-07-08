@ECHO OFF
ECHO bat file worked!
:: This script needs to be excuted with administration privilige

IF /I "%systype%"=="x86-based PC" (
    ECHO configure boot manager for x86 Arch
) ELSE (
    GOTO :commonExit
)
IF /I "%systype%"=="x64-based PC" (
    ECHO ============================
    ECHO CLEANUP OF EFI BOOT LOADER
    ECHO Restoring UEFI boot entry in BCD store
    ECHO ============================
    bcdedit /set "{bootmgr}" path \EFI\Boot\bootx64.efi
    bcdedit /set "{bootmgr}" description "default UEFI boot"
) ELSE (
    GOTO :commonExit
)
ECHO ============================
ECHO Unmount ESP
ECHO ============================
mountvol S: /S
RMDIR /S /Q S:\EFI\refind\
mountvol S:\ /D
mountvol -help
ECHO ============================
ECHO Enable the hibernate feature
ECHO ============================
powercfg /h on
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateEnabled"

:commonExit
EXIT /b 1
