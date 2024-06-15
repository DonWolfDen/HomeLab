' This is an Active Directory logon script to map 5 network drives. 
' Place this script in C:\Windows\SYSVOL\domain\scripts on a domain controller
' Active Directory Users & Computers > Select user > Profile tab > set "Logon.vbs" as logon script

Option Explicit
Dim objNetwork 
Dim strRemotePath, strRemotePath1, strRemotePath2, strRemotePath3, strRemotePath4
Dim strDriveLetter, strDriveLetter1, strDriveLetter2, strDriveLetter3, strDriveLetter4
strDriveLetter = "v:" 
strDriveLetter1 = "w:" 
strDriveLetter2 = "x:" 
strDriveLetter3 = "y:"
strDriveLetter4 = "z:"  

strRemotePath = "\\Server\ShareV" 
strRemotePath1 = "\\Server\ShareW"
strRemotePath2 = "\\Server\ShareX"
strRemotePath3 = "\\Server\ShareY"
strRemotePath4 = "\\Server\ShareZ"
 

Set objNetwork = WScript.CreateObject("WScript.Network") 

On Error Resume Next
objNetwork.RemoveNetworkDrive strDriveLetter 
objNetwork.RemoveNetworkDrive strDriveLetter1 
objNetwork.RemoveNetworkDrive strDriveLetter2
objNetwork.RemoveNetworkDrive strDriveLetter3
objNetwork.RemoveNetworkDrive strDriveLetter4
strUserName = objNetwork.UserName
objNetwork.MapNetworkDrive strDriveLetter, strRemotePath
objNetwork.MapNetworkDrive strDriveLetter1, strRemotePath1
objNetwork.MapNetworkDrive strDriveLetter2, strRemotePath2
objNetwork.MapNetworkDrive strDriveLetter3, strRemotePath3
objNetwork.MapNetworkDrive strDriveLetter4, strRemotePath4


WScript.Quit
