#!/usr/bin/env bash

docker create -v /usr/portage --name portage gentoo/portage
docker cp build-script.sh gentoo:/

docker run --volumes-from portage --name gentoo -it -d gentoo/stage3-amd64 /build-script.sh
