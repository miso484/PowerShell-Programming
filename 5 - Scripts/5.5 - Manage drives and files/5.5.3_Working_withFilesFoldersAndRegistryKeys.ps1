#
# Enumerating Files, Folders, and Registry Keys (Get-ChildItem)
#

# Get all files and folders
Get-ChildItem -Path C:\Windows

# Listing all Contained Items (-Recurse)
Get-ChildItem -Path C:\WINDOWS -Recurse

# Filtering Items by Name (-Name)
Get-ChildItem -Path C:\WINDOWS -Name

# Forcibly Listing Hidden Items (-Force)
Get-ChildItem -Path C:\Windows -Force

# Find all files in the Windows directory with the suffix .log and exactly five characters in the base name
Get-ChildItem -Path C:\Windows\?????.log

# Find all files that begin with the letter x in the Windows directory
Get-ChildItem -Path C:\Windows\x*

# Find all files whose names begin with x or z
Get-ChildItem -Path C:\Windows\[xz]*

# Excluding Items (-Exclude)
Get-ChildItem -Path C:\WINDOWS\System32\w*32*.dll -Exclude *[9516]*

# Mixing Get-ChildItem Parameters
Get-ChildItem -Path C:\Windows -Include *.dll -Recurse -Exclude [a-y]*.dll