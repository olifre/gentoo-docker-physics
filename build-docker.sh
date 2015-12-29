#!/usr/bin/env bash

docker create -v /usr/portage --name portage gentoo/portage
docker run --volumes-from portage --name gentoo -it gentoo/stage3-amd64 /bin/bash
docker exec gentoo sh -c "echo \"GENTOO_MIRRORS=\"http://distfiles.gentoo.org/\"\" >> /etc/portage/make.conf"
docker exec gentoo mkdir -p /usr/portage
docker exec gentoo chown -R portage:portage /usr/portage
docker exec gentoo emerge-webrsync
docker exec gentoo eselect news read new
docker exec gentoo emerge -v gentoolkit
docker exec gentoo sh -c 'rm -rf /usr/portage/*'
