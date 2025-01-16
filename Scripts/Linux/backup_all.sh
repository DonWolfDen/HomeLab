#!/bin/bash

## Get the current date as variable.
time="$(date +%m-%d-%Y-%H-%M)"
## Set the source file path
source="/"
## Set the destination file path
destination="/mnt/backups/$HOSTNAME"
mkdir -p "$destination"

## Get the script name and host name as a string
filename="$(basename $0)-$HOSTNAME"

## Delete backup files matching naming scheme older than 2 weeks
find $destination -name "$filename-*" -mtime +14 -type f -delete

## Tar Section. Create a backup file using the destination, filename and time above
## --exclude some un-needed directories and virtual filesystems

tar -cvpzf "$destination/$filename-$time.tar.gz" \
--one-file-system \
--exclude=/home/*/.cache \
--exclude=/home/*/.local/share/Trash \
--exclude=/var/cache \
--exclude=/var/tmp \
--exclude=/var/log \
--exclude=/mnt \
"$source"
