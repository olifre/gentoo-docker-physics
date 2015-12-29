#!/bin/bash -x

# CCACHE stats
CCACHE_DIR="/var/tmp/ccache" ccache -s

cp /build/root-dbg /etc/portage/package.env/
echo "sci-physics/root" >> /etc/portage/package.keywords
euse -E graphviz http postgres sqlite qt4 math xml clang qt3support jpeg gif png tiff truetype fontconfig

# Update once more
emerge -j3 -uDNv @system @world
emerge --depclean

# Compile some heavy stuff which is needed for ROOT
emerge -j3 -v clang

# CCACHE stats
CCACHE_DIR="/var/tmp/ccache" ccache -s
