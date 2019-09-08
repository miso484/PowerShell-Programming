#
# ForEach-Object cmdlet uses script blocks
# $_ descriptor for the current pipeline object 
#

# Return space information for each local disk
Get-WmiObject -Class Win32_LogicalDisk

# Convert the FreeSpace value to megabytes
Get-WmiObject -Class Win32_LogicalDisk | ForEach-Object -Process {($_.FreeSpace)/1024.0/1024.0}