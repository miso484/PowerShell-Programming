#
# Using Format-Wide for Single-Item Output
#

Get-Command -Verb Format | Format-Wide
Get-Command -Verb Format | Format-Wide -Property Noun
Get-Command -Verb Format | Format-Wide -Property Verb

# Controlling Format-Wide Display with Column
Get-Command -Verb Format | Format-Wide -Property Noun -Column 1

#
# Using Format-List for a List View
#

Get-Process -Name powershell | Format-List
Get-Process -Name powershell | Format-List -Property ProcessName,FileVersion,StartTime,Id

# Getting Detailed Information by Using Format-List with Wildcards
Get-Process -Name powershell | Format-List -Property *

#
# Using Format-Table for Tabular Output
#

Get-Process -Name powershell | Format-Table

# Improving Format-Table Output (AutoSize)
Get-Process -Name powershell | Format-Table -Property Company,Name,Id,Path -AutoSize

# Wrapping Format-Table Output in Columns (Wrap)
Get-Process -Name powershell | Format-Table -Wrap -Property Name,Id,Company,Path
Get-Process -Name powershell | Format-Table -Wrap -AutoSize -Property Name,Id,Company,Path

# Organizing Table Output (-GroupBy)
Get-Process -Name powershell | Format-Table -Wrap -AutoSize -Property Name,Id,Path -GroupBy Company