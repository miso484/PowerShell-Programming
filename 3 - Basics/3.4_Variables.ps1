# Using variables to store objects

# Creating a variable
$loc
$loc = Get-Location
$loc
$loc | Get-Member -MemberType Property
$loc | Get-Member -MemberType Method

# Manipulating variables
Get-Command -Noun Variable | Format-Table -Property Name,Definition -AutoSize -Wrap
Remove-Variable -Name * -Force -ErrorAction SilentlyContinue
Get-Variable
Get-ChildItem variable:         #variable drive

# Using cmd.exe variables - for Windows OS
Get-ChildItem env:
$env:SystemRoot
$env:LIB_PATH='/usr/local/lib'