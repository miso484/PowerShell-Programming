# A role capability is a PowerShell data file with the .psrc extension that lists all the cmdlets, functions, providers, and external programs that are made available to connecting users.

# Determine which commands to allow
##1. IDENTIFY the commands users are using to get their jobs done. 
##2. UPDATE use of command-line tools to PowerShell equivalents, where possible, for the best auditing and JEA customization experience.
##3. RESTRICT the scope of the cmdlets to only allow specific parameters or parameter values.
##4. CREATE custom functions to replace complex commands or commands that are difficult to constrain in JEA.
##5. TEST the scoped list of allowable commands with your users or automation services, and adjust as necessary.

# Examples of potentially dangerous commands
## Granting the connecting user admin privileges to bypass JEA (Add-ADGroupMember, Add-LocalGroupMember, net.exe, dsadd.exe)
### EXAMPLE: Add-LocalGroupMember -Member 'CONTOSO\jdoe' -Group 'Administrators'
## Running arbitrary code, such as malware, exploits, or custom scripts to bypass protections (Start-Process, New-Service, Invoke-Item, Invoke-WmiMethod, Invoke-CimMethod, Invoke-Expression, Invoke-Command, New-ScheduledTask, Register-ScheduledJob)
### EXAMPLE: Start-Process -FilePath '\\san\share\malware.exe'

# Create a role capability file
New-PSRoleCapabilityFile -Path .\MyFirstJEARole.psrc

# Allowing PowerShell cmdlets and functions
##  EXAMPLE 1: Allowing PowerShell cmdlets and functions
VisibleCmdlets = 'Restart-Computer', 'Get-NetIPAddress'
## EXAMPLE 2: Restrict parameters
VisibleCmdlets = @{ Name = 'Restart-Computer'; Parameters = @{ Name = 'Name' }}
## EXAMPLE 3: Restrict parameters with only specific values
VisibleCmdlets = @{ Name = 'Restart-Service'; Parameters = @{ Name = 'Name'; ValidateSet = 'Dns', 'Spooler' }},
                 @{ Name = 'Start-Website'; Parameters = @{ Name = 'Name'; ValidatePattern = 'HR_*' }}

# Allowing external commands and PowerShell scripts
VisibleExternalCommands = 'C:\Windows\System32\whoami.exe', 'C:\Program Files\Contoso\Scripts\UpdateITSoftware.ps1'

# Allowing access to PowerShell providers
VisibleProviders = 'Registry'

# Creating custom functions
VisibleFunctions = 'Get-TopProcess'

FunctionDefinitions = @{
    Name = 'Get-TopProcess'

    ScriptBlock = {
        param($Count = 10)

        Get-Process | Sort-Object -Property CPU -Descending |
            Microsoft.PowerShell.Utility\Select-Object -First $Count
    }
}

# Updating role capabilities
## nly highly trusted administrators should be allowed to change role capability files. 
## If an untrusted user can change role capability files, they can easily give themselves access to cmdlets that allow them to elevate their privileges.
## For administrators looking to lock down access to the role capabilities, ensure Local System has read access to the role capability files and containing modules.

