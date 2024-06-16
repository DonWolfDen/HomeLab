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
## Create script to install multiple models at once
### Docker on Linux
Create script
```nano ~/ollama_pull.sh ```
Paste in commands
```sh
#!/bin/bash

# Initialize an empty array to store the image names
models=()

# Prompt the user to enter image names until they enter an empty line
echo "Enter only one model per promt, no spaces"
echo "Example:"
echo "Enter a model to download: llama3"
echo "Enter a model to download: llama2-uncensored"
echo "Enter a model to download: codegemma:2b"
echo "Enter a model to download: mistral:instruct"
echo "Enter a model to download: "
echo "**Models will start downloading after an empty line is input**"
while true; do
  read -p "Enter a model to download: " model
  if [ -z "$model" ]; then
    break
  fi
  models+=("$model")
done

# Loop through the images and execute the docker pull command for each one
for model in ${models[@]}; do
  docker exec -it ollama ollama pull $model
done

```
Make script executable and run it
```sudo chmod +x ~/ollama_pull.sh && ~/ollama_pull.sh ```

### Docker Desktop on Windows
Open Powershell ISE and paste this in then hit run
```powershell
# Prompt user for model names
Write-Host "Please enter the names of the models you want to download, separated by spaces:"
$models = Read-Host

# Split input into array if multiple models are entered
$modelArray = $models -split ' '

foreach ($model in $modelArray) {
    # Construct and execute docker command for each model
    Invoke-Expression "docker exec -it ollama ollama pull $model"
}
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
Create script
```nano ~/uninstall_ollama.sh ```
Paste in commands
```sh
#!/bin/bash

systemctl stop ollama
systemctl disable ollama
rm /etc/systemd/system/ollama.service
rm $(which ollama)
rm -r /usr/share/ollama
userdel ollama
groupdel ollama
```
Make script executable and run it
```sudo chmod +x ~/uninstall_ollama.sh && sudo bash ~/uninstall_ollama.sh ```
