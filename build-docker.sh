#!/bin/bash -x

docker create -v /usr/portage --name portage gentoo/portage
docker cp build-script.sh gentoo:/

mkdir -p ~/.ccache/
docker run --volumes-from portage \
           -v ~/.ccache:/var/tmp/ccache \
           --name gentoo \
           gentoo/stage3-amd64 \
           /build-script.sh
