#
# Getting Services
#

Get-Service -Name se*
Get-Service -DisplayName se*
Get-Service -DisplayName ServiceLayer,Server
Get-Service -ComputerName Server01

#
# Getting Required and Dependent Services
#

# These parameters just display the values of the DependentServices and ServicesDependedOn (alias=RequiredServices) properties of the System.ServiceProcess.ServiceController object 
# that Get-Service returns, but they simplify commands and make getting this information much simpler.

# Get the services that the LanmanWorkstation service requires
Get-Service -Name LanmanWorkstation -RequiredServices

# Get the services that require the LanmanWorkstation service
Get-Service -Name LanmanWorkstation -DependentServices

Get-Service -Name * | Where-Object {$_.RequiredServices -or $_.DependentServices} | Format-Table -Property Status, Name, RequiredServices, DependentServices -auto

#
# Stopping, Starting, Suspending, and Restarting Services
#

Stop-Service -Name spooler
Start-Service -Name spooler
Suspend-Service -Name spooler
Restart-Service -Name spooler

# Restart multiple services
Get-Service | Where-Object -FilterScript {$_.CanStop} | Restart-Service

# Restart the Spooler service on the Server01 remote computer
Invoke-Command -ComputerName Server01 {Restart-Service Spooler}