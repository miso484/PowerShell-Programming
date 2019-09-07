# Once you have your role capabilities and session configuration file created, the last step is to register the JEA endpoint. 
# Registering the JEA endpoint with the system makes the endpoint available for use by users and automation engines.

# PREREQUISITES
## One or more roles has been created and placed in the RoleCapabilities folder of a PowerShell module.
## A session configuration file has been created and tested.
## The user registering the JEA configuration has administrator rights on the system.
## You've selected a name for your JEA endpoint.

# Single machine configuration
## List the names of the endpoints on a system - The microsoft.powershell endpoint is the default endpoint used when connecting to a remote PowerShell endpoint.
Get-PSSessionConfiguration | Select-Object Name
# Register the endpoint - this restarts the WinRM service on the system
Register-PSSessionConfiguration -Path .\MyJEAConfig.pssc -Name 'JEAMaintenance' -Force

## This terminates all PowerShell remoting sessions and any ongoing DSC configurations. We recommended you take production machines offline before running the command to avoid disrupting business operations.
