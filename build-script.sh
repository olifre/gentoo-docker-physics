#!/bin/bash -ex

# Keywords and flags for geant4
mkdir -p /etc/portage/package.keywords
echo "sci-physics/geant:4" >> /etc/portage/package.keywords/geant4
mkdir -p /etc/portage/package.use
echo "sci-physics/geant:4 data -threads" >> /etc/portage/package.use/geant4

# Compile geant4
emerge -v -j3 sci-physics/geant:4

# Update a bit and cleanup
emerge -j3 -uDNv @system @world
emerge --depclean

# Also print verbose tree
emerge -v --depclean
