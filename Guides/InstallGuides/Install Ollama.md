# *A platform to host AI large language models*
https://github.com/ollama
## Install Debian
## Install Ollama
```sh
curl -fsSL https://ollama.com/install.sh | sh
```
Add models
```sh
ollama pull <model>
```
Run a model
```sh
ollama run <model>
```
## Uninstall Ollama
```sh
systemctl stop ollama
systemctl disable ollama
rm /etc/systemd/system/ollama.service
rm $(which ollama)
rm -r /usr/share/ollama
userdel ollama
groupdel ollama
```
