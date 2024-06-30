# Migrate Docker Volume

### Prepare permissions
By default, root SSH is disabled on most distros. Rather than open up that security hole, you need to move the docker volume to a path that a non-root user has permissions to, as well as chmod the permissions. The path that docker volumes are saved to is only accessible by root.
```sh
volume='the volume you want to transplant to a new machine'
user1='source user with SSH permissions'
user2='destination user with SSH permissions'
```

From the source machine:
```sh
# get root access
sudo su
# copy volume to home directory
cp -r /var/lib/docker/volumes/$volume /home/$user1/$volume
# give volume full access permissions
chmod 777 /home/$user1/$volume
```

From the destination machine
```sh
# get root access
sudo su
# pull the file from the source machine to home directory
scp -r $user1@$sourceIP:/home/$user1/$volume /home/$user2/$volume
# copy volume from home directory to docker volumes directory
cp -r /home/$user/$volume /var/lib/docker/volumes/VOLUME
# import the volume to docker
docker volume create VOLUME
# restrict the volume permissions back to what they were
chmod 701 /var/lib/docker/volumes/VOLUME # dont forget to do this on the source
```

You should now see and be able to use the transported volume on the destination machine with ```docker volume list```