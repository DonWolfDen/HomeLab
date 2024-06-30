# *A command line package manager for Windows Powershell*
https://github.com/chocolatey/choco
## Install Windows
## Install Chocolatey
Set powershell execution policy and install chocolatey
```powershell
Set-ExecutionPolicy AllSigned &&
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```
Install Apps
```
Choco Install GoogleChrome VLC NotepadPlusPlus Spotify Discord Steam 7zip Python3 Git AutoHotkey.Portable TreeSizeFree -y
```
