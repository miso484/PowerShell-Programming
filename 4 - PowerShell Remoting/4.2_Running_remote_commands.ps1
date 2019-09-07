# Windows PowerShell Remoting Without Configuration

## Get cmdlets that support remoting without special configuration
Get-Command | where { $_.parameters.keys -contains "ComputerName" -and $_.parameters.keys -notcontains "Session"}

##Restart-Computer
##Test-Connection
##Clear-EventLog
##Get-EventLog
##Get-HotFix
##Get-Process
##Get-Service
##Set-Service
##Get-WinEvent
##Get-WmiObject


# Windows PowerShell Remoting

## Start an Interactive Session
Enter-PSSession Server01

## End the interactive session
Exit-PSSession

## Run a Remote Command
Invoke-Command -ComputerName Server01, Server02 -ScriptBlock {Get-UICulture}

## Run a Script
Invoke-Command -ComputerName Server01, Server02 -FilePath c:\Scripts\DiskCollect.ps1

## Establish a Persistent Connection
$s = New-PSSession -ComputerName Server01, Server02
Invoke-Command -Session $s {$h = Get-HotFix}
Invoke-Command -Session $s {$h | where {$_.InstalledBy -ne "NTAUTHORITY\SYSTEM"}}
