#!/usr/bin/env bash

echo 'GENTOO_MIRRORS="http://distfiles.gentoo.org/"' >> /etc/portage/make.conf
mkdir -p /usr/portage
chown -R portage:portage /usr/portage
emerge-webrsync
eselect news read new
emerge -v gentoolkit ccache
sed -i 's/FEATURES="/FEATURES="ccache /' /etc/portage/make.conf
echo 'CCACHE_SIZE="2G"' >> /etc/portage/make.conf
rm -rf /usr/portage/*'
rm -v -rf $0
