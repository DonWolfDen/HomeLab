#!/bin/bash

# Loop through all subdirectories in the current directory
for dir in */; do
  # Loop through all files in the subdirectory
  for file in "$dir"*; do
    # Check if the file is a regular file (not a directory)
    if [[ -f "$file" ]]; then
      # Move the file to the current directory
      mv "$file" .
    fi
  done
done
