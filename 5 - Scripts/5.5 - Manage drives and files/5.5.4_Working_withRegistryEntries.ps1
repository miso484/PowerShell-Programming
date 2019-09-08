# Registry entries are properties of keys and, as such, cannot be directly browsed

#
# Listing Registry Entries
#

# Select the Property property and expand the items so that they are displayed in a list
Get-Item -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion |
  Select-Object -ExpandProperty Property

# View the registry entries in a more readable form
Get-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion

# Change to the CurrentVersion registry
Set-Location -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion
#Set-Location -Path hklm:\SOFTWARE\Microsoft\Windows\CurrentVersion
# List the properties without specifying a full path
Get-ItemProperty -Path .

#
# Getting a Single Registry Entry
#

# Use the Path parameter to specify the name of the key, and the Name parameter to specify the name of the DevicePath entry
Get-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion -Name DevicePath
# or use reg to find some registry
reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion /v DevicePath
# or use the WshShell COM object
(New-Object -ComObject WScript.Shell).RegRead("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DevicePath")

#
# Setting a Single Registry Entry
#

# Modifie the Path entry
$value = Get-ItemProperty -Path HKCU:\Environment -Name Path
$newpath = $value.Path += ";C:\src\bin\"
Set-ItemProperty -Path HKCU:\Environment -Name Path -Value $newpath

# Another option is to use the Reg.exe command line tool, this example changes the Path entry by removing the path added in the example above
$value = Get-ItemProperty -Path HKCU:\Environment -Name Path
$newpath = $value.Path.SubString(0, $value.Path.LastIndexOf(';'))
reg add HKCU\Environment /v Path /d $newpath /f

#
# Creating New Registry Entries
#

# Add the new entry to the key and return information about entry
New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion -Name PowerShellPath -PropertyType String -Value $PSHome

#
# Renaming Registry Entries
#

# Rename the PowerShellPath entry to "PSHome"
Rename-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion -Name PowerShellPath -NewName PSHome

# Display the renamed value
Rename-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion -Name PowerShellPath -NewName PSHome -passthru

#
# Deleting Registry Entries
#

# Delete both the PSHome and PowerShellPath registry entries
Remove-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion -Name PSHome
Remove-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion -Name PowerShellPath
