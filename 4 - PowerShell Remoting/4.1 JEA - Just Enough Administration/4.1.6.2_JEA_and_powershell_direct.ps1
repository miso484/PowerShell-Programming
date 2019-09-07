# Hyper-V in Windows 10 and Windows Server 2016 offers PowerShell Direct, a feature that allows Hyper-V administrators to manage virtual machines 
# with PowerShell regardless of the network configuration or remote management settings on the virtual machine.

# Entering a JEA session using PowerShell Direct when the VM name is unique
Enter-PSSession -VMName 'SQL01' -ConfigurationName 'NICMaintenance' -Credential 'localhost\JEAformyHoster'

# Entering a JEA session using PowerShell Direct using VM ids
$vm = Get-VM -VMName 'MyVM' | Select-Object -First 1
Enter-PSSession -VMId $vm.VMId -ConfigurationName 'NICMaintenance' -Credential 'localhost\JEAformyHoster'