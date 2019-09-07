# A JEA endpoint is registered on a system by creating and registering a PowerShell session configuration file with .pssc extension.
# Session configurations define who can use the JEA endpoint and which roles they have access to.
# They also define global settings that apply to all users of the JEA session.

# Create blank template configuration file
New-PSSessionConfigurationFile -SessionType RestrictedRemoteServer -Path .\MyJEAEndpoint.pssc

# Choose the JEA identity - account to use when running a connected user's commands

## Local virtual account - temporary accounts that are unique to a specific user and only last for the duration of their PowerShell session.

### Setting the session to use a virtual account
RunAsVirtualAccount = $true

### Setting the session to use a virtual account that only belongs to the NetworkOperator and NetworkAuditor local groups
RunAsVirtualAccount = $true
RunAsVirtualAccountGroups = 'NetworkOperator', 'NetworkAuditor'

## Group-managed service account - the appropriate identity to use when JEA users need to access network resources such as file shares and web services.

### Configure JEA sessions to use the GMSA in the local computer's domain with the sAMAccountName of 'MyJEAGMSA'
GroupManagedServiceAccount = 'Domain\MyJEAGMSA'

## Session transcripts - can be useful to an auditing team who needs to understand who made a specific change to a system.
TranscriptDirectory = 'C:\ProgramData\JEAConfiguration\Transcripts'

## User drive - allows users to copy files to or from the system without giving them access to the full file system or exposing the FileSystem provider.
MountUserDrive = $true

### Enables the user drive with a per-user limit of 500MB (524288000 bytes)
MountUserDrive = $true
UserDriveMaximumSize = 524288000

## Role definitions - define the mapping of users to roles.
RoleDefinitions = @{
    'CONTOSO\JEA_DNS_ADMINS'    = @{ RoleCapabilities = 'DnsAdmin', 'DnsOperator', 'DnsAuditor' }
    'CONTOSO\JEA_DNS_OPERATORS' = @{ RoleCapabilities = 'DnsOperator', 'DnsAuditor' }
    'CONTOSO\JEA_DNS_AUDITORS'  = @{ RoleCapabilities = 'DnsAuditor' }
}

### For local users or group, use whole computername (check with variable: $env:COMPUTERNAME), not localhost
RoleDefinitions = @{
    'MyComputerName\MyLocalGroup' = @{ RoleCapabilities = 'DnsAuditor' }
}

## Role capability search order
### JEA uses the $env:PSModulePath environment variable to determine which paths to scan for role capability files.
### Within each of those paths, JEA looks for valid PowerShell modules that contain a "RoleCapabilities" subfolder. As

## Conditional access rules
### Require users to belong to additional security groups that don't impact the roles to which they're assigned. 
### his is useful when you want to integrate a just-in-time privileged access management solution, smartcard authentication, or other multifactor authentication solution with JEA.
### Example 1: Connecting users must belong to a security group called "elevated-jea"
RequiredGroups = @{ And = 'elevated-jea' }
### Example 2: Connecting users must have signed on with 2 factor authentication or a smart card
### The 2 factor authentication group name is "2FA-logon" and the smart card group name is "smartcard-logon"
RequiredGroups = @{ Or = '2FA-logon', 'smartcard-logon' }
### Example 3: Connecting users must elevate into "elevated-jea" with their JIT system and have logged on with 2FA or a smart card
RequiredGroups = @{ And = 'elevated-jea', @{ Or = '2FA-logon', 'smartcard-logon' }}

## Other properties
### Session configuration files can also do everything a role capability file can do, just without the ability to give connecting users access to different commands.

# Testing a session configuration file
##Example 1: Test a session configuration file
Test-PSSessionConfigurationFile -Path "FullLanguage.pssc"
##Example 2: Test all session configuration files
function Test-AllConfigFiles
{
    Get-PSSessionConfiguration | ForEach-Object {
        if ($_.ConfigFilePath) {
            $_.ConfigFilePath
            Test-PSSessionConfigurationFile -Verbose -Path $_.ConfigFilePath
        }
    }
}
Test-AllConfigFiles

# Updating Session Configuration Files
## To change the properties of a JEA session configuration, including the mapping of users to roles, you must unregister. 
## Then, re-register the JEA session configuration using an updated session configuration file.