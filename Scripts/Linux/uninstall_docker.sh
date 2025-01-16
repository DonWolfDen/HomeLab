#!/bin/bash

sudo apt purge *docker*
sudo apt purge -y docker-engine docker docker.io docker-ce docker-ce-cli docker-compose-plugin
sudo apt autoremove -y --purge docker-engine docker docker.io docker-ce docker-compose-plugin
sudo rm -rf /var/lib/docker /etc/docker
sudo rm /etc/apparmor.d/docker
sudo groupdel docker
sudo rm -rf /var/run/docker.sock
sudo rm -rf /var/lib/containerd
sudo rm -rf ~/.docker
sudo rm -rf /usr/local/bin/docker*
