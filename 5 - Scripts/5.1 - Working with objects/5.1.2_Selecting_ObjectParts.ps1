#
# Select-Object
#

# Get-WmiObject cmdlet is not implemented in PSC

# Create a new object that includes only the Name and FreeSpace properties of the Win32_LogicalDisk WMI class
Get-WmiObject -Class Win32_LogicalDisk | Select-Object -Property Name,FreeSpace

Get-WmiObject -Class Win32_LogicalDisk | Select-Object -Property Name,FreeSpace| Get-Member

# Update the value of FreeSpace in our newly-created objects and the output will include the descriptive label
Get-WmiObject -Class Win32_LogicalDisk | Select-Object -Property Name,FreeSpace | ForEach-Object -Process {$_.FreeSpace = ($_.FreeSpace)/1024.0/1024.0; $_}