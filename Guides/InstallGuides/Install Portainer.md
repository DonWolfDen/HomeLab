# *A basic web GUI for Docker administration*
https://github.com/portainer
## Install Debian
## Install Docker
## Install Portainer
Create Portainer container with persistent configuration
```sh
docker volume create portainer_data &&
docker run -d --restart=always \
  --name portainer \
  -p 8000:8000 -p 9443:9443 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  portainer/portainer-ce:latest
```
Access the web GUI
https://localhost:9443/
