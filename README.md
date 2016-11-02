#docker-0.7

Build and run Docker 0.7 on Vagrant.

This include a tar file that can be used with ``docker import`` (because Docker
0.7 can't pull images from Docker Hub).

## How to use

Clone this repository and run ``vagrant up``:

```
% vagrant up
```

After running vagrant, you can ssh into the host and use Docker:

```
$ sudo docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
ubuntu              12.04               8afd099d45d3        3 minutes ago       83.59 MB
$ sudo docker run ubuntu:12.04 cat /etc/passwd
```

Please don't use this for anything serious :)
