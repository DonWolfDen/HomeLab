#!/bin/bash

# Find empty directories and append to CSV
find . -type d -empty -print0 | while IFS= read -r -d '' dir; do
  echo "${dir#./}" >> empty_dir.csv
done
