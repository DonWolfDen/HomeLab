# *A fully featured containerization platform*
https://github.com/docker
## Install Debian
## Install Docker
Download and run official Docker install script
```sh
curl -fsSL https://get.docker.com -o ~/get-docker.sh &&
sh get-docker.sh
```
Add user to Docker group so sudo isn't needed
```sh
sudo usermod -aG docker $username
```

Default volume location for Docker on Linux (requires root):
```sh
/var/lib/docker/volumes
```
Default volume location for Docker desktop on Windows:
```sh
\\wsl$\docker-desktop-data\data\docker\volumes
```