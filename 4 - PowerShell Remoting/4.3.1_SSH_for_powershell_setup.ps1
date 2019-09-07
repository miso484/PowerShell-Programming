# Set up on Windows machine

## 0. Install the latest version of PowerShell Core for Windows
## 1. Check if PowerShell already supports OS
Get-Command New-PSSession -syntax       #It shoud output [-KeyFilePath <string>] and [-SSHTransport] [<CommonParameters>]
## 2. Install the latest Win32 OpenSSH
## 3. Edit the sshd_config file located at $env:ProgramData\ssh.
##    Make sure password authentication is enabled
##    PasswordAuthentication yes
##    Subsystem    powershell c:/program files/powershell/6/pwsh.exe -sshs -NoLogo -NoProfile
##    PubkeyAuthentication yes
      ## There is a bug in OpenSSH for Windows that prevents spaces from working in subsystem executable paths. For more information, see this GitHub issue.
## 4. Restart the sshd service
Restart-Service sshd
## 5. Add the path where OpenSSH is installed to your Path environment variable.


# Set up on Linux (Ubuntu 16.04) Machine

## 1. Install the latest PowerShell Core for Linux build from GitHub
## 2. Install Ubuntu SSH as needed
sudo apt install openssh-client
sudo apt install openssh-server
## 3. Edit the sshd_config file at location /etc/ssh
##    PasswordAuthentication yes
##    Subsystem powershell /usr/bin/pwsh -sshs -NoLogo -NoProfile
##    PubkeyAuthentication yes
## 4. Restart the sshd service
sudo service sshd restart
