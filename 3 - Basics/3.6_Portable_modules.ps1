# Porting an Existing Module

## Porting a PSSnapIn
### PowerShell SnapIns aren't supported in PowerShell Core. However, it's trivial to convert a PSSnapIn to a PowerShell module.
### Use New-ModuleManifest to create a new module manifest that replaces the need for the PSSnapIn registration code.

## The .NET Portability Analyzer (aka APIPort)
### To port modules written for Windows PowerShell to work with PowerShell Core, start with the '.NET Portability Analyzer'.

# Creating a New Module - use .NET CLI

## Installing the PowerShell Standard Module Template
dotnet new -i Microsoft.PowerShell.Standard.Module.Template
## Creating a New Module Project
mkdir ~/Projects/myModule
cd myModule
## Building the Module using standard .NET CLI commands
dotnet build
## Testing the Module
ipmo .\bin\Debug\netstandard2.0\myModule.dll
Test-SampleCmdlet -?
Test-SampleCmdlet -FavoriteNumber 7 -FavoritePet Cat

# .NET Standard Library
## .NET Standard is a formal specification of .NET APIs that are available in all .NET implementations. 
## Managed code targeting .NET Standard works with the .NET Framework and .NET Core versions that are compatible with that version of the .NET Standard.
## .NET Standard is a formal specification of .NET APIs that are available in all .NET implementations. 
## Managed code targeting .NET Standard works with the .NET Framework and .NET Core versions that are compatible with that version of the .NET Standard.

# PowerShell Standard Library
## The PowerShell Standard library is a formal specification of PowerShell APIs available in all PowerShell versions greater than or equal to the version of that standard.
## We recommend you compile your module using PowerShell Standard Library. 
## A module built using PowerShell Standard Library 5.1 will always be compatible with future versions of PowerShell.

# Module Manifest
## Indicating Compatibility With Windows PowerShell and PowerShell Core
### After validating that your module works with both Windows PowerShell and PowerShell Core, the module manifest should explicitly indicate compatibility by using the CompatiblePSEditions property.
## Indicating OS Compatibility
### First, validate that your module works on Linux and macOS. Next, indicate compatibility with those operating systems in the module manifest. 
### This makes it easier for users to find your module for their operating system when published to the PowerShell Gallery.
### Within the module manifest, the PrivateData property has a PSData sub-property. The optional Tags property of PSData takes an array of values that show up in PowerShell Gallery.

### Check 3.6.1_Example.ps1

