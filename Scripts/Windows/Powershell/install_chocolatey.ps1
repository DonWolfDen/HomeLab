# This installs Chocolatey, a Powershell cli package manager for Windows
# Use Choco install [Application] or Choco search [Application]

Set-ExecutionPolicy AllSigned &&
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
