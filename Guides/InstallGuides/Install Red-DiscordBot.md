# *A fully featured and modular discord bot*
https://github.com/Cog-Creators/Red-DiscordBot
## Install Debian

## Install Prerequisites
```sh
sudo apt update &&
sudo apt upgrade -y &&
sudo apt -y install python3 python3-dev python3-venv git openjdk-17-jre-headless build-essential nano
```
## Install Red-DiscordBot
Create and enter virtual python environment
```sh
python3.11 -m venv ~/redenv &&
source ~/redenv/bin/activate
```
Install bot
```sh
python -m pip install -U pip wheel &&
python -m pip install -U Red-DiscordBot
```
Name your bot and run setup
```sh
redbot-setup
redbot <name>
```
Create a bot on discord

https://docs.discord.red/en/stable/bot_application_guide.html

## Set up Bot to automatically restart

Get username and path
```sh
whoami
source ~/redenv/bin/activate
/usr/bin/which python
```
Create service file
```sh
sudo nano /etc/systemd/system/red@.service
# Paste the following in the file, and replace all instances of $username with the Linux username you retrieved above, and $path with the python path you retrieved above.

[Unit]
Description=%I redbot
After=multi-user.target
After=network-online.target
Wants=network-online.target

[Service]
ExecStart=$path -O -m redbot %I --no-prompt
User=$username
Group=$username
Type=idle
Restart=on-abnormal
RestartSec=15
RestartForceExitStatus=1
RestartForceExitStatus=26
TimeoutStopSec=10

[Install]
WantedBy=multi-user.target
```
Start and enable service
```sh
sudo systemctl start red@instancename
sudo systemctl enable red@instancename
```
