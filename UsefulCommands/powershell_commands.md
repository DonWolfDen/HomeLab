# Useful Commands for Windows Powershell

## Check or Change Edition and Activate Windows and Office
```pwsh
irm https://get.activated.win | iex
# Uses an Open source script, use at your own risk
# https://MassGrave.dev
# https://github.com/massgravel/Microsoft-Activation-Scripts
```
## Get Drive Space
```pwsh
get-volume
```
## Hibernate - Disable
```pwsh
powercfg -h off
```
## Rename Computer 
```pwsh
Rename-Computer -NewName "MyPC-01"
```
<<<<<<< HEAD
=======
## Install Chocolatey CLI package manager
```pwsh
Set-ExecutionPolicy AllSigned &&
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```
## Print a Directory List
```pwsh
dir > filename.txt
cmd /r dir /b > filename.txt
```
>>>>>>> dbc20c7680153cdc40b18194f648591b7dec5943
