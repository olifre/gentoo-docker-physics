#!/usr/bin/env bash

CONTAINER_ID=$(docker create -t -i -d gentoo/stage3-amd64 bash)
docker start -a -i $CONTAINER_ID
docker exec $CONTAINER_ID sh -c 'echo \'GENTOO_MIRRORS="http://distfiles.gentoo.org/"\' >> /etc/portage/make.conf'
docker exec $CONTAINER_ID mkdir -p /usr/portage
docker exec $CONTAINER_ID chown -R portage:portage /usr/portage
docker exec $CONTAINER_ID emerge-webrsync
docker exec $CONTAINER_ID eselect news read new
docker exec $CONTAINER_ID emerge -v gentoolkit
docker exec $CONTAINER_ID sh -c 'rm -rf /usr/portage/*'
