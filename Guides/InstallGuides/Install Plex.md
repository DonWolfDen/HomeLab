# *A platform to stream and share downloaded movies, music and TV to any device*
https://github.com/plexinc
## Install Debian
## Install Docker
## Install Portainer
## Install Plex
Create smb credentials file and secure it
```sh
echo -e "username=$smbusername\npassword=$smbpassword" > ~/.smbcred &&
sudo chmod 600 ~/.smbcred
```
Mount network shared media folders
```sh
sudo mkdir /mnt/plex &&
echo '//$serverIP/$plexLibrary/ /mnt/plex cifs credentials=/home/$USER/.smbcred 0 0' | sudo tee -a /etc/fstab &&
sudo systemctl daemon-reload &&
sudo mount -a
```
## Compose Plex
Add environment variables
- PLEX_CLAIM=$claim # plex.tv/claim
