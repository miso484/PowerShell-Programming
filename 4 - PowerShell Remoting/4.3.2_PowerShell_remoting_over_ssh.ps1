#
# Linux to Linux
#
$session = New-PSSession -HostName UbuntuVM1 -UserName TestUser
$session
Enter-PSSession $session
Exit-PSSession
Invoke-Command $session -ScriptBlock { Get-Process powershell }


#
# Linux to Windows
#
Enter-PSSession -HostName WinVM1 -UserName PTestName
cmd /c ver


#
# Windows to Windows
#
pwsh.exe
$session = New-PSSession -HostName WinVM2 -UserName PSRemoteUser
$session
Enter-PSSession -Session $session
Exit-PSSession
