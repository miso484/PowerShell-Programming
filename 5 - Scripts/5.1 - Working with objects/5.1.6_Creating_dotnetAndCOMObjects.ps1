#
# Using New-Object for Event Log Access
#

# Get a reference to the Application log
New-Object -TypeName System.Diagnostics.EventLog -ArgumentList Application

# Store the Application log reference in a variable named $AppLog, and see that it contains the Application log
$AppLog = New-Object -TypeName System.Diagnostics.EventLog -ArgumentList Application
$AppLog

# Access Application log on the remote computer
$RemoteAppLog = New-Object -TypeName System.Diagnostics.EventLog Application,192.168.1.81
$RemoteAppLog

# Clear an Event Log with Object Methods
$RemoteAppLog | Get-Member -MemberType Method
$RemoteAppLog.Clear()
$RemoteAppLog

#
# Creating COM (Component Object Model) Objects with New-Object
#

# Create the WSH (Windows Script Host) objects by specifying these progids
New-Object -ComObject WScript.Shell
New-Object -ComObject WScript.Network
New-Object -ComObject Scripting.Dictionary
New-Object -ComObject Scripting.FileSystemObject

#
# Creating a Desktop Shortcut with WScript.Shell
#

$WshShell = New-Object -ComObject WScript.Shell
$WshShell | Get-Member
Get-Member -InputObject $WshShell
$lnk = $WshShell.CreateShortcut("$Home\Desktop\PSHome.lnk")
$lnk | Get-Member
$lnk.TargetPath = $PSHome
$lnk.Save()

#
# Using Internet Explorer from Windows PowerShell
#

# Create an Internet Explorer instance
$ie = New-Object -ComObject InternetExplorer.Application        #this start proces which is not visible
Get-Process -Name iexplore
$ie | Get-Member
# To see the Internet Explorer window
$ie.Visible = $true
# Navigate to a specific Web address
$ie.Navigate("http://www.microsoft.com/technet/scriptcenter/default.mspx")
# Display the HTML text in the body of the current Web page
$ie.Document.Body.InnerText
# Close Internet Explorer from within PowerShell
$ie.Quit()
Remove-Variable ie

#
# Getting Warnings About .NET Framework-Wrapped COM Objects (using -Strict parameter)
#

# If you specify the Strict parameter and then create a COM object that uses an RCW, you get a warning message 
$xl = New-Object -ComObject Excel.Application -Strict
