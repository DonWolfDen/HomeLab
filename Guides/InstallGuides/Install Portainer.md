# Install Portainer

# Create Debian virtual machine
- tick qemu agent on
- 4 core 16gb ram
- 32gb VirtIO block 
- scsi single
- everything else default
## Set static IP and reboot network

```nano /etc/network/interfaces```

```
# The primary network interface
allow-hotplug ens18
iface ens18 inet static
    address 192.168.1.69/24
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

## Create Portainer container with persistent configuration ##

```sh
docker volume create portainer_data
```

```sh
docker run -d --restart=always \
  --name portainer \
  -p 8000:8000 -p 9443:9443 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  portainer/portainer-ce:latest
```
```sh
docker run -d --restart=always --name portainer -p 8000:8000 -p 9443:9443 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
```
## access the web gui ##

https://localhost:9443/



___