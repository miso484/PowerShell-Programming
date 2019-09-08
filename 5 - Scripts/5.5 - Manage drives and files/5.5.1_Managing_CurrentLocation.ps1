#
# Getting Your Current Location (Get-Location) (simmilar to pwd)
#

Get-Location

#
# Setting Your Current Location (Set-Location)
#

# Set location without verification
Set-Location -Path C:\Windows

# Set location with verification
Set-Location -Path C:\Windows -PassThru

# Navigate to parent directory
Set-Location -Path .. -PassThru

# Set location in PowerShell drive
Set-Location -Path HKLM:\SOFTWARE -PassThru

# Use aliases
cd -Path C:\Windows
chdir -Path .. -PassThru
sl -Path HKLM:\SOFTWARE -PassThru

#
# Saving and Recalling Recent Locations (Push-Location and Pop-Location)
#

# Push the current location onto the stack, and then move to the Local Settings folder
Push-Location -Path "Local Settings"

# Push the Local Settings location onto the stack and move to the Temp folder and verify that you changed directory
Push-Location -Path Temp
Get-Location

# Pop back into the most recently visited director, and verify
Pop-Location -PassThru

# Use the Location cmdlets with network paths
Set-Location \\FS01\Public
# or
Push-Location \\FS01\Public
