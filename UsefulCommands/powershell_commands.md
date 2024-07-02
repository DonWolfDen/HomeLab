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
## Print a Directory List
```pwsh
dir > filename.txt
cmd /r dir /b > filename.txt
```

## Manually install updates from PowerShell
    Open Powershell as Administrator and enter this command;
```pwsh
Install-Module PSWindowsUpdate
```
    Type 'A' to accept and install all modules. Then enter this command to check for Windows updates;
```pwsh
Get-WindowsUpdate
```
This command will give you a list of updates and their KB number
```pwsh
Install-WindowsUpdate -KBArticleID $KBNUMBER
```
Type 'A' to confirm the installation

(Optional) Type the following to view a list of previously installed updates
```pwsh
Get-WUHistory
```

## The Ultimate Windows Utility
```pwsh
iwr -useb https://christitus.com/win | iex
```