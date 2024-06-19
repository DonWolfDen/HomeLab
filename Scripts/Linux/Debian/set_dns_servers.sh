#!/bin/bash

# Declare variables
backup_file="/etc/resolv.conf.bak"
config_file="/etc/resolv.conf"

# Prompt the user for the domain name
read -p "Enter the local domain name (mydomain.local): " domain

# Prompt the user for the nameserver addresses
read -p "Enter the primary DNS server IP (1.1.1.1): " dns1
read -p "Enter the secondary DNS server IP (1.0.0.1): " dns2

# Create a .bak file of /etc/resolv.conf
cp $config_file $backup_file

# Replace the values in the existing /etc/resolv.conf with the new domain and server IPs
cat > $config_file <<EOF
domain $domain
search $domain
nameserver $dns1
nameserver $dns2
EOF
