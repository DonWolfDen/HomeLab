# *A stable and low overhead Linux distribution. The base of many distributions including Ubuntu and Proxmox. Good for servers due to it's package stability, compatibility and widespread use/support*
https://github.com/Debian
## Install Debian
Load an official Debian ISO image onto a USB with your favorite USB loader (Rufus, Balena Etcher, Ventoy) or load onto a hypervisor for virtualization.

Boot the installer and follow the install prompts. Most things can be left default but username/password.

Near the end you will be asked to select a desktop and additional services. For servers it's recommended to not install any desktop experience. Uncheck Desktop and Gnome. It's also recommended to check and install SSH server here so you can remote access the command line 

Remove installation media, reboot and log in as root
## Recommended packages and settings
Update packages, install sudo and curl and add your username for administrative privileges
```sh
apt update &&
apt upgrade -y &&
apt install -y sudo curl && 
adduser $username sudo
```
Set static IP and restart network service
```sh
cp /etc/network/interfaces /etc/network/interfaces.bak &&
nano /etc/network/interfaces
```
```sh
# The primary network interface
allow-hotplug ens18
iface ens18 inet static
    address 192.168.1.10/24
    gateway 192.168.1.1
```

Set DNS servers
```sh
cp /etc/resolv.conf /etc/resolv.conf.bak
nano /etc/resolv.conf
```
```sh
domain $domain
search $domain
nameserver $dns1
nameserver $dns2
```
Restart networking to apply changes

```systemctl restart networking```
