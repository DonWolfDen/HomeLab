## Download ISO and create bootable USB
## Boot USB into installer
## Install Windows and reboot, remove USB
## Bypass internet requirement for Out-of-Box-Experience
When loaded in to the OOBE, hit Shift+F10 to bring up a command window and enter:
```
oobe\bypassnro
```
The system will reboot. Follow the normal set up without internet.
If Microsoft promts for an email, put in no@thankyou.com or email@email.com and a random password
This should give an error and let you bypass in favor of a local account (only if the above command was run)
