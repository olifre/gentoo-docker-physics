#!/bin/bash -x

echo 'GENTOO_MIRRORS="http://distfiles.gentoo.org/"' >> /etc/portage/make.conf
#mkdir -p /usr/portage
#chown -R portage:portage /usr/portage
#emerge-webrsync
eselect news read new
emerge -v ccache
CCACHE_DIR="/var/tmp/ccache" ccache -M 100M
sed -i 's/FEATURES="/FEATURES="ccache /' /etc/portage/make.conf
echo 'CCACHE_SIZE="5G"' >> /etc/portage/make.conf
emerge -v gentoolkit

# Cleanup
#rm -rf /usr/portage/*'

CCACHE_DIR="/var/tmp/ccache" ccache -s

# Self-destruct
#rm -v -rf $0
