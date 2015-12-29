#!/bin/bash -x

docker create -v /usr/portage --name portage gentoo/portage

mkdir -p ~/.ccache/
docker run --volumes-from portage \
           -v ~/.ccache:/var/tmp/ccache \
           -v $(pwd):/build \
           --name gentoo \
           gentoo/stage3-amd64 \
           /build/build-script.sh

docker commit gentoo olifre/gentoo-docker-physics.setup
