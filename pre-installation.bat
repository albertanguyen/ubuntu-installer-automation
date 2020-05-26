@ECHO OFF
:: This script needs to be excuted with administration privilige
ECHO ============================
ECHO OS INFO
ECHO ============================
systeminfo | findstr /c:"OS Name"
systeminfo | findstr /c:"OS Version"
systeminfo | findstr /c:"System Type"
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
:: This step is used to check if the disk contains single partition or multiple partitions
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
