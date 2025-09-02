#!/bin/bash

# Create a Debian 12 Proxmox container with static IP
# Run this script with wget -qO- https://raw.githubusercontent.com/DonWolfDen/HomeLab/refs/heads/main/Scripts/Linux/Debian/new_lxc_portainer_agent.sh | bash
# Open the main portainer gui and go to settings > environments > add > docker standalone > agent
# The docker command is included. Just enter a name and the static IP:9001
apt update
apt upgrade -y
apt install curl sudo -y
curl -fsSL https://get.docker.com -o ~/get-docker.sh
sh get-docker.sh
docker run -d -p 9001:9001 --name portainer_agent --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker/volumes:/var/lib/docker/volumes portainer/agent:2.33.1
