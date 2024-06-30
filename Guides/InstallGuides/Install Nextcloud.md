# *A fully featured cloud collaboration and document sharing platform*
https://github.com/Nextcloud
## Install Proxmox
Download Nextcloud Turnkey container
```sh
pveam download local debian-12-turnkey-nextcloud_18.0-1_amd64.tar.gz
```
Create ZFS pool in Proxmox gui

Create user directories
```sh
zfs list
zpool list

zfs create $zfspool/nextcloud &&
zfs create $zfspool/nextcloud/admin &&
zfs create $zfspool/nextcloud/$user1 &&
zfs create $zfspool/nextcloud/$user2
```
## Install Cloudflared
## Install Nextcloud

Create Nextcloud turnkey container
- uncheck "unprivledged" so the container is privledged
- 16gb disk, 2 core, 1gb ram minimum
- options > edit features > check nesting enabled

Boot and follow install prompts
- Leave Defaults
- Set domain name to be used in Cloudflared tunnel

Update packages

```sudo apt update && sudo apt upgrade -y```

Set static IP and restart networking

```nano /etc/network/interfaces```

```
# The primary network interface
allow-hotplug ens18
iface ens18 inet static
        address 192.168.1.10/24
        gateway 192.168.1.1
```

```systemctl restart networking```


Set trusted domains in Nextcloud

```nano /var/www/nextcloud/config/config.php```

```
    array (
	0 => 'localhost',
1 => 'nextcloud.domain.com',
2 => '192.168.1.10',
    ),
```
Access gui via internal IP or domain and create users

Delete all files of any users that logged in then shutdown
```sh
cd /var/www/nextcloud-data/$user1/files
rm -rf ./*

shutdown now
```
Create ZFS mountpoints in Proxmox shell

```nano /etc/pve/lxc/$CONTAINERID.conf```

```
mp0: /$zfspool/nextcloud/admin,mp=/var/www/nextcloud-data/admin/files
mp1: /$zfspool/nextcloud/$user1,mp=/var/www/nextcloud-data/$user1/files
mp2: /$zfspool/nextcloud/$USERS,mp=/var/www/nextcloud-data/$user2/files
```
Boot Nextcloud and set mountpoint permissions
```sh
chown -R www-data:www-data /var/www/nextcloud-data/admin/files &&
chown -R www-data:www-data /var/www/nextcloud-data/$USER1/files &&
chown -R www-data:www-data /var/www/nextcloud-data/$user2/files
```
