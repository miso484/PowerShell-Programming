#
# SSH Linux to Linux
#
$session = New-PSSession -HostName UbuntuVM1 -UserName TestUser
$session
Enter-PSSession $session
Exit-PSSession
Invoke-Command $session -ScriptBlock { Get-Process powershell }

Enter-PSSession -HostName TestUser@UbuntuVM1:2222       #PSC v6.1+


#
# SSH Linux to Windows
#
Enter-PSSession -HostName WinVM1 -UserName PTestName
cmd /c ver

Enter-PSSession -HostName PTestName@WinVM1:2222         #PSC v6.1+        

#
# SSH Windows to Windows
#
pwsh.exe
$session = New-PSSession -HostName WinVM2 -UserName PSRemoteUser
$session
Enter-PSSession -Session $session
Exit-PSSession

Enter-PSSession -HostName PSRemoteUser@WinVM2           #PSC v6.1+     