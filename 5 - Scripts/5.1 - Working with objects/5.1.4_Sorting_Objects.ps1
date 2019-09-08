#
# Sort-Object
#

# Sort by LastWriteTime and then by Name
Get-ChildItem |
  Sort-Object -Property LastWriteTime, Name |
  Format-Table -Property LastWriteTime, Name

# Sort the objects in reverse order
Get-ChildItem |
  Sort-Object -Property LastWriteTime, Name -Descending |
  Format-Table -Property LastWriteTime, Name

# Sort objects in descending LastWriteTime order and ascending Name order
Get-ChildItem |
  Sort-Object -Property @{ Expression = 'LastWriteTime'; Descending = $true }, @{ Expression = 'Name'; Ascending = $true } |
  Format-Table -Property LastWriteTime, Name

## Use aliases
gci | sort @{ e = 'LastWriteTime'; d = $true }, @{ e = 'Name'; a = $true } | ft LastWriteTime, Name

## Use hash table to improve readability   
  $order = @(
    @{ Expression = 'LastWriteTime'; Descending = $true }
    @{ Expression = 'Name'; Ascending = $true }
  )
  Get-ChildItem |
    Sort-Object $order |
    Format-Table LastWriteTime, Name

# Sort objects in descending order by the time span between CreationTime and LastWriteTime
Get-ChildItem |
  Sort-Object -Property @{ Expression = { $_.LastWriteTime - $_.CreationTime }; Descending = $true } |
  Format-Table -Property LastWriteTime, CreationTime

