# Convert a date to XML
Get-Date | ConvertTo-Xml

# Convert processes to XML
ConvertTo-Xml -As "Document" -InputObject (Get-Process) -Depth 3
