# PREREQUISITES:
## One or more role capabilities have been authored and added to a PowerShell module.
## The PowerShell module containing the roles is stored on a (read-only) file share accessible by each machine.
## Settings for the session configuration have been determined. You don't need to create a session configuration file when using the JEA DSC resource.
## You have credentials that allow administrative actions on each machine or access to the DSC pull server used to manage the machines.
## You've downloaded the JEA DSC resource.

# A  sample DSC configuration for a general server maintenance module. It assumes that a valid PowerShell module containing role capabilities is located on the \\myfileshare\JEA file share.
Configuration JEAMaintenance
{
    Import-DscResource -Module JustEnoughAdministration, PSDesiredStateConfiguration

    File MaintenanceModule
    {
        SourcePath = "\\myfileshare\JEA\ContosoMaintenance"
        DestinationPath = "C:\Program Files\WindowsPowerShell\Modules\ContosoMaintenance"
        Checksum = "SHA-256"
        Ensure = "Present"
        Type = "Directory"
        Recurse = $true
    }

    JeaEndpoint JEAMaintenanceEndpoint
    {
        EndpointName = "JEAMaintenance"
        RoleDefinitions = "@{ 'CONTOSO\JEAMaintenanceAuditors' = @{ RoleCapabilities = 'GeneralServerMaintenance-Audit' }; 'CONTOSO\JEAMaintenanceAdmins' = @{ RoleCapabilities = 'GeneralServerMaintenance-Audit', 'GeneralServerMaintenance-Admin' } }"
        TranscriptDirectory = 'C:\ProgramData\JEAConfiguration\Transcripts'
        DependsOn = '[File]MaintenanceModule'
    }
}