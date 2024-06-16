# Install Chocolatey

## Administrative PowerShell

### Install Chocolatey
```powershell
Set-ExecutionPolicy AllSigned &&
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```
## Apps
```Choco Install GoogleChrome AdobeReader VLC Office365Business NotepadPlusPlus Paint.Net Spotify Discord Steam ChatGPT -y```
## Plug-ins and Framework
```Choco Install 7zip Python3 JRE8 Git FlashPlayerPlugin -y```
## Utilities
```Choco Install CCleaner AutoHotkey.Portable TreeSizeFree -y```
