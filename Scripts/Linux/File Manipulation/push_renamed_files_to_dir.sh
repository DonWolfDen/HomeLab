#!/bin/bash

# Loop through all files in the directory and its subdirectories
for file in ./*; do
  # Check if it's a regular file (not a directory)
  if [ -f "$file" ]; then
    # Extract the filename without the path
    filename=$(basename "$file")

    # Remove everything after a closing parenthesis
    new_filename="${filename%%)*}"

    # Create a new subdirectory with the modified filename
    mkdir -p "./${new_filename})" || exit 1

    # Move the file into its own subfolder
    mv "$file" "./${new_filename})/$filename"
  fi
done
