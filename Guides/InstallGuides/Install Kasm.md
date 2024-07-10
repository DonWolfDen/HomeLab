# *A fully featured, Docker based platform to stream desktops and apps to web browser*
https://github.com/kasmtech
## Install Debian
## Install Kasm
Set up swap partition
```sh
sudo dd if=/dev/zero bs=1M count=1024 of=/mnt/1GiB.swap &&
sudo chmod 600 /mnt/1GiB.swap &&
sudo mkswap /mnt/1GiB.swap &&
sudo swapon /mnt/1GiB.swap &&
echo '/mnt/1GiB.swap swap swap defaults 0 0' | sudo tee -a /etc/fstab &&
cat /proc/swaps
```
Download files/install script and run
```sh
wget https://kasm-static-content.s3.amazonaws.com/kasm_release_1.15.0.06fdc8.tar.gz &&
tar -xf kasm_release*.tar.gz &&
sudo sh kasm_release/install.sh
```
You can change the default port with -L :
```sh
sudo sh kasm_release/install.sh -L 8443
```
## Start or stop containers
```sh
/opt/kasm/bin/start
/opt/kasm/bin/stop
```
## Backup
```sh
sudo docker exec kasm_db pg_dump -U kasmapp -F t kasm > /tmp/backup.tar
```
## Uninstall Kasm
```sh
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
## Restore
```sh
# download the same version of kasm that is on the primary database server and unpack it
cd /tmp
curl -O https://kasm-static-content.s3.amazonaws.com/kasm_release_1.15.0.06fdc8.tar.gz
tar -xf kasm_release*.tar.gz
# install
sudo bash kasm_release/install.sh
# copy the backup.tar into the kasm_db container
sudo docker cp backup.tar kasm_db:/tmp/backup.tar
# restore the database
sudo docker exec kasm_db pg_restore -d kasm /tmp/backup.tar -c -U kasmapp
```
