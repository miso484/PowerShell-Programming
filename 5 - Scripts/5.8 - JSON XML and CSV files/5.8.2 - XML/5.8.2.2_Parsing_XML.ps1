$doc = [xml]@'
<xml>
    <Section name="BackendStatus">
        <BEName BE="crust" Status="1" />
        <BEName BE="pizza" Status="1" />
        <BEName BE="pie" Status="1" />
        <BEName BE="bread" Status="1" />
        <BEName BE="Kulcha" Status="2" />
        <BEName BE="kulfi" Status="1" />
        <BEName BE="cheese" Status="1" />
    </Section>
</xml>
'@

# List all BEName itesm
$doc.xml.Section.BEName
# List all BEName itesm with status 1
$doc.xml.Section.BEName | ? { $_.Status -eq 1 }
# List all BEName itesm with status 1 and append BE string with " is delicious" string
$doc.xml.Section.BEName | ? { $_.Status -eq 1 } | % { $_.BE + " is delicious" }         #% is the same as foreach-object; ? is the same as where-object
# List all BEName that has even index
for($i=0; $i -lt ($doc.xml.Section.BEName).Length; $i++){
    if ($i%2 -eq 0){
        $doc.xml.Section.BEName[$i]
    }
}

# if you have xml file
#[xml]$cn = Get-Content config.xml
#$cn.xml.Section.BEName