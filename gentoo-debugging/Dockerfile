FROM olifre/gentoo-docker-physics.gentoo-setup
MAINTAINER olifre

RUN mkdir -p /etc/portage/env/
COPY debug.conf /etc/portage/env/
COPY glibc-dbg /etc/portage/package.env/
RUN emerge -v glibc
RUN emerge -uDNv @system @world
RUN emerge -v --depclean
