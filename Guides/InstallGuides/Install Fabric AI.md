# *A prompting framework to improve results from AI large language models*
https://github.com/danielmiessler/fabric
## Install Debian
## Install Ollama
## Install Fabric AI
Install prerequisites: pipx and git
```sh
sudo apt update && 
sudo apt upgrade -y && 
sudo apt install pipx git -y
```
Download install script and run
```sh
git clone https://github.com/danielmiessler/fabric.git ~/fabric &&
pipx install ~/fabric
```
Prepare shell commands
```sh
cd ~/fabric && pipx ensurepath && source ~/.bashrc
```
