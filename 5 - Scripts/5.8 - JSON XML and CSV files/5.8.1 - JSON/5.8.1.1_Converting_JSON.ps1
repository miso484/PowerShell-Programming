# EXAMPLE: Convert a DateTime object to a JSON object
Get-Date | Select-Object -Property * | ConvertTo-Json | ConvertFrom-Json

# EXAMPLE: Get JSON strings from a web service and convert them to PowerShell objects
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12         # Ensures that Invoke-WebRequest uses TLS 1.2
$j = Invoke-WebRequest 'https://api.github.com/repos/PowerShell/PowerShell/issues' | ConvertFrom-Json

# EXAMPLE: Convert a JSON string to a custom object
Get-Content JsonFile.JSON | ConvertFrom-Json

# EXAMPLE: Convert a JSON string to a hash table
'{ "key":"value1", "Key":"value2" }' | ConvertFrom-Json -AsHashtable

# EXAMPLE: Perform an artist web lookup and return a description, name, and country of origin (in addition to other stuff) about the artist.
$request = 'http://musicbrainz.org/ws/2/artist/5b11f4ce-a62d-471e-81fc-a69a8278c7da?inc=aliases&fmt=json'

Invoke-WebRequest $request |
ConvertFrom-Json |
Select-Object name, disambiguation, country

# EXAMPLE: Find specific information about recordings by querying the Recording interface. Because the properties about the recording I am interested in are stored in 
# the Releases property as embedded objects, I need to expand that property, and then choose what I want from the embedded object.
$request = 'http://musicbrainz.org/ws/2/recording/fcbcdc39-8851-4efc-a02a-ab0e13be224f?inc=artist-credits+isrcs+releases&fmt=json'

Invoke-WebRequest $request |
ConvertFrom-Json  |
Select-Object -expand releases |
Select-Object title, date, country