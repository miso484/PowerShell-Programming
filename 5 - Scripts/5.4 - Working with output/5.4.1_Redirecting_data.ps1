#
# Paging Console Output (Out-Host)
#

Get-Command | Out-Host -Paging
Get-Command | more

#
# Discarding Output (Out-Null) (it does not discard error output)
#

Get-Command | Out-Null

#
# Printing Data (Out-Printer)
#

Get-Command Get-Command | Out-Printer -Name 'Microsoft Office Document Image Writer'

#
# Saving Data (Out-File)
#

# Unicode file
Get-Process | Out-File -FilePath C:\temp\processlist.txt
# ASCII file
Get-Process | Out-File -FilePath C:\temp\processlist.txt -Encoding ASCII

# Out-file formats file contents to look like console output
Get-Command | Out-File -FilePath c:\temp\output.txt
# Get output that does not force line wraps to match the screen width
Get-Command | Out-File -FilePath c:\temp\output.txt -Width 2147483647