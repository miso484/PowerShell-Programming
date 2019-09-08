#
# Listing Windows Installer Applications
#

# List 
Get-CimInstance -Class Win32_Product |
  Where-Object Name -eq "Microsoft .NET Core Runtime - 2.1.2 (x64)"

# List and display all properties
Get-CimInstance -Class Win32_Product |
  Where-Object Name -eq "Microsoft .NET Core Runtime - 2.1.2 (x64)" |
    Format-List -Property *

# This does the same thing
Get-CimInstance -Class Win32_Product -Filter "Name='Microsoft .NET Core Runtime - 2.1.2 (x64)'" |
  Format-List -Property *

# Choose specific property
Get-CimInstance -Class Win32_Product  -Filter "Name='Microsoft .NET Core Runtime - 2.1.2 (x64)'" |
  Format-List -Property Name,InstallDate,InstallLocation,PackageCache,Vendor,Version,IdentifyingNumber

#
# Listing All Uninstallable Applications
#

# This can be taken from HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall registry

# Create a PowerShell drive and use it to get information
New-PSDrive -Name Uninstall -PSProvider Registry -Root HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall
(Get-ChildItem -Path Uninstall:).Count
$UninstallableApplications = Get-ChildItem -Path Uninstall:
$UninstallableApplications | ForEach-Object -Process { $_.GetValue('DisplayName') }
$UninstallableApplications | Where-Object -FilterScript { $_.GetValue("DisplayName") -eq "Windows Media Encoder 9 Series"}

#
# Installing Applications
#

# Use Win32_Product class to install Windows Installer packages, remotely or locally

# Example: install the NewPackage.msi package located in the network share \\AppServ\dsp on the remote computer PC01
Invoke-CimMethod -ClassName Win32_Product -MethodName Install -Arguments @{PackageLocation='\\AppSrv\dsp\NewPackage.msi'}

#
# Removing Applications
#

# Uninstall package based on its name
Get-CimInstance -Class Win32_Product -Filter "Name='ILMerge'" | Invoke-CimMethod -MethodName Uninstall

# Find the command line uninstallation strings 
Get-ChildItem -Path Uninstall: | ForEach-Object -Process { $_.GetValue('UninstallString') }

# Filter the output by the display name
Get-ChildItem -Path Uninstall: |
    Where-Object -FilterScript { $_.GetValue('DisplayName') -like 'Win*'} |
        ForEach-Object -Process { $_.GetValue('UninstallString') }

#
# Upgrading Windows Installer Applications
#

# It is required to know name and path of the app in order to uprade it
Get-CimInstance -Class Win32_Product -Filter "Name='OldAppName'" |
  Invoke-CimMethod -MethodName Upgrade -Arguments @{PackageLocation='\\AppSrv\dsp\OldAppUpgrade.msi'}