@ECHO OFF
:: This script needs to be excuted with administration privilige
:: Main Script
ECHO ============================
ECHO CONFIGURE BOOT MANAGER
ECHO ============================
FOR /F "tokens=4,5 delims=: " %%a IN ("%_os_name%") DO ( SET osname=%%a %%b )
FOR /F "tokens=3 delims=: " %%a IN ("%_os_ver%") DO ( SET osverfull=%%a )
FOR /F "tokens=1,2 delims=." %%a IN ("%osverfull%") DO ( SET osver=%%a.%%b)
SET year=%_bios_ver:~-4%
SET systype=%_system_type:~-12%
IF %year% LSS 2007 GOTO legacy IF NOT GOTO exitMsg
IF %year% GTR 2007 (
    IF %osver% GEQ 6.0 IF %osver% LEQ 6.1 (
        GOTO :legacy
    ) ELSE (   
        GOTO :uefi
    )
)

:uefi
ECHO ============================
ECHO CONFIGURE BOOT MGR for UEFI BIOS mode
ECHO SET rEFInd AS DEFAULT BOOT LOADER
ECHO ============================
CALL :turnoffHibernate
CALL :mountESP
CALL :configureESP
CALL :configureBootMgr
GOTO :eof

:legacy
ECHO ============================
ECHO CONFIGURE BOOT MGR for Legacy BIOS mode
ECHO SET SOMETHING ELSE AS DEFAULT BOOT LOADER
ECHO ============================
CALL :turnoffHibernate
GOTO :eof

GOTO End

:: Subroutines
:turnoffHibernate
powercfg /h off
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateEnabled"
wmic logicaldisk get name
GOTO :eof

:mountESP
ECHO Mount ESP
mountvol S: /S
mountvol -help
GOTO :eof

:configureESP
cd %HOMEPATH%\Downloads\refind-bin-0.12.0 && dir
xcopy /E refind S:\EFI\refind\
cd /d S:\EFI\refind
ECHO REMOVE UNNECESSARY DRIVERS
IF /I "%systype%"=="x86-based PC" (
    RMDIR /S /Q drivers_aa64 && del  refind_aa64.efi && RMDIR /S /Q tools_aa64
    RMDIR /S /Q drivers_x64 && del refind_x64.efi && RMDIR /S /Q tools_x64

) ELSE (
    EXIT /b 1
)
IF /I "%systype%"=="x64-based PC" (
    RMDIR /S /Q drivers_aa64 && del  refind_aa64.efi && RMDIR /S /Q tools_aa64
    RMDIR /S /Q drivers_ia32 && del refind_ia32.efi && RMDIR /S /Q tools_ia32
    rename refind.conf-sample refind.conf
    bcdedit /set "{bootmgr}" path \EFI\refind\refind_x64.efi
    bcdedit /set "{bootmgr}" description "rEFInd as the default EFI boot program"
    bcdedit /enum
) ELSE (
    EXIT /b 1
)
GOTO :eof

:End
