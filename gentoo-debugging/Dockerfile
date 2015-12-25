FROM olifre/gentoo-docker-physics.gentoo-setup
MAINTAINER olifre

RUN mkdir -p /etc/portage/env/
COPY debug.conf /etc/portage/env/
RUN mkdir -p /etc/portage/package.env/
COPY glibc-dbg /etc/portage/package.env/
RUN emerge -v glibc
RUN emerge -uDNv @system @world
RUN emerge -v --depclean
RUN rm -rf /usr/portage/distfiles/* /usr/portage/distfiles/.*
