# The elements that you see in Windows PowerShell drives, such as the files and folders in the file system drives, and 
# the registry keys in the Windows PowerShell registry drives, are called items in Windows PowerShell.

#
# Creating New Items (New-Item)
#

# Create a new directory named "New.Directory"in the C:\Temp directory, type:
New-Item -Path c:\temp\New.Directory -ItemType Directory

# Create a file named "file1.txt" in the New.Directory directory
New-Item -Path C:\temp\New.Directory\file1.txt -ItemType file

# Create a key named "_Test" in the CurrentVersion subkey
New-Item -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion_Test

#
# Renaming Existing Items (Rename-Item)
#

# Change the name of the file1.txt file to fileOne.txt
Rename-Item -Path C:\temp\New.Directory\file1.txt fileOne.txt

#
# Moving Items (Move-Item)
#

# Move the New.Directory directory from the C:\temp directory to the root of the C: drive (and verify with -PassThru parameter)
Move-Item -Path C:\temp\New.Directory -Destination C:\ -PassThru

#
# Copying Items (Copy-Item)
#

# Copy all of the contents (-Recurse) and overwrite files if they exist (-Force)
Copy-Item -Path C:\New.Directory -Destination C:\temp -Recurse -Force -Passthru

#
# Deleting Items (Remove-Item)
#

# Remove file
Remove-Item C:\temp\Filename.txt

# Delete folder
Remove-Item C:\temp\New.Directory -Recurse

#
# Executing Items (Invoke-Item)
#

# Windows PowerShell uses the Invoke-Item cmdlet to perform a default action for a file or folder.

# Open the Explorer window that is located in C:\Windows (default configuration)
Invoke-Item C:\WINDOWS

# Open boot.ini file in Notepad (default configuration)
Invoke-Item C:\boot.ini