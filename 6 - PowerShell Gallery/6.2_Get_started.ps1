#
# Discovering packages from the PowerShell Gallery
#

# Find modules
## by name
Find-Module -Name PowerShellGet
## with similar names
Find-Module -Name PowerShell*
## by minimum version
Find-Module -Name PowerShellGet -MinimumVersion 1.6.5
## by specific version
Find-Module -Name PowerShellGet -RequiredVersion 1.6.5
## in a specific repository
Find-Module -Name PowerShellGet -Repository PSGallery
## in multiple repositories
Register-PSRepository -Name MySource -SourceLocation https://www.myget.org/F/powershellgetdemo/
Find-Module -Name Contoso* -Repository PSGallery, MySource
## that contains DSC resource
Find-Module -Repository PSGallery -Includes DscResource
## with a filter
Find-Module -Filter AppDomain

# Find DSC resources
## all
Find-DscResource
## by name
Find-DscResource -Name xWebsite, xWebApplication, xWebSiteDefaults
## byname and install it
Find-DscResource -Name xWebsite | Install-Module
## all resources in a module
Find-DscResource -ModuleName xWebAdministration
## by tag and required version
Find-DscResource -ModuleName xWebAdministration -Tag DSC -RequiredVersion 1.20
## by using filter
Find-DscResource -Filter Domain

# Find scripts
## all available scripts
Find-Script
## by name
Find-Script -Name "Start-WFContosoServer"
## by name, required version, and from a specified repository
Find-Script -Name "Required-Script2" -RequiredVersion 2.0 -Repository "LocalRepo01"
## and format the output as a list
Find-Script -Name "Required-Script2" -RequiredVersion 2.0 -Repository "LocalRepo1" | Format-List * -Force
## in a specified verson range
Find-Script -Name "Required-Script2" -MinimumVersion 2.1 -MaximumVersion 2.5 -Repository "LocalRepo1"
## all versions
Find-Script -Name "Required-Script02" -AllVersions
## and its dependencies
Find-Script -Name "Script-WithDependencies1" -IncludeDependencies -Repository "LocalRepo1"
## with a specified tag
Find-Script -Tag "Tag1" -Repository "LocalRepo1"
## with specified command name
Find-Script -Command Test-FunctionFromScript_Required-Script3 -Repository "LocalRepo1"
## with workflows
Find-Script -Includes "Workflow" -Repository "LocalRepo1"
## using wildcards
Find-Script -Name "Required-Script*" -Repository "LocalRepo1"

#
# Learning about packages in the PowerShell Gallery
#

# Return data of the module
Find-Module -Name PSReadLine -Repository PSGallery | Get-Member

#
# Downloading packages from the PowerShell Gallery
#

# Inspect
## To download a package from the Gallery for inspection (without installing it), run either the Save-Module or Save-Script cmdlet, depending on the package type.

Save-Module -Name PowerShellGet -Path C:\Test\Modules -Repository PSGallery
Get-ChildItem -Path C:\Test\Modules

Save-Script -Name Install-VSCode -Repository PSGallery -Path C:\Test\Scripts
Test-ScriptFileInfo -Path C:\Test\Scripts\Install-VSCode.ps1

# Install
## To install a package from the Gallery for use, run either the Install-Module or Install-Script cmdlet, depending on the package type.

## Various ways to install module   
Install-Module -Name PowerShellGet
Install-Module -Name PowerShellGet -MinimumVersion 2.0.1
Install-Module -Name PowerShellGet -RequiredVersion 2.0.0
Install-Module -Name PowerShellGet -Scope CurrentUser

## Find a script and install it
Find-Script -Repository "Local1" -Name "Required-Script2" | Install-Script
Get-Command -Name "Required-Script2"
Get-InstalledScript -Name "Required-Script2" | Format-List *

## Install a script with AllUsers scope
Install-Script -Repository "Local1" -Name "Required-Script3" -Scope "AllUsers"
Get-InstalledScript -Name "Required-Script3" | Format-List *

# Deploy
## To deploy a package from the PowerShell Gallery to Azure Automation, click Azure Automation, then click Deploy to Azure Automation on the package details page.

#
# Updating packages from the PowerShell Gallery
#

##To update packages installed from the PowerShell Gallery, run either the [Update-Module][] or [Update-Script][] cmdlet.

# Update a module to a specified version
Update-Module -Name SpeculationControl -RequiredVersion 1.0.14

# Update the specified script
Update-Script -Name UpdateManagement-Template -RequiredVersion 1.1
Get-InstalledScript -Name UpdateManagement-Template

#
# List packages that you have installed from the PowerShell Gallery
#

# Module
## Get all installed modules
Get-InstalledModule
## Get specific versions of a module
Get-InstalledModule -Name "AzureRM.Automation" -MinimumVersion 1.0 -MaximumVersion 2.0

# Script
## Get all installed scripts
Get-InstalledScript
## Get installed scripts by name
Get-InstalledScript -Name "Required-Scri*"