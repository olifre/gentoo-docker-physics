#!/bin/bash -ex

cp /build/root-dbg /etc/portage/package.env/
mkdir -p /etc/portage/package.keywords/
echo "sci-physics/root" >> /etc/portage/package.keywords/root
euse -E graphviz http postgres sqlite qt4 math xml clang qt3support jpeg gif png tiff truetype fontconfig

# Update after flag changes
emerge -j3 -uDNv @system @world
emerge --depclean

# Compile some heavy stuff which is needed for ROOT
# LLVM without python since that pulls in python2 again
#mkdir -p /etc/portage/package.use/
#echo "sys-devel/llvm -python" >> /etc/portage/package.use/no-python2
emerge -j3 -v sys-devel/clang virtual/opengl dev-util/cmake media-gfx/graphviz dev-db/postgresql

# Update once more
emerge -j3 -uDNv @system @world
emerge --depclean

# Verbose reverse dependency tree
emerge -v --depclean
