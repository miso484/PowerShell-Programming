#
# Get-Member
#

Get-Process | Get-Member | Out-Host -Paging
Get-Process | Get-Member -MemberType Properties
Get-Process | Get-Member -MemberType Methods