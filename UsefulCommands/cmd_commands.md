# Useful Commands for Windows Command Line

## Add local user and add to admins
```bat
net user AdminLocal Password123! /add
net localgroup Administrators AdminLocal /add
```
## Disable local account
```bat
net user <username> /active:no
```
## Check if user password is valid
```bat
net use \\%COMPUTERNAME% /user:USERNAME PASSWORD
net use \\%COMPUTERNAME% /delete
```
## Set account password to not expire
```bat
WMIC USERACCOUNT WHERE Name='AdminLocal' SET PasswordExpires=FALSE
net user AdminLocal | findstr /C:expires
```
## Add Print Management Console
```bat
Dism /Online /Add-Capability /CapabilityName:Print.Management.Console~~~~0.0.1.0
```
## Get Last Boot Time
```bat
systeminfo | find “System Boot Time”
wmic path Win32_OperatingSystem get LastBootUpTime
```
## Get Windows Version
```bat
wmic os get Caption /value
winver
```
## Reboot PC
```bat
shutdown /f /r /t 0
```
## Reboot into BIOS
```bat
shutdown /f /r /t 0 /fw
```
## SFC and DISM System Repair Scan
```bat
sfc /scannow
DISM.exe /Online /Cleanup-Image /StartComponentCleanup
DISM.exe /Online /Cleanup-Image /RestoreHealth
```
## Chain system scans and restart
```bat
sfc /scannow && DISM.exe /Online /Cleanup-Image /StartComponentCleanup && DISM.exe /Online /Cleanup-Image /RestoreHealth && shutdown /f /r /t 0
```
## Run DISM repair offline with a downloaded image:
```bat
# Download latest Windows 11 ISO, double click it to mount it, then run this command.
# Change :D: to whatever drive letter it mounts to. wim:6 = Windows pro, change to 1 for home.
# You can use ```Dism /Get-WimInfo /WimFile:D:\sources\install.wim``` to verify version
Dism /Online /Cleanup-Image /RestoreHealth /Source:wim:D:\sources\install.wim:6 /LimitAccess
```
## Restart explorer
```bat
taskkill /f /im explorer.exe && start explorer.exe
```
## Save list of installed software
```bat
wmic /output:C:\TechFile\softwarelist.txt product get name,version
```
## Check if PC is Azure or Domain
```bat
dsregcmd /status 
```
## Check free disk space
```bat
fsutil volume diskfree c:
```
## Check memory specs
```bat
wmic memorychip get DeviceLocator, Capacity, Speed, MemoryType /format:list
```
## Check hard drive type
```bat
wmic diskdrive get Name,Model,SerialNumber,Size,Status,BusType /format:list
```
## Get battery report
```bat
powercfg /batteryreport
```
## Reset Windows Update Components
```bat
net stop bits  
net stop wuauserv  
net stop appidsvc  
net stop cryptsvc
Ren %systemroot%\SoftwareDistribution SoftwareDistribution.old
Ren %systemroot%\System32\catroot2 catroot2.old
net start bits  
net start wuauserv  
net start appidsvc  
net start cryptsvc
```
## Clean and reformat disk
```bat
diskpart
list disk
select disk #
clean
create partition primary
select partition 1
format FS=NTFS label="MyDrive" quick
assign letter k
```
## Recursively delete folder
```bat
del \path\to\folder /S /Q
rmdir \path\to\folder /S /Q
```
## Remove Windows Hello Pin
```bat
certutil -DeleteHelloContainer
```

# Registry Edits

## Disable Windows Hello
```bat
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PassportForWork" /v Enabled /t REG_DWORD /d 0
```
## Force Windows 10 right-click menu on Windows 11
```bat
REG ADD "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
```
## Force TCP on RDP when getting disconnects
```bat
reg add "HKLM\software\policies\microsoft\windows nt\Terminal Services\Client" /v fClientDisableUDP /d 1 /t REG_DWORD
```
## Shared mailboxes get unique deleted items folder
```bat
reg add "HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Outlook\Options\General" /v "DelegateWastebasketStyle" /t REG_DWORD /d 4 /f
```
## Allow EntraID join when getting MDM error
```bat
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\MDM" /v DisableRegistration /t REG_DWORD /d 1 /f
```
## Force Num-lock-on at Windows login screen
```bat
REG ADD "HKEY_USERS\.DEFAULT\Control Panel\Keyboard" /v "InitialKeyboardIndicators" /t REG_SZ /d "2147483650" /f
```
## Fix Outlook Autodiscover for on-prem exchange
```bat
reg add "HKCU\Software\Microsoft\Office\16.0\Outlook\AutoDiscover" /v "PreferLocalXML" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Office\16.0\Outlook\AutoDiscover" /v "ExcludeHttpRedirect" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Office\16.0\Outlook\AutoDiscover" /v "ExcludeHttpsAutodiscoverDomain" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Office\16.0\Outlook\AutoDiscover" /v "ExcludeHttpsRootDomain" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Office\16.0\Outlook\AutoDiscover" /v "ExcludeScpLookup" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Office\16.0\Outlook\AutoDiscover" /v "ExcludeSrvRecord" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Office\16.0\Outlook\AutoDiscover" /v "ExcludeExplicitO365Endpoint" /t REG_DWORD /d 1 /f
```
## Fix L2TP VPN
```bat
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\PolicyAgent" /v "AssumeUDPEncapsulationContextOnSendRule" /t REG_DWORD /d 2 /f
REG ADD HKLM\SYSTEM\CurrentControlSet\Services\RasMan\Parameters /v ProhibitIpSec /t REG_DWORD /d 0x0 /f
```
### Fix domain network profile switching to public on Domain controller
```bat
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NetLogon\Parameters" /v "NegativeCachePeriod" /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "MaxNegativeCacheTtl" /t REG_DWORD /d 0 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters" /v "AlwaysExpectDomainController" /t REG_DWORD /d 1 /f
```
