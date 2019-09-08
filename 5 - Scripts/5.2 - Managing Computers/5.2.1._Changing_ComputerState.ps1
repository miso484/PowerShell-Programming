# Locking a Computer
rundll32.exe user32.dll,LockWorkStation

# Logging Off the Current Session
logoff.exe 
shutdown.exe -l
(Get-WmiObject -Class Win32_OperatingSystem -ComputerName .).Win32Shutdown(0)
Get-CIMInstance -Classname Win32_OperatingSystem | Invoke-CimMethod -MethodName Shutdown

# Shutting Down or Restarting a Computer
tsshutdn.exe
shutdown.exe
Stop-Computer
Restart-Computer
Restart-Computer -Force