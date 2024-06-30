# *A fully featured web GUI for Docker Kubernetes administration*
https://github.com/rancher
## Install Debian
## Install Docker
Use the Rancher Docker install script to ensure a compatible installation
```sh
sudo curl https://releases.rancher.com/install-docker/24.0.sh | sh &&
sudo usermod -aG docker $USER
```
## Install Rancher
Set required networking options and apply

```sudo nano /etc/sysctl.conf```
```
net.bridge.bridge-nf-call-iptables=1
```
```sh
sudo modprobe br_netfilter &&
sudo sysctl -p
```
Create Rancher container with persistent configuration
```sh
docker run -d --restart=unless-stopped \
  -p 80:80 -p 443:443 \
  -v /opt/rancher:/var/lib/rancher \
  --privileged \
  rancher/rancher:latest
```
Grab the container ID from Rancher, use it to pull the temporary password

```docker ps```

- container ID will be something like this: 9418f454dd90
- copy it and replace $containerID

```sh
docker logs $containerID 2>&1 | grep "Bootstrap Password:"
```
Access the web gui and enter the bootstrap password from above

https://localhost:443/

- Change your password and set your access ip. usually default
- Wait for 'local' cluster to be in active state then create new cluster with all default values
- Spin up docker images in the new cluster, not local
