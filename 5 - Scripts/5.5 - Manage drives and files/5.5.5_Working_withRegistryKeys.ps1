# Registry keys are items on Windows PowerShell drives so working with them is similar as working with files and folders

#
# Listing All Subkeys of a Registry Key
#

# Display the items directly within Windows PowerShell drive HKCU:, which corresponds to the HKEY_CURRENT_USER registry hive
Get-ChildItem -Path hkcu:\

# Specify registry path by specifying the registry provider's name, followed by "::"
Get-ChildItem -Path Registry::HKEY_CURRENT_USER
Get-ChildItem -Path Microsoft.PowerShell.Core\Registry::HKEY_CURRENT_USER
Get-ChildItem -Path Registry::HKCU
Get-ChildItem -Path Microsoft.PowerShell.Core\Registry::HKCU
Get-ChildItem HKCU:

# Show contained items
Get-ChildItem -Path hkcu:\ -Recurse

# Find all keys within HKCU:\Software that have no more than one subkey and also have exactly four values
Get-ChildItem -Path HKCU:\Software -Recurse | Where-Object -FilterScript {($_.SubKeyCount -le 1) -and ($_.ValueCount -eq 4) }

#
# Copying Keys
#

# Copy HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion and all of its properties to HKCU:\, creating a new key named "CurrentVersion"
Copy-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion' -Destination hkcu:

# Copy all of the contents of a container,
Copy-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion' -Destination hkcu: -Recurse

#
# Creating Keys
#

# Create registry key (since reg key is container,there's no need to specify item type, just path)
New-Item -Path hkcu:\software_DeleteMe

# Create registry key using provider path
New-Item -Path Registry::HKCU_DeleteMe

#
# Deleting Keys
#

Remove-Item -Path hkcu:\Software_DeleteMe
Remove-Item -Path 'hkcu:\key with spaces in the name'

#
# Removing All Keys Under a Specific Key
#

# You will be prompted to confirmation if the item contains anything else
Remove-Item -Path hkcu:\CurrentVersion

# Delete contained items without prompting
Remove-Item -Path HKCU:\CurrentVersion -Recurse

# Remove all items within HKCU:\CurrentVersion but not HKCU:\CurrentVersion itself
Remove-Item -Path HKCU:\CurrentVersion\* -Recurse