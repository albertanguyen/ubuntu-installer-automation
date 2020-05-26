# This script needs to be excuted with administration privilige
param(
        [string]$iso = ""
        )

$mount_params = @{ImagePath = $iso; PassThru = $true;}

IF (!$ISODrive) {
    Mount-DiskImage -ImagePath $mount_params.ImagePath -StorageType ISO
    $ISODrive = (Get-DiskImage -ImagePath $mount_params.ImagePath | Get-Volume).DriveLetter
    Write-Host ("ISO Drive is " + $ISODrive)
    $source = $ISODrive + ":\*"
    Write-Host ("source to copy from is" + $source)
}
