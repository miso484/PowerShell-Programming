#
# Get the latest version of PowerShell gallery
#

# Install the latest Nuget provider
Install-PackageProvider Nuget -Force
Exit

# Install the latest PowerShellGet on PowerShell 5.0 (or newer) 
Install-Module -Name PowerShellGet -Force
Exit
Update-Module -Name PowerShellGet
Exit