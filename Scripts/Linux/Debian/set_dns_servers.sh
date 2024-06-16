#!/bin/bash

## WIP: THIS NEEDS TESTED AND FIXED

# Prompt the user for the domain name
read -p "Enter the local domain name: " domain

# Prompt the user for the primary DNS server IP
read -p "Enter the primary DNS server IP: " dns1
read -p "Enter the secondary DNS server IP (optional): " dns2

# Create a backup of the existing /etc/resolv.conf
sudo cp /etc/resolv.conf /etc/resolv.conf.bak

# Empty the existing /etc/resolv.conf
sudo echo "" > /etc/resolv.conf

# Add desired configuration to /etc/resolv.conf
sudo echo "search $domain" >> /etc/resolv.conf
sudo echo "nameserver $dns1" >> /etc/resolv.conf
[ -n "$dns2" ] && sudo echo "nameserver $dns2" >> /etc/resolv.conf

echo "Successfully updated DNS settings in /etc/resolv.conf (backup created: /etc/resolv.conf.bak)"