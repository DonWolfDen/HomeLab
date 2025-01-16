# Useful Commands for Debian Linux Shell

## Backup full system to mounted storage
```sh
tar -cvpzf mnt/Server/Backup/backup.tar.gz --one-file-system /
# Flags: Create, Verbose, Preserve permissions, Zip and File
# --one-file-system excludes symbolic directories like /mnt /proc /sys /d
```
## Extract directory from backup
```sh
tar -xvpzf /mnt/WolfLibrary/Backup/backup.tar.gz
```
## View sizes of all root directories
```sh
sudo du -sh /* --one-file-system
```
## Install Docker
```
curl -fsSL https://get.docker.com -o ~/scripts/get-docker.sh
sh get-docker.sh
```
## Update a Cloudflare Tunnel in Debian
```sh
curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && sudo dpkg -i cloudflared.deb 
```
Restart the service:
```sh
sudo systemctl restart cloudflared.service
```
## Change the Timezone
```sh
sudo timedatectl set-timezone America/Detroit
```
## Remove files matching one of multiple strings
```sh
find . -type f \( -iname "*.log" -o -iname "desktop.ini" -o -iname "thumbs.db" -o -iname "._*" \) -exec rm -v {} \;
```
## Remove all files that DON'T match one of multiple strings
```sh
find . -type f ! \( -iname "*.mp3" -o -iname "*.ogg" -o -iname "song.ini" -o -iname "*.wma" -o -iname "*.m4a" -o -iname "*.flac" -o -iname "*.wav" \) -exec rm -v {} \;
```
