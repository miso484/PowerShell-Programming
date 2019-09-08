#
# Listing IP Addresses for a Computer
#

Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=$true -ComputerName . | Format-Table -Property IPAddress

#
# Listing IP Configuration Data
#

Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=$true -ComputerName .
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=$true -ComputerName . | Select-Object -Property [a-z]* -ExcludeProperty IPX*,WINS*

#
# Pinging Computers
#

Get-WmiObject -Class Win32_PingStatus -Filter "Address='127.0.0.1'" -ComputerName .
Get-WmiObject -Class Win32_PingStatus -Filter "Address='127.0.0.1'" -ComputerName . | Format-Table -Property Address,ResponseTime,StatusCode -Autosize

'127.0.0.1','localhost','research.microsoft.com' | 
  ForEach-Object -Process {Get-WmiObject -Class Win32_PingStatus -Filter ("Address='" + $_ + "'") -ComputerName .} |
  Select-Object -Property Address,ResponseTime,StatusCode

  1..254 | ForEach-Object -Process {Get-WmiObject -Class Win32_PingStatus -Filter ("Address='192.168.1." + $_ + "'") -ComputerName .} |
    Select-Object -Property Address,ResponseTime,StatusCode

$ips = 1..254 | ForEach-Object -Process {'192.168.1.' + $_}
$ips

#
# Retrieving Network Adapter Properties
#

Get-WmiObject -Class Win32_NetworkAdapter -ComputerName .

#
# Assigning the DNS Domain for a Network Adapter
#

Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=$true -ComputerName . | ForEach-Object -Process { $_. SetDNSDomain('fabrikam.com') }
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -ComputerName . | Where-Object -FilterScript {$_.IPEnabled} | ForEach-Object -Process {$_.SetDNSDomain('fabrikam.com')}

#
# Performing DHCP Configuration Tasks
#

# Determining DHCP-Enabled Adapters
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$true" -ComputerName .

# Exclude adapters with IP configuration problems
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter "IPEnabled=$true and DHCPEnabled=$true" -ComputerName .

# Retrieving DHCP Properties
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$true" -ComputerName . | Format-Table -Property DHCP*

# Enabling DHCP on Each Adapter
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=$true -ComputerName . | ForEach-Object -Process {$_.EnableDHCP()}

# Releasing and Renewing DHCP Leases on Specific Adapters
# NOTE: When using these methods on a remote computer, be aware that you can lose access to the remote system if you are connected to it through the adapter with the released or renewed lease.    
# Release
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter "IPEnabled=$true and DHCPEnabled=$true" -ComputerName . | Where-Object -FilterScript {$_.DHCPServer -contains '192.168.1.254'} | ForEach-Object -Process {$_.ReleaseDHCPLease()}
# Renew
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter "IPEnabled=$true and DHCPEnabled=$true" -ComputerName . | Where-Object -FilterScript {$_.DHCPServer -contains '192.168.1.254'} | ForEach-Object -Process {$_.RenewDHCPLease()}

# Releasing and Renewing DHCP Leases on All Adapters
Get-WmiObject -List | Where-Object -FilterScript {$_.Name -eq 'Win32_NetworkAdapterConfiguration'}
( Get-WmiObject -List | Where-Object -FilterScript {$_.Name -eq 'Win32_NetworkAdapterConfiguration'} ).ReleaseDHCPLeaseAll()
( Get-WmiObject -List | Where-Object -FilterScript {$_.Name -eq 'Win32_NetworkAdapterConfiguration'} ).RenewDHCPLeaseAll()

#
# Creating a Network Share
#

# By using Win32_Share Create method
(Get-WmiObject -List -ComputerName . | Where-Object -FilterScript {$_.Name -eq 'Win32_Share'}).Create('C:\temp','TempShare',0,25,'test share of the temp folder')

# By using net share in Windows PowerShell
net share tempshare=c:\temp /users:25 /remark:"test share of the temp folder"

#
# Removing a Network Share
#

# By using Win32_Share method
(Get-WmiObject -Class Win32_Share -ComputerName . -Filter "Name='TempShare'").Delete()

# By using net share
net share tempshare /delete

#
# Connecting a Windows Accessible Network Drive
#

# By using WScript.Network COM object
(New-Object -ComObject WScript.Network).MapNetworkDrive('B:', '\\FPS01\users')

# By net use
net use B: \\FPS01\users

# NOTE: The New-PSDrive cmdlets creates a Windows PowerShell drive, but drives created this way are available only to Windows PowerShell. 