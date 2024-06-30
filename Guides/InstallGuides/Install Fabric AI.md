# *A prompting framework to improve results from AI large language models*
https://github.com/danielmiessler/fabric
## Install Debian
## Install Ollama
## Install required packages
```sh
sudo apt update && 
sudo apt upgrade -y && 
sudo apt install pipx git -y
```
## Install Fabric AI
Download install script and run
```sh
git clone https://github.com/danielmiessler/fabric.git ~/fabric &&
pipx install ~/fabric
```
Prepare shell commands
```sh
cd ~/fabric && pipx ensurepath && source ~/.bashrc
```
