@ECHO OFF
ECHO bat file worked!
:: This script needs to be excuted with administration privilige
:: PART 1: Pre-installation
pre-installation.bat
:: PART 2: Installation
:: SECTION 1: set rEFInd as default boot loader
configure-bootloader.bat

:: SECTION 2: Partitioning
partitioning.bat

:: SECTION 3: Installation
extract-iso.bat

:: INSTALLATION (need to be done manually): Reboot the computer

:: PART 3: Cleanup
:: Section 1: Reverse the partition state
partition-cleanup.bat

:: Section 2: Cleanup of EFI Boot Loader
bootloader-cleanup.bat
