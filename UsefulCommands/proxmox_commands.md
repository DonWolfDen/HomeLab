# Useful commands for Proxmox Linux Shell

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
```sh
pct resize $ctid rootfs 64G
```
## Kill container that wont stop
```sh
lxc-stop -n $ctid --kill
```
