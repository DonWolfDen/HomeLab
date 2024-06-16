# Install Rancher

# Create Debian virtual machine
- tick qemu agent on
- 4 core 16gb ram
- 64gb VirtIO block 
- scsi single
- everything else default
## Set static IP and reboot network

```nano /etc/network/interfaces```

```
# The primary network interface
allow-hotplug ens18
iface ens18 inet static
        address $IPADDRESS/24
        gateway 192.168.1.1
```

```systemctl restart networking```


## Update and install required packages

```sh
apt update && apt upgrade -y && 
apt install -y sudo curl cifs-utils && 
adduser $USER sudo
```

### BACKUP HERE 

## Install docker and make it not require sudo password

```sh
sudo curl https://releases.rancher.com/install-docker/24.0.sh | sh &&
sudo usermod -aG docker $USER
```

## Reconnect to apply settings, SSH for copy+paste

```ssh $USER@$IPADDRESS```


## set required networking options and apply ##

```sh
sudo nano /etc/sysctl.conf
```

```
net.bridge.bridge-nf-call-iptables=1
```

```sh
sudo modprobe br_netfilter &&
sudo sysctl -p
```


## Create Rancher container with persistent configuration ##

```sh
docker run -d --restart=unless-stopped \
  -p 80:80 -p 443:443 \
  -v /opt/rancher:/var/lib/rancher \
  --privileged \
  rancher/rancher:latest
```

## Grab the container ID from Rancher, use it to pull the temporary password ##

```sh
docker ps
```

- container ID will be something like this: 9418f454dd90
- copy it and replace $CONTAINERID

```sh
docker logs $CONTAINERID 2>&1 | grep "Bootstrap Password:"
```


## Access the web gui and enter the bootstrap password from above ##

https://localhost:443/

- Change your password and set your access ip. usually default
- wait for 'local' cluster to be in active state then create new cluster with all default values
- spin up docker images in the new cluster, not local

## Create smb credentials file, secure it and create media directories for plex ##

```sh
cd &&
mkdir plex &&
mkdir plex/music &&
mkdir plex/movies &&
mkdir plex/shows &&
echo -e "username=$SMBUSER\npassword=$SMBPASS" > ~/.smbcred &&
sudo chmod 600 ~/.smbcred
```



## mount network shared media folders ##

```sh
sudo nano /etc/fstab
```

```
//$SERVERIP/$SHAREDFOLDER/Music /home/$USER/plex/music cifs credentials=/home/$USER/.smbcredentials 0 0
//$SERVERIP/$SHAREDFOLDER/Movies /home/$USER/plex/movies cifs credentials=/home/$USER/.smbcredentials 0 0
//$SERVERIP/$SHAREDFOLDER/Shows /home/$USER/plex/shows cifs credentials=/home/$USER/.smbcredentials 0 0
```

```sh
sudo systemctl daemon-reload &&
sudo mount -a
```

## Connect to Rancher GUI and spin up plex deployment
- use values and environment variables from linuxserver.io
- bind your 3 media folders to the container

