FROM olifre/gentoo-docker-physics.gentoo-root-prepare
MAINTAINER olifre

RUN emerge -v root

# Update once more
RUN emerge -uDNv @system @world
RUN emerge -v --depclean
RUN rm -rf /usr/portage/distfiles/*
