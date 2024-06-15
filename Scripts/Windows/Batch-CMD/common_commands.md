# Common Commands for Windows Command Line

## Add local user and add to admins
```
net user AdminLocal Password123! /add
net localgroup Administrators AdminLocal /add
```
## Disable local account
```
net user <username> /active:no
```
## Add Print Management Console
```
Dism /Online /Add-Capability /CapabilityName:Print.Management.Console~~~~0.0.1.0
```
## Get Last Boot Time
```
systeminfo | find “System Boot Time”
wmic path Win32_OperatingSystem get LastBootUpTime
```
## Get Windows Version
```
wmic os get Caption /value
winver
```
## Reboot PC
```
shutdown /f /r /t 0
```
## Reboot into BIOS
```
shutdown /f /r /t 0 /fw
```
## System Scan
```
sfc /scannow
DISM.exe /Online /Cleanup-Image /StartComponentCleanup
DISM.exe /Online /Cleanup-Image /RestoreHealth
```
### Chain system scans and restart
```
sfc /scannow && DISM.exe /Online /Cleanup-Image /StartComponentCleanup && DISM.exe /Online /Cleanup-Image /RestoreHealth && shutdown /f /r /t 0
```
## Restart explorer
```
taskkill /f /im explorer.exe && start explorer.exe
```
## Save list of installed software
```
wmic /output:C:\TechFile\softwarelist.txt product get name,version
```
## Check if PC is Azure or Domain
```
dsregcmd /status 
```
## Check free disk space
```
fsutil volume diskfree c:
```
## Check memory specs
```
wmic memorychip get DeviceLocator, Capacity, Speed, MemoryType /format:list
```
## Check hard drive type
```
wmic diskdrive get Name,Model,SerialNumber,Size,Status,BusType /format:list
```
## Get battery report
```
powercfg /batteryreport
```

# Registry Edits

## Windows Hello - Disable
```
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PassportForWork" /v Enabled /t REG_DWORD /d 0
```
## Force Windows 10 context menu on Windows 11
```
REG ADD "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
```
