#
# Listing All the Files and Folders Within a Folder
#

# Get all items directly within a folder
Get-ChildItem -Path C:\ -Force

# Show contained items
Get-ChildItem -Path C:\ -Force -Recurse

# EXAMPLE:
Get-ChildItem -Path $env:ProgramFiles -Recurse -Include *.exe | Where-Object -FilterScript {($_.LastWriteTime -gt '2005-10-01') -and ($_.Length -ge 1mb) -and ($_.Length -le 10mb)}

#
# Copying Files and Folders
#

# Back up file
Copy-Item -Path C:\boot.ini -Destination C:\boot.bak
# if destination exists
Copy-Item -Path C:\boot.ini -Destination C:\boot.bak -Force

# Copy folder
Copy-Item C:\temp\test1 -Recurse C:\temp\DeleteMe

# Copy all .txt files
Copy-Item -Filter *.txt -Path c:\data -Recurse -Destination C:\temp\text

# Use COM Class to copy file
(New-Object -ComObject Scripting.FileSystemObject).CopyFile('C:\boot.ini', 'C:\boot.bak')

#
# Creating Files and Folders
#

# Create a new folder 
New-Item -Path 'C:\temp\New Folder' -ItemType Directory

# Create a new empty file
New-Item -Path 'C:\temp\New Folder\file.txt' -ItemType File

#
# Removing All Files and Folders Within a Folder
#

# Remove a file
Remove-Item -Path C:\temp\DeleteMeFile.txt

# Remove directory
Remove-Item -Path C:\temp\DeleteMe -Recurse

#
# Mapping a Local Folder as a drive
#

# Create a local drive P: rooted in the local Program Files directory, visible only from the PowerShell session
New-PSDrive -Name P -Root $env:ProgramFiles -PSProvider FileSystem

#
# Reading a Text File into an Array
#

# Read an entire file in one step
Get-Content -Path C:\boot.ini

# Usage
$Computers = Get-Content -Path C:\temp\DomainMembers.txt
$Computers