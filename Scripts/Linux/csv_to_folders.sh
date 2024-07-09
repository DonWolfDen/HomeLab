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
  # Create a new folder for this row
  mkdir -p "${col1}"
done < "$CSV_FILE"

exit 0