#
# CREATING XML FILE
#

# this is where the document will be saved:
$Path = "$env:temp\inventory.xml"
 
# get an XMLTextWriter to create the XML
$XmlWriter = New-Object System.XMl.XmlTextWriter($Path,$Null)
 
# choose a pretty formatting:
$xmlWriter.Formatting = 'Indented'
$xmlWriter.Indentation = 1
$XmlWriter.IndentChar = "`t"
 
# write the header
$xmlWriter.WriteStartDocument()
 
# set XSL statements
$xmlWriter.WriteProcessingInstruction("xml-stylesheet", "type='text/xsl' href='style.xsl'")
 
# create root element "machines" and add some attributes to it
$XmlWriter.WriteComment('List of machines')
$xmlWriter.WriteStartElement('Machines')
$XmlWriter.WriteAttributeString('current', $true)
$XmlWriter.WriteAttributeString('manager', 'Tobias')
 
# add a couple of random entries
for($x=1; $x -le 10; $x++)
{
    $server = 'Server{0:0000}' -f $x
    $ip = '{0}.{1}.{2}.{3}' -f  (0..256 | Get-Random -Count 4)
 
    $guid = [System.GUID]::NewGuid().ToString()
 
    # each data set is called "machine", add a random attribute to it:
    $XmlWriter.WriteComment("$x. machine details")
    $xmlWriter.WriteStartElement('Machine')
    $XmlWriter.WriteAttributeString('test', (Get-Random))
 
    # add three pieces of information:
    $xmlWriter.WriteElementString('Name',$server)
    $xmlWriter.WriteElementString('IP',$ip)
    $xmlWriter.WriteElementString('GUID',$guid)
 
    # add a node with attributes and content:
    $XmlWriter.WriteStartElement('Information')
    $XmlWriter.WriteAttributeString('info1', 'some info')
    $XmlWriter.WriteAttributeString('info2', 'more info')
    $XmlWriter.WriteRaw('RawContent')
    $xmlWriter.WriteEndElement()
 
    # add a node with CDATA section:
    $XmlWriter.WriteStartElement('CodeSegment')
    $XmlWriter.WriteAttributeString('info3', 'another attribute')
    $XmlWriter.WriteCData('this is untouched code and can contain special characters /\@<>')
    $xmlWriter.WriteEndElement()
 
    # close the "machine" node:
    $xmlWriter.WriteEndElement()
}
 
# close the "machines" node:
$xmlWriter.WriteEndElement()
 
# finalize the document:
$xmlWriter.WriteEndDocument()
$xmlWriter.Flush()
$xmlWriter.Close()
 
#notepad $path
#nano $path

#
# GETTING INFO FROM XML FILE
#

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

#
# PICKING PARTICULAR INSTANCES
#

$Xml.Machines.Machine |
Where-Object { $_.Name -eq 'Server0009' } |
Select-Object -Property IP, {$_.Information.info1}

<# THIS IS WAY SLOWER APPROACH
$item = Select-XML -Xml $xml -XPath '//Machine[Name="Server0009"]'
$item.Node | Select-Object -Property IP, {$_.Information.Info1}
#>

$info1 = @{Name='AdditionalInfo'; Expression={$_.Information.Info1}}
$item = Select-XML -Xml $xml -XPath '//Machine[Name="Server0009"]'
$item.Node | Select-Object -Property IP, $info1

#
# CHANGING XML CONTEXT (UPDATE)
#

$item = Select-XML -Xml $xml -XPath '//Machine[Name="Server0006"]'
$item.node.Name = "NewServer0006"
$item.node.IP = "10.10.10.12"
$item.node.Information.Info1 = 'new attribute info'
 
$NewPath = "$env:temp\inventory2.xml"
$xml.Save($NewPath)
notepad $NewPath

## Make bulk adjustments
Foreach ($item in (Select-XML -Xml $xml -XPath '//Machine'))
{
    $item.node.Name = 'Prod_' + $item.node.Name
}
 
$NewPath = "$env:temp\inventory2.xml"
$xml.Save($NewPath)
#notepad $NewPath
#nano $NewPath

## Replace “ServerXXXX” with “PCXX” 
foreach($item in (Select-XML -Xml $xml -XPath '//Machine'))
{
    if ($item.node.Name -match 'Server(\d{4})')
    {
      $item.node.Name = 'PC{0:00}' -f [Int]$matches[1]
    }
}
$NewPath = "$env:temp\inventory2.xml"
$xml.Save($NewPath)
notepad $NewPath

#
# ADDING NEW DATA
#

# clone an existing node structure
$item = Select-XML -Xml $xml -XPath '//Machine[1]'
$newnode = $item.Node.CloneNode($true)
 
# update the information as needed
# all other information is defaulted to the values from the original node
$newnode.Name = 'NewServer'
$newnode.IP = '1.2.3.4'
 
# get the node you want the new node to be appended to:
$machines = Select-XML -Xml $xml -XPath '//Machines'
$machines.Node.AppendChild($newnode)
 
$NewPath = "$env:temp\inventory2.xml"
$xml.Save($NewPath)
#notepad $NewPath
#nano $NewPath

# add it to the top of the list:
$machines.Node.InsertBefore($newnode, $item.node)

# add it after "Server0007":
$parent = Select-XML -Xml $xml -XPath '//Machine[Name="Server0007"]'
$machines.Node.InsertAfter($newnode, $parent.node)

#
# REMOVING XML CONTEXT
#

# remove "Server0007":
$item = Select-XML -Xml $xml -XPath '//Machine[Name="Server0007"]'
$null = $item.Node.ParentNode.RemoveChild($item.node)
