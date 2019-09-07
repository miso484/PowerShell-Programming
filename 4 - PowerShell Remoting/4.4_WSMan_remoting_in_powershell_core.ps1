# Instructions to Create a Remoting Endpoint

## The PowerShell Core package for Windows includes a WinRM plug-in (pwrshplugin.dll) and an installation script (Install-PowerShellRemoting.ps1) in $PSHome. 
## These files enable PowerShell to accept incoming PowerShell remote connections when its endpoint is specified.

## NOTE: The remoting registration script will restart WinRM, so all existing PSRP sessions will terminate immediately after the script is run. If run during a remote session, this will terminate the connection.

Set-Location -Path 'C:\Program Files\PowerShell\6.0.0\'
.\Install-PowerShellRemoting.ps1 -PowerShellHome "C:\Program Files\PowerShell\6.0.0\"


# How to Connect to the New Endpoint

New-PSSession ... -ConfigurationName "powershell.6.0.0"
Enter-PSSession ... -ConfigurationName "powershell.6.0.0"