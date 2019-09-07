# Powershell v5.0 or higher
$PSVersionTable.PSVersion

# Enable PowerShell Remoting
Enable-PSRemoting

# Enable PowerShell module and script block logging (optional)
##1. Open the Local Group Policy Editor on a workstation or a Group Policy Object in the Group Policy Management Console on an Active Directory Domain Controller
##2. Navigate to Computer Configuration\Administrative Templates\Windows Components\Windows PowerShell
##3. Double-click on Turn on Module Logging
##4. Click Enabled
##5. In the Options section, click on Show next to Module Names
##6. Type * in the pop-up window to log commands from all modules.
##7. Click OK to set the policy
##8. Double-click on Turn on PowerShell Script Block Logging
##9. Click Enabled
##10. Click OK to set the policy
##11. (On domain-joined machines only) Run gpupdate or wait for Group Policy to process the updated policy and apply the settings