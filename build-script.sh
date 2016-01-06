#!/bin/bash -ex

echo 'GENTOO_MIRRORS="http://distfiles.gentoo.org/"' >> /etc/portage/make.conf
eselect news read new
emerge -v -j3 ccache

echo 'FEATURES="ccache parallel-install fixlafiles buildpkg"' >> /etc/portage/make.conf
echo 'CCACHE_SIZE="10G"' >> /etc/portage/make.conf
mkdir -p /var/packages
chown portage:portage /var/packages
echo 'PKGDIR="/var/packages"' >> /etc/portage/make.conf
echo 'EMERGE_DEFAULT_OPTS="${EMERGE_DEFAULT_OPTS} --usepkg"' >> /etc/portage/make.conf

# Enforce python 3 only
#PYTHON_TARGETS=$(emerge --info | sed -n 's/.*PYTHON_TARGETS="\([^"]*\)".*/\1/p') && \
#	PYTHON_TARGET="${PYTHON_TARGETS##* }" && \
#	echo "PYTHON_TARGETS=\"${PYTHON_TARGET}\"" >> /etc/portage/make.conf && \
#	echo "PYTHON_SINGLE_TARGET=\"${PYTHON_TARGET}\"" >> /etc/portage/make.conf
#eselect python set $(eselect python show --python3)

# Install basics
emerge -v -j3 gentoolkit portage-utils

# Turn on bindist since we build for docker
# on by default on gentoo
#euse -E bindist

# Turn on sqlite
euse -E sqlite

# Disable some unneeded stuff
euse -E minimal
euse -D tcpd pam crypt cracklib acl

# Would make some packages pull in python2 again
euse -D introspection

# Remove unneeded system packages
mkdir -p /etc/portage/profile/
echo "-*virtual/ssh" >> /etc/portage/profile/packages
echo "-*virtual/dev-manager" >> /etc/portage/profile/packages
echo "-*virtual/service-manager" >> /etc/portage/profile/packages
echo "-*virtual/modutils" >> /etc/portage/profile/packages
echo "-*virtual/man" >> /etc/portage/profile/packages
echo "-*sys-apps/man-pages" >> /etc/portage/profile/packages
echo "-*sys-fs/e2fsprogs" >> /etc/portage/profile/packages
echo "-*sys-apps/net-tools" >> /etc/portage/profile/packages
echo "-*sys-apps/openrc" >> /etc/portage/profile/packages
echo "-*net-misc/iputils" >> /etc/portage/profile/packages
echo "-*sys-apps/iproute2" >> /etc/portage/profile/packages
echo "-*sys-apps/busybox" >> /etc/portage/profile/packages

# Update a bit
emerge -j3 -uDNv @system @world
emerge --depclean

# Update environment
env-update
etc-update
hash -r

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

# Update using new environment
emerge -j3 -v --newuse --deep --with-bdeps=y @system @world

# OpenRC setup
#sed -i 's/#rc_sys=""/rc_sys="lxc"/g' /etc/rc.conf

# Networking is setup by Docker
#echo 'rc_provide="loopback net"' >> /etc/rc.conf
#rc-update delete loopback boot
#rc-update delete netmount default

# Log boot process to /var/log/rc.log
#sed -i 's/^#\(rc_logger="YES"\)$/\1/' /etc/rc.conf

# Setup portage stuff
echo 'MAKEOPTS="-j3"' >> /etc/portage/make.conf

# Syslog?

# Layman
emerge -v -j3 layman
echo "source /var/lib/layman/make.conf" >> /etc/portage/make.conf
layman -L

# Simple depclean
emerge --depclean

# Verbose depclean to see dependencies of remaining stuff
emerge -v --depclean
