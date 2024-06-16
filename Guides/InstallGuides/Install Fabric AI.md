# Install Fabric AI

# [[Install Debian]]
# [[Install Docker]]
# [[Install Portainer]]
# [[Install Ollama]]
# Install Fabric AI
Install pre-requisite tools
```
sudo apt update && sudo apt upgrade -y && sudo apt install pipx git -y
```
Download installer
```
git clone https://github.com/danielmiessler/fabric.git ~/fabric
```
Install
```
pipx install ~/fabric
```
Prepare shell commands
```
cd ~/fabric && pipx ensurepath && source ~/.bashrc
```