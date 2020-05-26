# This script needs to be excuted with administration privilige
param(
        [string]$iso = ""
        )

$mount_params = @{ImagePath = $iso; PassThru = $true;}
Dismount-DiskImage -ImagePath $mount_params.ImagePath
