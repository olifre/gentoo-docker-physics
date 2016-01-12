#!/bin/bash -ex

# Safety.
chown -R portage:portage /usr/portage
chown -R portage:portage /var/tmp/ccache
chown -R portage:portage /var/packages

mkdir -p /etc/portage/env/
cp /build/debug.conf /etc/portage/env/
mkdir -p /etc/portage/package.env/
cp /build/glibc-dbg /etc/portage/package.env/

# Fix Gentoo default useflags
euse -E threads

emerge -j3 -v dev-util/debugedit sys-libs/glibc

# Cleanup
emerge -j3 -uDNv @system @world
emerge --depclean

# Also verbose tree
emerge -v --depclean
