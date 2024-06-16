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
