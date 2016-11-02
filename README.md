#docker-0.7

Build and run Docker 0.7 on Vagrant.

This include a tar file that can be used with ``docker import`` (because Docker
0.7 can't pull images from Docker Hub).

## How to use

Clone this repository and run ``vagrant up``:

```
% vagrant up
```

After running vagrant, you can ssh into the host and execute Docker:


```
% vagrant ssh
vagrant> sudo docker -d
```

And finally, with docker daemon running, you can import the image:

```
vagrant> cat /vagrant/ubuntu.tar | sudo docker import - ubuntu:12.04
```

Please don't use this for anything serious :)
