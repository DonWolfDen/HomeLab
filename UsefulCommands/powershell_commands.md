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
