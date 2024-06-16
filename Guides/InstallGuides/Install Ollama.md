# Install Ollama

# [[Install Debian]]
# [[Install Docker]]
# [[Install Portainer]]
# Install Ollama with OpenWebUI
## [[Compose OpenWebUI]]
## Add models to Ollama container
```
docker exec -it ollama ollama pull <model:tag>
```

## Install Ollama Without Docker/OpenWebUI

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

___
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