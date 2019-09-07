# Find registered JEA sessions on a machine

## Filter for sessions that are configured as 'RestrictedRemoteServer' to find JEA-like session configurations (check Permission property)
Get-PSSessionConfiguration | Where-Object { $_.SessionType -eq 'RestrictedRemoteServer' }

## Expand the RoleDefinitions property to evaluate the role mappings in a registered JEA endpoint (defined in .pssc file under RoleDefinitions property).
### Get the desired session configuration
$jea = Get-PSSessionConfiguration -Name 'JEAMaintenance'
### Enumerate users/groups and which roles they have access to
$jea.RoleDefinitions.GetEnumerator() | Select-Object Name, @{
  Name = 'Role Capabilities'
  Expression = { $_.Value.RoleCapabilities }
}


# Find available role capabilities on the machine (defined in .psrc file under RoleCapabilities property)
function Find-LocalRoleCapability {
    $results = @()
    # Find modules with a "RoleCapabilities" subfolder and add any PSRC files to the result set
    Get-Module -ListAvailable | ForEach-Object {
        $psrcpath = Join-Path -Path $_.ModuleBase -ChildPath 'RoleCapabilities'
        if (Test-Path $psrcpath) {
            $results += Get-ChildItem -Path $psrcpath -Filter *.psrc
        }
    }
    # Format the results nicely to make it easier to read
    $results | Select-Object @{ Name = 'Name'; Expression = { $_.Name.TrimEnd('.psrc') }}, @{
        Name = 'Path'; Expression = { $_.FullName }
    } | Sort-Object Name
}


# Check effective rights for a specific user
Get-PSSessionCapability -ConfigurationName 'JEAMaintenance' -Username 'CONTOSO\Alice'


# PowerShell event logs
## To check what commands user run in JEA session, open Microsoft-Windows-PowerShell/Operational event log and look for events with event ID 4104.

# Application event logs
## Event ID 193 in the Microsoft-Windows-Windows Remote Management/Operational log records the security identifier (SID) and account name for both the connecting user and run as user for every new JEA session.

# Session transcripts
## Find all transcripts
Get-PSSessionConfiguration |
  Where-Object { $_.TranscriptDirectory -ne $null } |
    Format-Table Name, TranscriptDirectory

    
