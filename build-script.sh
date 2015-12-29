#!/bin/bash -ex

# CCACHE stats
CCACHE_DIR="/var/tmp/ccache" ccache -s

# Compile ROOT
emerge -v -j3 root

# Update a bit and cleanup
emerge -j3 -uDNv @system @world
emerge --depclean

# CCACHE stats
CCACHE_DIR="/var/tmp/ccache" ccache -s
