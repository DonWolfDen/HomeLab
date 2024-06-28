# Install Nextcloud

### Create ZFS pool in proxmox
$TANK = name of zfs pool

### Create user directories
```sh
zfs list
zpool list
zfs create $TANK/nextcloud &&
zfs create $TANK/nextcloud/admin &&
zfs create $TANK/nextcloud/$USER1 &&
zfs create $TANK/nextcloud/$USER2
```

### Create Cloudflare Tunnels
- Debian standard container
- 8gb disk, 1 core, 512mb ram

### Install Cloudflare tunnel in container
```sh
apt update && apt upgrade -y && apt install -y sudo curl &&

curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && 

sudo dpkg -i cloudflared.deb
```

Create tunnel and copy service install code
```sh
sudo cloudflared service install #RANDOMLY-GENERATED-CODE
```
### Create public hostname for Nextcloud
- Enter desired $IPADDRESS for Nextcloud container
- Skip tls verification

### Create Nextcloud turnkey container
- uncheck "unprivledged" so the container is privledged
- 16gb disk, 2 core, 1gb ram
- edit features, check nesting enabled
### Follow install prompts
- Defaults
- Set domain to Cloudtunnel domain

### Set static IP to cloudtunnel and reboot network

```nano /etc/network/interfaces```

```
# The primary network interface
allow-hotplug ens18
iface ens18 inet static
        address $IPADDRESS # 192.168.1.10/24
        gateway $GATEWAY # 192.168.1.1
```

```systemctl restart networking```


## Set trusted domains in nextcloud ##

```nano /var/www/nextcloud/config/config.php```

```
    array (
	0 => 'localhost',
1 => 'nextcloud.domain.com',
2 => '$IPADDRESS',
    ),
```

## Access gui via internal IP or Cloud tunnel
- Create new $USERS
## Delete all files of any users that logged in

## make sure no users have files
```sh
cd /var/www/nextcloud-data/$USER/files
la -l

shutdown now
```

PROXMOX SHELL

```nano /etc/pve/lxc/$CONTAINERID.conf```

```
mp0: /$TANK/nextcloud/admin,mp=/var/www/nextcloud-data/admin/files
mp1: /$TANK/nextcloud/$USERS,mp=/var/www/nextcloud-data/$USERS/files
mp2: /$TANK/nextcloud/$USERS,mp=/var/www/nextcloud-data/$USERS/files
```

NEXTCLOUD SHELL

```sh
chown -R www-data:www-data /var/www/nextcloud-data/admin/files &&
chown -R www-data:www-data /var/www/nextcloud-data/$USER1/files &&
chown -R www-data:www-data /var/www/nextcloud-data/$USER2/files
```

___