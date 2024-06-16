# Install Kasm

# [[Install Debian]]
# Install Kasm
### Set up swap partition
```sh
sudo dd if=/dev/zero bs=1M count=1024 of=/mnt/1GiB.swap &&
sudo chmod 600 /mnt/1GiB.swap &&
sudo mkswap /mnt/1GiB.swap &&
sudo swapon /mnt/1GiB.swap &&
echo '/mnt/1GiB.swap swap swap defaults 0 0' | sudo tee -a /etc/fstab &&
cat /proc/swaps
```

### Download and extract
```sh
wget https://kasm-static-content.s3.amazonaws.com/kasm_release_1.15.0.06fdc8.tar.gz &&
tar -xf kasm_release*.tar.gz &&
sudo bash kasm_release/install.sh
```
Note: you can change the default port like this:
```sh
sudo bash kasm_release/install.sh -L 8443
```

## Uninstall Kasm
Create script
```nano ~/uninstall_kasm.sh ```
Paste in commands
```sh
#!/bin/bash

/opt/kasm/current/bin/stop
docker rm -f $(sudo docker container ls -qa --filter="label=kasm.kasmid")
export KASM_UID=$(id kasm -u)
export KASM_GID=$(id kasm -g)
-E docker compose -f /opt/kasm/current/docker/docker-compose.yaml rm
docker network rm kasm_default_network
docker volume rm kasm_db_1.15.0
docker rmi redis:5-alpine
docker rmi postgres:9.5-alpine
docker rmi kasmweb/nginx:latest
docker rmi kasmweb/share:1.15.0
docker rmi kasmweb/agent:1.15.0
docker rmi kasmweb/manager:1.15.0
docker rmi kasmweb/api:1.15.0
docker rmi $(sudo docker images --filter "label=com.kasmweb.image=true" -q)
rm -rf /opt/kasm/
deluser kasm_db
deluser kasm
```
Make script executable and run it
```sudo chmod +x ~/uninstall_kasm.sh && sudo bash ~/uninstall_kasm.sh ```