#!/bin/bash -ex

# Safety.
chown -R portage:portage /usr/portage
chown -R portage:portage /var/tmp/ccache
chown -R portage:portage /var/packages

# Debug symbols
mkdir -p /etc/portage/package.env/
cp /build/geant-dbg /etc/portage/package.env/

# Keywords and flags for geant4
mkdir -p /etc/portage/package.keywords
echo "sci-physics/geant:4" >> /etc/portage/package.keywords/geant4
echo "sci-physics/geant-data" >> /etc/portage/package.keywords/geant4
echo "sci-physics/clhep" >> /etc/portage/package.keywords/geant4
mkdir -p /etc/portage/package.use
echo "sci-physics/geant:4 data -threads opengl geant3" >> /etc/portage/package.use/geant4

# Compile geant4
emerge -v -j3 sci-physics/geant:4

# Update a bit and cleanup
emerge -j3 -uDNv @system @world
emerge --depclean

# Also print verbose tree
emerge -v --depclean
