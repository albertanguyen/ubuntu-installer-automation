@ECHO OFF
:: This script needs to be excuted with administration privilige
REM GOTO :hardwareInfo
:osInfo
ECHO ============================
ECHO OS INFO
ECHO ============================
FOR /F "tokens=*" %%i IN ('systeminfo ^| findstr /c:"OS Name"') do (
    SET _os_name=%%i
    ECHO %_os_name%
)

FOR /F "tokens=*" %%i IN ('systeminfo ^| findstr /B /c:"OS Version"') do (
    SET _os_ver=%%i
    ECHO %_os_ver%
)

FOR /F "tokens=*" %%i IN ('systeminfo ^| findstr /c:"BIOS Version"') do (
    SET _bios_ver=%%i
    ECHO %_bios_ver%
)

FOR /F "tokens=*" %%i IN ('systeminfo ^| findstr /c:"System Type"') do (
    SET _system_type=%%i
    ECHO %_system_type%
)
GOTO :eof

:hardwareInfo
ECHO ============================
ECHO HARDWARE INFO
ECHO ============================
wmic cpu get name
:: systeminfo | findstr /c:"Processor(s)"
systeminfo | findstr /c:"BIOS Version"
systeminfo | findstr /c:"Virtual Memory: Max Size"
systeminfo | findstr /c:"Boot Device"
systeminfo | findstr /c:"Total Physical Memory"
systeminfo | findstr /c:"Virtual Memory: Max Size"
bcdedit /enum

:diskInfo
ECHO ============================
ECHO DISK PARTITION INFO
ECHO ============================
chkdsk /V
@ECHO OFF
ECHO LIST DISK > partition-info.scr
ECHO SELECT DISK 0 >> partition-info.scr
ECHO LIST PARTITION >> partition-info.scr
ECHO LIST VOLUME >> partition-info.scr
@ECHO ON
diskpart /s partition-info.scr
del partition-info.scr

