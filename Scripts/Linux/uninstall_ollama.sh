#!/bin/bash

systemctl stop ollama
systemctl disable ollama
rm /etc/systemd/system/ollama.service
rm $(which ollama)
rm -r /usr/share/ollama
userdel ollama
groupdel ollama