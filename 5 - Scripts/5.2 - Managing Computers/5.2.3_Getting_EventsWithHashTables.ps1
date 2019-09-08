# Inefficient to filter the Microsoft-Windows-Defrag logs
Get-EventLog -LogName Application | Where-Object Source -Match defrag
Get-WinEvent -LogName Application | Where-Object { $_.ProviderName -Match 'defrag' }

# Efficient to filter the Microsoft-Windows-Defrag logs
Get-WinEvent -FilterHashtable @{
    LogName='Application'
    ProviderName='*defrag'
 }

#
# Filtering by Keyword
#

 # Get list of available keywords names
 [System.Diagnostics.Eventing.Reader.StandardEventKeywords] | Get-Member -Static -MemberType Property

 # Check Keywords/Value mapping in 5.2.3_Getting_EventsWithHashTables.png file

 # Add Keywords filter writing value for EventLogClassic
 Get-WinEvent -FilterHashtable @{
    LogName='Application'
    ProviderName='.NET Runtime'
    Keywords=36028797018963968
 }

# Keywords static property value (optional)
$C = [System.Diagnostics.Eventing.Reader.StandardEventKeywords]::EventLogClassic
Get-WinEvent -FilterHashtable @{
   LogName='Application'
   ProviderName='.NET Runtime'
   Keywords=$C.Value__
}

#
# Filtering by Event Id
#

Get-WinEvent -FilterHashtable @{
    LogName='Application'
    ProviderName='.NET Runtime'
    Keywords=36028797018963968
    ID=1023
 }

#
# Filtering by Level
#

# Get Level info
[System.Diagnostics.Eventing.Reader.StandardEventLevel] | Get-Member -Static -MemberType Property

<#
 Name       	Value
 Verbose	    5
 Informational	4
 Warning	    3
 Error	        2
 Critical	    1
 LogAlways	    0
#>

# Filter by level
Get-WinEvent -FilterHashtable @{
   LogName='Application'
   ProviderName='.NET Runtime'
   Keywords=36028797018963968
   ID=1023
   Level=2
}

 # Level static property in enumeration (optional)
$C = [System.Diagnostics.Eventing.Reader.StandardEventLevel]::Informational
Get-WinEvent -FilterHashtable @{
   LogName='Application'
   ProviderName='.NET Runtime'
   Keywords=36028797018963968
   ID=1023
   Level=$C.Value__
}