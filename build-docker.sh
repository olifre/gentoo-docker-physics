#!/bin/bash -ex

INPUT_CONTAINER=${1:-gentoo/stage3-amd64}
OUTPUT_CONTAINER=${2:-olifre/gentoo-docker-physics.FIXME}
BRANCHNAME=${3:-master}

mkdir -p ~/.ccache-${BRANCHNAME}/
mkdir -p ~/packages-${BRANCHNAME}/

docker create -v /usr/portage --name portage gentoo/portage

ls -la ~/.ccache-${BRANCHNAME}/

docker run --volumes-from portage \
           -v ~/.ccache-${BRANCHNAME}:/var/tmp/ccache \
           -v ~/packages-${BRANCHNAME}:/var/packages \
           -v $(pwd):/build \
           --name gentoo \
           ${INPUT_CONTAINER} \
           /build/build-script.sh

docker export gentoo | docker import - ${OUTPUT_CONTAINER}

#docker commit gentoo ${OUTPUT_CONTAINER}
