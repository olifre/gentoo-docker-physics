#!/bin/bash -ex

# CCACHE stats
CCACHE_DIR="/var/tmp/ccache" ccache -s

mkdir -p /etc/portage/env/
cp /build/debug.conf /etc/portage/env/
mkdir -p /etc/portage/package.env/
cp /build/glibc-dbg /etc/portage/package.env/

# Fix Gentoo default useflags
euse -E threads

emerge -j3 -v dev-util/debugedit sys-libs/glibc

emerge -j3 -uDNv @system @world
emerge --depclean

# CCACHE stats
CCACHE_DIR="/var/tmp/ccache" ccache -s
