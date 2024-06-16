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