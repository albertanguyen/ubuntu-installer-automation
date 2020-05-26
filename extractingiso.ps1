# This script needs to be excuted with administration privilige
param(
        [string]$sourcefolder = "",
        [string]$outputfolder = "",
        [string]$overwrite = $true)

$SecureBootStatus=Confirm-SecureBootUEFI

IF ($SecureBootStatus) {
    return "Please disable Secure Boot from BIOS Interface"
} else {
    Write-Host "Secure Boot is disabled"
}

$original_folder = $PWD
cd $sourcefolder

$list = ls *.iso | Get-ChildItem -rec | ForEach-Object -Process {$_.FullName}

# Write-Host $list
foreach($iso in $list){

$folder = [System.IO.Path]::GetFileNameWithoutExtension($iso)

if(Test-Path $folder) {
    rm $folder -Recurse
}

$mount_params = @{ImagePath = $iso; PassThru = $true;}
$mount = Mount-DiskImage @mount_params
# Write-Host $mount
if($mount) {

    $volume = Get-DiskImage -ImagePath $mount.ImagePath | Get-Volume
    $source = $volume.DriveLetter + ":\*"
    # $folder = mkdir $folder
    
    Write-Host "Extracting '$iso' to '$folder'..."
    $params = @{Path = $source; Destination = $folder; Recurse = $true;}
    cp @params
    $hide = Dismount-DiskImage @mount_params
    Write-Host "Copy complete"
}
else {
    Write-Host "ERROR: Could not mount " $iso " check if file is already in use"
}
}


# if((Test-Path $folder) -and $overwrite -eq $false)
# {
#       Write-Host "WARNING: Skipping '$folder', reason: target path already exists"
# }
# else
# {
#      if(Test-Path $folder)
#      {
#           rm $folder -Recurse
#      }

    #  $mount_params = @{ImagePath = $iso; PassThru = $true; ErrorAction = "Ignore"}
    #  $mount = Mount-DiskImage @mount_params

    #  if($mount) {

    #      $volume = Get-DiskImage -ImagePath $mount.ImagePath | Get-Volume
    #      $source = $volume.DriveLetter + ":\*"
    #      $folder = mkdir $folder
         
    #      Write-Host "Extracting '$iso' to '$folder'..."
    #      $params = @{Path = $source; Destination = $folder; Recurse = $true;}
    #      cp @params
    #      $hide = Dismount-DiskImage @mount_params
    #      Write-Host "Copy complete"
    # }
    # else {
    #      Write-Host "ERROR: Could not mount " $iso " check if file is already in use"
    # }
    # }
# }

cd $original_folder
