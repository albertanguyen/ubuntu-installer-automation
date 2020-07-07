@ECHO OFF
ECHO bat file worked!
:: This script needs to be excuted with administration privilige

:: PART 1: Pre-installation
pre-installation.bat

:: PART 2: Installation
:configureBootLoader
configure-bootloader.bat

:partitioning
partitioning.bat

:installation
extract-iso.bat

:: INSTALLATION (need to be done manually): Reboot the computer

:: PART 3: Cleanup
:: Uncomment the following scripts after successfull installation
:reversePartitionState
REM partition-cleanup.bat

:cleanupEFIBootLoader
REM bootloader-cleanup.bat
