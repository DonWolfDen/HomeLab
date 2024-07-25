# *A platform to stream and share downloaded movies, music and TV to any device*
https://github.com/plexinc
## Install Debian
### Privileged Container or Virtual Machine

This is easier but defeats the security and isolation that containers provide
- Make it privileged when creating, then go to options > features > enable nesting and CIFS
- Mount the network shared library in the container's shell

Create smb credentials file and secure it
```sh
echo -e "username=$smbusername\npassword=$smbpassword" > /root/.smbcred &&
chmod 600 /root/.smbcred
```

Mount network shared media folders
```sh
mkdir /mnt/plex &&
echo '//$serverIP/$plexLibrary/ /mnt/plex cifs credentials=/root/.smbcred 0 0' | tee -a /etc/fstab &&
systemctl daemon-reload &&
mount -a
```

### Unprivileged Container with SMB/CIFS

Map the network drive with fstab the same as above, but do it in the Proxmox host shell
- Proxmox maps the Root user to uid/gid 100000 within containers so this needs to be specified in the fstab entry for read write permissions
```sh
//$serverIP/PlexLibrary/ /mnt/plex cifs credentials=/root/.smbcred,uid=100000,gid=100000 0 0
```

Map the share in the container config file in the Proxmox shell

```nano /etc/pve/lxc/$ctid.conf```
```sh
# Add this to the end of the file
# You can make this mount read only by adding ',ro=1' to the end
mp0: /mnt/pve/$name,mp=/mnt/plex
```
### Optional: Pass a GPU into the container
Credit: 
https://github.com/JamesTurland/JimsGarage/blob/main/LXC/Jellyfin/readme.md

With this method, multiple containers can access the same GPU

All of this in the Proxmox shell:

Find Device Numbers for renderD###
- integrated graphics are typically renderD128
- graphics cards are typically renderD129 and up
```sh
ls -l /dev/dri
```
Find Group Numbers for video and render
```sh
cat /etc/group
```
Add Group Numbers Values to subgid

```nano /etc/subgid```
```sh
# Make sure these match video and render groups found above
root:44:1
root:104:1
```
Edit container .conf In /etc/pve/lxc

```nano /etc/pve/lxc/$ctid.conf```
```sh
# add all of this to the bottom under 'unprivileged: 1'
# make sure renderD### matches device number found above
lxc.cgroup2.devices.allow: c 226:0 rwm
lxc.cgroup2.devices.allow: c 226:128 rwm
lxc.mount.entry: /dev/dri/renderD128 dev/dri/renderD128 none bind,optional,create=file
lxc.idmap: u 0 100000 65536
lxc.idmap: g 0 100000 44
lxc.idmap: g 44 44 1
lxc.idmap: g 45 100045 62
lxc.idmap: g 107 104 1
lxc.idmap: g 108 100108 65428
```

Add Root to groups
```sh
usermod -aG render,video root
```
### Optional: Add tunnel device for VPN
This is needed if you're going to run a Gluetun docker container for VPN

```nano /etc/pve/lxc/$ctid.conf```
```sh
# Add this to the bottom of the file
lxc.cgroup2.devices.allow: c 10:200 rwm
lxc.mount.entry: /dev/net dev/net none bind,create=dir
lxc.mount.entry: /dev/net/tun dev/net/tun none bind,create=file
```

## Install Docker
## Install Portainer
## Compose Plex
Add environment variables
- PLEX_CLAIM='claim code from plex.tv/claim'
