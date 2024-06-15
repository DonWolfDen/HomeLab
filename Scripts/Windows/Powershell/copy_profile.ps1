$PreviousUser = Read-Host "Enter the name of the previous profile"
$NewUser = Read-Host "Enter the name of the current profile"
Copy-Item -Path "C:\Users\$PreviousUser\Desktop\*" -Destination "C:\Users\$NewUser\Desktop" -Recurse -Force -Verbose
Copy-Item -Path "C:\Users\$PreviousUser\Downloads\*" -Destination "C:\Users\$NewUser\Downloads" -Recurse -Force -Verbose
Copy-Item -Path "C:\Users\$PreviousUser\Documents\*" -Destination "C:\Users\$NewUser\Documents" -Recurse -Force -Verbose
Copy-Item -Path "C:\Users\$PreviousUser\Pictures\*" -Destination "C:\Users\$NewUser\Pictures" -Recurse -Force -Verbose
Copy-Item -Path "C:\Users\$PreviousUser\Videos\*" -Destination "C:\Users\$NewUser\Videos" -Recurse -Force -Verbose
Copy-Item -Path "C:\Users\$PreviousUser\AppData\Local\Google\Chrome\User Data\*" -Destination "C:\Users\$NewUser\AppData\Local\Google\Chrome\User Data" -Recurse -Force -Verbose
