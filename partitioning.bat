@ECHO OFF
ECHO bat file worked!
:: This script needs to be excuted with administration privilige
ECHO ============================
ECHO PARTITIONING
ECHO SHRINK DISK
ECHO ============================
ECHO LIST DISK > ubuntu.scr
ECHO SELECT DISK 0 >> ubuntu.scr
ECHO LIST VOLUME >> ubuntu.scr
ECHO SELECT VOLUME 0 >> ubuntu.scr
ECHO SHRINK QUERYMAX >> ubuntu.scr
ECHO SHRINK DESIRED=364100 >> ubuntu.scr 
@ECHO ON
DISKPART /S ubuntu.scr
DEL ubuntu.scr

::@ECHO OFF
::ECHO ============================
::ECHO CREATE UBUNTU PARTITION
::ECHO ============================
::ECHO LIST DISK > ubuntu-partition.scr
::ECHO SELECT DISK 0 >> ubuntu-partition.scr
::ECHO CREATE partition primary size=360000 >> ubuntu-partition.scr
::ECHO assign letter=F >> ubuntu-partition.scr
::ECHO format fs=NTFS label=Ubuntu >> ubuntu-partition.scr
::@ECHO ON
::diskpart /s ubuntu-partition.scr
::DEL ubuntu-partition.scr

@ECHO OFF
ECHO ============================
ECHO CREATE 4GB PARTITION
ECHO Convert unallocated 4GB to FAT32 file system
ECHO ============================
ECHO LIST DISK > 4gb-partition.scr
ECHO SELECT DISK 0 >> 4gb-partition.scr
ECHO CREATE partition primary size=4100 >> 4gb-partition.scr
ECHO assign letter=H >> 4gb-partition.scr
ECHO format fs=FAT32 label=USB >> 4gb-partition.scr
@ECHO ON
diskpart /s 4gb-partition.scr
DEL 4gb-partition.scr
