# Install Plex

# [[Install Debian]]
# [[Install Docker]]
# [[Install Portainer]]
# Install Plex
## [[Compose Plex]]

## create smb credentials file, secure it ##

```sh
echo -e "username=$SMBUSER\npassword=$SMBPASS" > ~/.smbcred' | sudo tee -a /etc/fstab &&
sudo chmod 600 ~/.smbcred' | sudo tee -a /etc/fstab
```

## mount network shared media folders ##

```sh
sudo mkdir /mnt/plex
echo '//$NASIP/$PLEXSHARE/ /mnt/plex cifs credentials=/home/$USER/.smbcred 0 0' | sudo tee -a /etc/fstab
```

```sh
sudo systemctl daemon-reload &&
sudo mount -a
```

