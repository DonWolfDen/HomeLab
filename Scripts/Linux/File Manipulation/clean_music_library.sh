#!/bin/bash
# UNTESTED NEEDS WORK

# Flag to indicate delete mode and empty directory mode
delete_mode=false
empty_mode=false

# Functions
delete_non_audio () {
    echo "Deleting non-audio files..."
    find . -type f ! \( -iname "*.mp3" -o -iname "*.ogg" -o -iname "song.ini" -o -iname "*.wma" -o -iname "*.m4a" -o -iname "*.flac" -o -iname "*.wav" \) -exec rm -v {} \;
}
print_non_audio () {
    echo "Finding non-audio files..."
    find . -type f ! \( -iname "*.mp3" -o -iname "*.ogg" -o -iname "song.ini" -o -iname "*.wma" -o -iname "*.m4a" -o -iname "*.flac" -o -iname "*.wav" \) -print
}
print_total_files () {
    echo "Total files to delete: "
    find . -type f ! \( -iname "*.mp3" -o -iname "*.ogg" -o -iname "song.ini" -o -iname "*.wma" -o -iname "*.m4a" -o -iname "*.flac" -o -iname "*.wav" \) | wc -l
}

# Check for -delete option
if [[ $1 == "-delete" || $1 == "-d" || $2 == "-delete" || $2 == "-d" ]]; then
  delete_mode=true
fi

if [[ $1 == "-empty" || $1 == "-e" || $2 == "-e" || $2 == "-e" ]]; then
  empty_mode=true
fi

# Find all non audio files, and non song.ini files
# Print or remove files based on delete_mode
if [[ $delete_mode == true ]]; then
  echo "Deleting non-audio files..."
  delete_non_audio()
  if [[ $empty_mode == true ]]; then
    echo "Removing empty directories..."
    find -empty -type d -delete
  fi
else
  echo "Finding non-audio files..."
  print_non_audio()
  print_total_files()
  if [[ $empty_mode == true ]]; then
    echo "Finding empty directories..."
    find -empty -type d -print
  fi
fi

while getopts u:a:f: flag
do
    case "${flag}" in
        u) username=${OPTARG};;
        a) age=${OPTARG};;
        f) fullname=${OPTARG};;
    esac
done
