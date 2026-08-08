#!/bin/bash

# Set the input CSV file
CSV_FILE=$1

# Check if the input CSV file was provided
if [ -z "$CSV_FILE" ]; then
  echo "Error: no CSV file provided"
  exit 1
fi

# Loop through each row in the CSV file
while IFS=, read -r col1 col2; do
  # Strip carriage returns (\r) to handle Windows CSV formatting
  col2=$(echo "$col2" | tr -d '\r')

  # Skip empty lines
  [ -z "$col1" ] && continue

  # Create folder formatted as "Title (Year)" if year is present
  if [ -n "$col2" ]; then
    mkdir -p "${col1} (${col2})"
  else
    mkdir -p "${col1}"
  fi
done < "$CSV_FILE"

exit 0