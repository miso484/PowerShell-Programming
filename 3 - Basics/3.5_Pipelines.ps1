# The PowerShell pipeline
## Paging reduces CPU utilization because processing transfers to the Out-Host cmdlet when it has a complete page ready to display. 
Get-ChildItem -Path C:\WINDOWS\System32 | Out-Host -Paging         #Windows
Get-ChildItem -Path ~ | Out-Host -Paging                           #Linux

# Objects in the pipeline
Get-Location | Get-Member           #This returns PathInfo object
