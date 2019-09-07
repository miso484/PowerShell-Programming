# RUN-AS ACCOUNT

## Each JEA endpoint has a designated run-as account. This is the account under which the connecting user's actions are executed. It is configurable in the session configuration file (SCF)

## VIRTUAL ACOUNTS are the recommended way of configuring the run-as account. 
## Virtual accounts are one-time, temporary local accounts that are created for the connecting user to use during the duration of their JEA session. 
## As soon as their session is terminated, the virtual account is destroyed and can't be used anymore. 
## The connecting user doesn't know the credentials for the virtual account. 
## The virtual account can't be used to access the system via other means like Remote Desktop or an unconstrained PowerShell endpoint.

## GROUP-MANAGED SERVICE ACCOUNTS (gMSAs) are useful when a member server needs to have access to network resources in the JEA session. 
## For example, when a JEA endpoint is used to control access to a REST API service hosted on a different machine.

## PASS-THRY CREDENTIALS are used when you don't specify a run-as account.
## PowerShell uses the connecting user's credential to run commands on the remote server. 
## This requires you to grant the connecting user direct access to privileged management groups.
## This configuration is not recommended for JEA. 

## STANDARD RUN-AS accounts allow you to specify any user account under which the entire PowerShell session runs. 
## Session configurations using fixed run-as accounts (with the -RunAsCredential parameter) aren't JEA-aware. 
## You shouldn't use a RunAsCredential on a JEA endpoint because it's difficult to trace actions back to specific users and lacks support for mapping users to roles.


# WinRM Endpoint ACL (Access Conrol List)

## Each JEA endpoint has a separate access control list (ACL) that controls who can authenticate with the JEA endpoint.
## By default, when a JEA endpoint has multiple role capabilities, the WinRM ACL is configured to allow access to all mapped users. 

### EXAMPLE: a JEA session configured using the following commands grants full access to CONTOSO\JEA_Lev1 and CONTOSO\JEA_Lev2.
$roles = @{ 'CONTOSO\JEA_Lev1' = 'Lev1Role'; 'CONTOSO\JEA_Lev2' = 'Lev2Role' }
New-PSSessionConfigurationFile -Path '.\jea.pssc' -SessionType RestrictedRemoteServer -RoleDefinitions $roles -RunAsVirtualAccount
Register-PSSessionConfiguration -Path '.\jea.pssc' -Name 'MyJEAEndpoint'
### Audit user permissions
Get-PSSessionConfiguration -Name 'MyJEAEndpoint' | Select-Object Permission
### Change which users have access
Set-PSSessionConfiguration -Name 'MyJEAEndpoint' -ShowSecurityDescriptorUI


# Least privilege roles

## Remember that the virtual and group-managed service accounts running behind the scenes can have unrestricted access to the local machine.
### Less Secure Example, since it alows Start-Process to start any process
@{
    VisibleCmdlets = 'Microsoft.PowerShell.Management\*-Process'
}
### More Secure Example:
@{
    VisibleCmdlets = 'Microsoft.PowerShell.Management\Get-Process', 'Microsoft.PowerShell.Management\Stop-Process'
}


# JEA doesn't protect against admins

## One of the core principles of JEA is that it allows non-admins to do some admin tasks. JEA doesn't protect against users who already have administrator privileges.

## A common practice is to use JEA for regular day-to-day maintenance and have a just-in-time, privileged access management solution 
## that allows users to temporarily become local admins in emergency situations. 