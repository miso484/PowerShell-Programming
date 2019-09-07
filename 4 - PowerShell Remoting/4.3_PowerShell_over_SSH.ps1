# KNOWN ISSUE: The sudo command doesn't work in remote session to Linux machine.

# PowerShell remoting normally uses WinRM for connection negotiation and data transport. 
# SSH is now available for Linux and Windows platforms and allows true multiplatform PowerShell remoting.

# The New-PSSession, Enter-PSSession, and Invoke-Command cmdlets now have a new parameter set:
# [-HostName <string>]  [-UserName <string>]  [-KeyFilePath <string>]
