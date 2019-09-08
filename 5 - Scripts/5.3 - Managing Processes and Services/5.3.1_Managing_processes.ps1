#
# Getting Processes (Get-Process)
#

Get-Process -Id 0
Get-Process -Id 99
Get-Process -Name ex*           #excel, explorer
Get-Process -Name exp*,power*
Get-Process -Name PowerShell -ComputerName localhost, Server01, Server02
Get-Process -Name PowerShell -ComputerName localhost, Server01, Server01 | Format-Table -Property ID, ProcessName, MachineName
Get-Process powershell -ComputerName localhost, Server01, Server02 |
    Format-Table -Property Handles,
        @{Label="NPM(K)";Expression={[int]($_.NPM/1024)}},
        @{Label="PM(K)";Expression={[int]($_.PM/1024)}},
        @{Label="WS(K)";Expression={[int]($_.WS/1024)}},
        @{Label="VM(M)";Expression={[int]($_.VM/1MB)}},
        @{Label="CPU(s)";Expression={if ($_.CPU -ne $()){$_.CPU.ToString("N")}}},
        Id, ProcessName, MachineName -auto

#
# Stopping Processes (Stop-Process)
#

Stop-Process -Name Idle
Stop-Process -Name t*,e* -Confirm
# Stop all nonresponsive applications
Get-Process | Where-Object -FilterScript {$_.Responding -eq $false} | Stop-Process
# Stop all instances of the process that are in other sessions
Get-Process -Name BadApp | Where-Object -FilterScript {$_.SessionId -neq 0} | Stop-Process
# Stop the PowerShell process on the Server01 remote computer
Invoke-Command -ComputerName Server01 {Stop-Process Powershell}

#NOTE: The Stop-Process cmdlet does not have a ComputerName parameter

#
# Stopping All Other Windows PowerShell Sessions
#

# Stop all running Windows PowerShell sessions other than the current session
Get-Process -Name powershell | Where-Object -FilterScript {$_.Id -ne $PID} | Stop-Process -PassThru

