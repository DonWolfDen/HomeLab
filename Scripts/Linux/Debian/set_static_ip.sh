#!/bin/bash

# Declare variables

# Store currently active interface as a variable
iface=$(ip addr | awk '/state UP/ {print $2}' | tr -d :)
# Prompt the user for the new IP address
read -p "Enter the new IP address in CIDR (ex: 10.0.0.10/24): " ipaddr
# Prompt the user for the gateway address
read -p "Enter the gateway address: " gateway

# Replace the existing configuration for the primary network interface with the new static IP address, subnet mask, and gateway using sed
sed -i.bak '/# The primary network interface/,$d' /etc/network/interfaces

echo -e "\
# The primary network interface\n\
allow-hotplug $iface\n\
iface $iface inet static\n\
    address $ipaddr\n\
    gateway $gateway" \
>> /etc/network/interfaces

# Restart the network service to apply the new configuration
systemctl restart networking
