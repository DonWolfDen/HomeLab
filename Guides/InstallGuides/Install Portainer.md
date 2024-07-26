# *A basic web GUI for Docker administration*
https://github.com/portainer
## Install Debian
## Install Docker
## Install Portainer
Create Portainer container with persistent configuration
```sh
docker volume create portainer_data &&
docker run -d --restart=always --name portainer -p 8000:8000 -p 9443:9443 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
```
Access the web GUI
https://localhost:9443/

## Add remote agent
Create portainer agent
```sh
docker volume create portainer_data &&
docker run -d -p 9001:9001 --name portainer_agent --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker/volumes:/var/lib/docker/volumes portainer/agent:2.19.5
```