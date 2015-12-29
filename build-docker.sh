#!/bin/bash -x

INPUT_CONTAINER=${1:-gentoo/stage3-amd64}
OUTPUT_CONTAINER=${2:-olifre/gentoo-docker-physics.FIXME}

docker create -v /usr/portage --name portage gentoo/portage

mkdir -p ~/.ccache/
docker run --volumes-from portage \
           -v ~/.ccache:/var/tmp/ccache \
           -v $(pwd):/build \
           --name gentoo \
           ${INPUT_CONTAINER} \
           /build/build-script.sh

docker commit gentoo ${OUTPUT_CONTAINER}
