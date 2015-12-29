FROM olifre/gentoo-docker-physics.root-prepare
MAINTAINER olifre

RUN emerge -j3 -v root

# Update once more
RUN emerge -uDNv @system @world
RUN emerge -v --depclean
RUN rm -rf /usr/portage/distfiles/*
