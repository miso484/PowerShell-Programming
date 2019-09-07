# Getting help for cmdlets
Get-Help Get-ChildItem
Get-ChildItem -?
help Get-ChildItem
Get-Help Get-Help
Get-Help -Category Cmdlet
Get-Help Get-ChildItem -Detailed
Get-Help Get-ChildItem -Full
Get-Help Get-ChildItem -Parameter *
Get-Help Get-ChildItem -Parameter System
Get-Help Get-ChildItem -Examples

#Getting conceptual help
Get-Help about_*
Get-Help about_command_syntax

#Getting help about providers
Get-Help registry
Get-Help -Category provider

#Getting help about scripts and functions
Get-Help Disable-PSRemoting
Get-Help c:\ps-test\TestScript.ps1

#Getting help online
Get-Help Get-ChildItem -Online
Get-Help Add-Computer                   #Online Version: