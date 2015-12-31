#!/bin/bash -ex

# Compile ROOT
emerge -v -j3 root

# Update a bit and cleanup
emerge -j3 -uDNv @system @world
emerge --depclean

# Also print verbose tree
emerge -v --depclean
