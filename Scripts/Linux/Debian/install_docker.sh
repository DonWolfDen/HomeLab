#!/bin/bash

apt update
apt install curl -y
curl -fsSL https://get.docker.com -o ~/scripts/get-docker.sh
sh get-docker.sh
