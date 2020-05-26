@ECHO OFF
ECHO bat file worked!
:: This script needs to be excuted with administration privilige
ECHO ============================
ECHO CLEANUP OF PARTITIONING: Reverse the partition state
ECHO ============================
ECHO LIST DISK > reverse.scr
ECHO LIST VOLUME >> reverse.scr
ECHO SELECT VOLUME 1 >> reverse.scr
ECHO DELETE VOLUME >> reverse.scr
ECHO SELECT VOLUME 0 >> reverse.scr
ECHO EXTEND >> reverse.scr
@ECHO ON
DISKPART /S reverse.scr
DEL reverse.scr
