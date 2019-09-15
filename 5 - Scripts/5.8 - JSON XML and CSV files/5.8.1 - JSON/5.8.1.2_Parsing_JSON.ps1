# EXAMPLE 1
$json = @"
{
"Stuffs": 
    [
        {
            "Name": "Darts",
            "Type": "Fun Stuff"
        },

        {
            "Name": "Clean Toilet",
            "Type": "Boring Stuff"
        }
    ]
}
"@

$x = $json | ConvertFrom-Json

$x | Select-Object 1

$x.Stuffs[0] # access to Darts
$x.Stuffs[1] # access to Clean Toilet
$darts = $x.Stuffs | Where-Object { $_.Name -eq "Darts" } #Darts

# EXAMPLE 2 (Linux)
$json = (Get-Content "/home/miso/Projects/PowerShell-Programming/5 - Scripts/5.8 - JSON XML and CSV files/5.8.1 - JSON/jsonfile.json" -Raw) | ConvertFrom-Json
$json.psobject.properties.name

# EXAMPLE 3
$json = @"
{"A": {"property1": "value1", "property2": "value2"}, "B": {"property1": "value3", "property2": "value4"}}
"@

$parsed = $json | ConvertFrom-Json
foreach ($line in $parsed | Get-Member) {
	Write-Host $parsed.$($line.Name).property1
	Write-Host $parsed.$($line.Name).property2
}
