#!/bin/bash -e

DOCKER_VERSION=0.7.6
GO_VERSION=1.2.2
GOROOT=${HOME}/go
GOPATH=${HOME}/gocode
DOCKER_PATH=$GOPATH/src/github.com/dotcloud/docker
export GOPATH=$GOPATH:$DOCKER_PATH/vendor
export PATH=${PATH}:${GOROOT}/bin

# Setup Go
apt-get update
apt-get install build-essential git libsqlite3-dev lxc -y
git clone https://github.com/golang/go.git $GOROOT
pushd $GOROOT/src
git checkout go$GO_VERSION
./make.bash
popd

# Setup libdevmapper (Docker dependency)
git clone https://git.fedorahosted.org/git/lvm2.git /usr/local/lvm2 && cd /usr/local/lvm2 && git checkout -q v2_02_103
cd /usr/local/lvm2 && ./configure --enable-static_link && make device-mapper && make install_device-mapper

# Build docker
mkdir -p $DOCKER_PATH
mkdir -p /usr/libexec/docker
git clone https://github.com/docker/docker.git $DOCKER_PATH
pushd $DOCKER_PATH
git checkout v$DOCKER_VERSION
CGO_CFLAGS=-I/usr/local/lvm2/include CGO_LDFLAGS=-L/usr/local/lvm2/libdm go build -ldflags '-X github.com/dotcloud/docker/utils.IAMSTATIC true -linkmode external -extldflags "-lpthread -static -Wl,--unresolved-symbols=ignore-in-object-files"' -o /usr/bin/docker ./docker
popd

cat > /etc/init/docker.conf <<EOF
description "Docker daemon"

start on (filesystem and net-device-up IFACE!=lo)
stop on runlevel [!2345]
limit nofile 524288 1048576
limit nproc 524288 1048576

respawn

kill timeout 20

exec /usr/bin/docker -d
EOF

start docker
sleep 2
cat /vagrant/ubuntu.tar | docker import - ubuntu:12.04
