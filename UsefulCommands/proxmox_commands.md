# Useful commands for Proxmox Linux Shell

## Proxmox Helper Scripts
https://tteck.github.io/Proxmox/#proxmox-ve-tools
```sh
# Post Install Repositories and Subscription Nag
bash -c "$(wget -qLO - https://github.com/tteck/Proxmox/raw/main/misc/post-pve-install.sh)"
# LXC Updater Every Sunday at Midnight
bash -c "$(wget -qLO - https://github.com/tteck/Proxmox/raw/main/misc/cron-update-lxcs.sh)"
# Processor Microcode Firmware Update
bash -c "$(wget -qLO - https://github.com/tteck/Proxmox/raw/main/misc/microcode.sh)"
# Host Backup
bash -c "$(wget -qLO - https://github.com/tteck/Proxmox/raw/main/misc/host-backup.sh)"

```
## Download container templates
```sh
pveam update
pveam available
# Copy file from available and specify drive to download to. Examples:
# pveam download storage linux-container_amd64.tar.gz
pveam download FileStorage ubuntu-22.04-standard_22.04-1_amd64.tar.zst
pveam download local debian-12-turnkey-nextcloud_18.0-1_amd64.tar.gz
pveam download SMBStorage debian-11-turnkey-openvpn_17.1-1_amd64.tar.gz
```
## Enable Free/Unstable update repositories
```nano /etc/apt/sources.list```
```sh
# Add this to the bottom
# not for production use 
deb http://download.proxmox.com/debian bookworm pve-no-subscription
```
## Disable Enterprise Subscription Updates
```nano /etc/apt/sources.list.d/pve-enterprise.list```
```sh
# Comment this out
# deb https://enterprise.proxmox.com/debian/pve bookworm pve-enterprise
```
## Remove subscription notice
```sh
sed -i.backup -z "s/res === null || res === undefined || \!res || res\n\t\t\t.data.status.toLowerCase() \!== 'active'/false/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js && systemctl restart pveproxy.service
```

## Disk passthrough
```sh
ls -l /dev/disk/by-id/
qm set $vmid -scsi[] /dev/disk/by-id/$diskIDfromAbove
qm set 1213 -scsi2 /dev/disk/by-id/ata-Hitachi_HDS723020FKF00_JKF47LB9J0U34G
```

## Add SMB share
```sh
pvesm add cifs $volume --server $serverIP --share $sharedname --username $username --password
pvesm add cifs ProxBackups --server 192.168.1.200 --share ProxBackups --username Administrator --password
```

## Remove node from cluster
```sh
pvecm nodes
pvecm delnode <nodename>
rm -r /etc/pve/nodes/<nodename>
```
## Fix greyed out node and no shell
```sh
ssh root@hostname
systemctl restart pvestatd
```
## Resize LXC boot disk
Increase
```sh
pct resize $ctid rootfs 64G
```

Decrease
```sh
# List containers
pct list
# Stop the container you want to resize
pct stop 420
# Find out it's path on the node
lvdisplay | grep "LV Path\|LV Size"
# Run a file system check
e2fsck -fy /dev/pve/vm-420-disk-0
# Resize the file system
resize2fs /dev/pve/vm-420-disk-0 10G
# Resize the local volume
lvreduce -L 10G /dev/pve/vm-420-disk-0
# Edit the container's conf file
nano /etc/pve/lxc/420.conf
# Update the following line accordingly
# FROM:
rootfs: local-lvm:vm-420-disk-0,size=20G
# TO:
rootfs: local-lvm:vm-420-disk-0,size=10G
# Start the container
pct start 420
# Enter and check the resize container disk
pct enter 420
df -h
```
## Kill container that wont stop
```sh
lxc-stop -n $ctid --kill
```
