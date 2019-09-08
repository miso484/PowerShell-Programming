# Listing Desktop Settings
Get-CimInstance -ClassName Win32_Desktop -ComputerName .
Get-CimInstance -ClassName Win32_Desktop -ComputerName . | Select-Object -ExcludeProperty "CIM*"

# Listing BIOS Information
Get-CimInstance -ClassName Win32_BIOS -ComputerName .

# Listing Processor Information
Get-CimInstance -ClassName Win32_Processor -ComputerName . | Select-Object -ExcludeProperty "CIM*"
Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName . | Select-Object -Property SystemType

# Listing Computer Manufacturer and Model
Get-CimInstance -ClassName Win32_ComputerSystem

# Listing Installed Hotfixes
Get-CimInstance -ClassName Win32_QuickFixEngineering -ComputerName .
Get-CimInstance -ClassName Win32_QuickFixEngineering -ComputerName . -Property HotFixID
Get-CimInstance -ClassName Win32_QuickFixEngineering -ComputerName . -Property HotFixId | Select-Object -Property HotFixId

# Listing Operating System Version Information
Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName . | Select-Object -Property BuildNumber,BuildType,OSType,ServicePackMajorVersion,ServicePackMinorVersion
Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName . | Select-Object -Property Build*,OSType,ServicePack*

# Listing Local Users and Owner
Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName . | Select-Object -Property NumberOfLicensedUsers,NumberOfUsers,RegisteredUser
Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName . | Select-Object -Property *user*

# Getting Available Disk Space
Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" -ComputerName .          #DriveType=3 is for fixed drives
Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" -ComputerName . | Measure-Object -Property FreeSpace,Size -Sum | Select-Object -Property Property,Sum

# Getting Logon Session Information
Get-CimInstance -ClassName Win32_LogonSession -ComputerName .

# Getting the User Logged on to a Computer
Get-CimInstance -ClassName Win32_ComputerSystem -Property UserName -ComputerName .

# Getting Local Time from a Computer
Get-CimInstance -ClassName Win32_LocalTime -ComputerName .

# Displaying Service Status
Get-Service                                                                                                         #Local
Get-CimInstance -ClassName Win32_Service -ComputerName . | Select-Object -Property Status,Name,DisplayName          #Remote
Get-CimInstance -ClassName Win32_Service -ComputerName . | Format-Table -Property Status,Name,DisplayName -AutoSize -Wrap