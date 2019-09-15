# this is where the XML sample file was saved:
$Path = "$env:temp\inventory.xml"
 
# load it into an XML object:
$xml = New-Object -TypeName XML
$xml.Load($Path)
# note: if your XML is malformed, you will get an exception here
# always make sure your node names do not contain spaces

<#  THIS IS WAY SLOWER APPROACH
# this is where the xml sample file was saved:
$Path = "$env:temp\inventory.xml"
 
# load it into an XML object:
[XML]$xml = Get-Content $Path
#>
 
# simply traverse the nodes and select the information you want:
$Xml.Machines.Machine | Select-Object -Property Name, IP