#!/bin/bash -ex

# Compile ROOT
emerge -v -j3 =sci-physics/root-9999

# Update a bit and cleanup
emerge -j3 -uDNv @system @world
emerge --depclean

# Also print verbose tree
emerge -v --depclean
