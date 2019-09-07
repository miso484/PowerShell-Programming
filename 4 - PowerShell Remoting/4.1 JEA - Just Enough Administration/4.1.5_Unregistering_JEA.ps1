# Unregister the JEA endpoint called "ContosoMaintenance" -  this causes the WinRM service to restart
Unregister-PSSessionConfiguration -Name 'ContosoMaintenance' -Force

## Only unregister PowerShell endpoints during planned maintenance windows.