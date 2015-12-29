#!/bin/bash -x

echo 'GENTOO_MIRRORS="http://distfiles.gentoo.org/"' >> /etc/portage/make.conf
#mkdir -p /usr/portage
#chown -R portage:portage /usr/portage
#emerge-webrsync
eselect news read new
emerge -v ccache
echo 'FEATURES="ccache parallel-install fixlafiles"' >> /etc/portage/make.conf
echo 'CCACHE_SIZE="10G"' >> /etc/portage/make.conf
emerge -v gentoolkit

# Cleanup
#rm -rf /usr/portage/*'

# Self-destruct
#rm -v -rf $0

# Update a bit
emerge -j3 -uDNv @system @world
emerge -v --depclean

# Timezone stuff
echo "Europe/Berlin" > /etc/timezone
emerge --config sys-libs/timezone-data

# Locale stuff
echo en_US ISO-8859-1 > /etc/locale.gen
echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
locale-gen
echo 'LANG="en_US.UTF-8"' >> /etc/env.d/02locale
env-update
echo 'LINGUAS="en en_US"' >> /etc/portage/make.conf

emerge -j3 -v --newuse --deep --with-bdeps=y @system @world

# OpenRC setup
sed -i 's/#rc_sys=""/rc_sys="lxc"/g' /etc/rc.conf

# Networking is setup by Docker
echo 'rc_provide="loopback net"' >> /etc/rc.conf
rc-update delete loopback boot
rc-update delete netmount default

# Log boot process to /var/log/rc.log
sed -i 's/^#\(rc_logger="YES"\)$/\1/' /etc/rc.conf

# Setup portage stuff
echo 'MAKEOPTS="-j3"' >> /etc/portage/make.conf

# Syslog?

# CCACHE stats
CCACHE_DIR="/var/tmp/ccache" ccache -s
