' This is a logon script to map 5 network drives. 
' Place this script in "C:\Windows\SYSVOL\domain\scripts" on a domain controller
' Active Directory Users & Computers > Select user > Profile tab > set "Logon.vbs" as logon script
' Or place this in "C:\Windows\System32\Repl\Import\Scripts" for a local account (you may need to create this folder path)
' Computer Management > Local users > Select user > Profile tab > set "Logon.vbs" as logon script

Option Explicit
Dim objNetwork 
Dim strRemotePath0, strRemotePath1, strRemotePath2, strRemotePath3, strRemotePath4
Dim strDriveLetter0, strDriveLetter1, strDriveLetter2, strDriveLetter3, strDriveLetter4
Dim persistent_option : persistent_option = True

strDriveLetter0 = "v:" 
strDriveLetter1 = "w:" 
strDriveLetter2 = "x:" 
strDriveLetter3 = "y:"
strDriveLetter4 = "z:"  

strRemotePath0 = "\\Server\ShareV" 
strRemotePath1 = "\\Server\ShareW"
strRemotePath2 = "\\Server\ShareX"
strRemotePath3 = "\\Server\ShareY"
strRemotePath4 = "\\Server\ShareZ"
 

Set objNetwork = WScript.CreateObject("WScript.Network") 
On Error Resume Next
objNetwork.RemoveNetworkDrive strDriveLetter0 
objNetwork.RemoveNetworkDrive strDriveLetter1
objNetwork.RemoveNetworkDrive strDriveLetter2
objNetwork.RemoveNetworkDrive strDriveLetter3
objNetwork.RemoveNetworkDrive strDriveLetter4
strUserName = objNetwork.UserName
objNetwork.MapNetworkDrive strDriveLetter0, strRemotePath0, persistent_option
objNetwork.MapNetworkDrive strDriveLetter1, strRemotePath1, persistent_option
objNetwork.MapNetworkDrive strDriveLetter2, strRemotePath2, persistent_option
objNetwork.MapNetworkDrive strDriveLetter3, strRemotePath3, persistent_option
objNetwork.MapNetworkDrive strDriveLetter4, strRemotePath4, persistent_option

WScript.Quit
