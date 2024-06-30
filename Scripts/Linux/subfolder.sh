#!/bin/bash

# Set the directory path where your files are located
read -p "Enter path to create subfolders for each file: " source

# Loop through all files in the directory and its subdirectories
for file in "$source"/*; do
  # Check if it's a regular file (not a directory)
  if [ -f "$file" ]; then
    # Extract the filename without the path (fixed with --)
    filename=$(basename -- "$file")

    # Create a new subdirectory with the same name as the file (fixed with quotes)
    mkdir -p "${source}/${filename%.*}" || exit 1

    # Move the file into its own subfolder (fixed with quotes)
    mv "$file" "${source}/${filename%.*}/$filename"
  fi
done