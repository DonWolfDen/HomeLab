#!/bin/bash

# Find all directories and append to CSV
find . -type d -print0 | while IFS= read -r -d '' dir; do
  echo "${dir#./}" >> all_dir.csv
done
