# If you try to create a System.Environment or a System.Math object with New-Object, you will get the following error messages, 
# since these classes are reference libraries of methods and properties that do not change state.

#
# Getting Environment Data with System.Environment
#

# Referring to the Static System.Environment Class
[System.Environment]

# View static members 
[System.Environment] | Get-Member -Static

# Displaying Static Properties of System.Environment
[System.Environment]::Commandline
[System.Environment]::OSVersion
[System.Environment]::HasShutdownStarted


#
# Doing Math with System.Math
#

# List methods
[System.Math] | Get-Member -Static -MemberType Methods

# Demonstrate
[System.Math]::Sqrt(9)
[System.Math]::Pow(2,3)
[System.Math]::Floor(3.3)
[System.Math]::Floor(-3.3)
[System.Math]::Ceiling(3.3)
[System.Math]::Ceiling(-3.3)
[System.Math]::Max(2,7)
[System.Math]::Min(2,7)
[System.Math]::Truncate(9.3)
[System.Math]::Truncate(-9.3)
