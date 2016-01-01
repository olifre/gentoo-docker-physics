#!/bin/bash -ex

# Keywords and flags for geant4
mkdir -p /etc/portage/package.keywords
echo "sci-physics/vgm **" >> /etc/portage/package.keywords/physics-addons
echo "sci-physics/geant-vmc:4 **" >> /etc/portage/package.keywords/physics-addons
echo "sci-physics/genfit **" >> /etc/portage/package.keywords/physics-addons
mkdir -p /etc/portage/package.use
echo "sci-physics/vgm geant4 root xml" >> /etc/portage/package.use/physics-addons
echo "sci-physics/geant-vmc:4 vgm" >> /etc/portage/package.use/physics-addons

# Compile geant-vmc, vgm and genfit
emerge -v -j3 sci-physics/vgm sci-physics/geant-vmc:4 sci-physics/genfit

# Update a bit and cleanup
emerge -j3 -uDNv @system @world
emerge --depclean

# Also print verbose tree
emerge -v --depclean
