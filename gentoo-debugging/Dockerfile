FROM olifre/gentoo-docker-physics.gentoo-setup
MAINTAINER olifre

RUN mkdir -p /etc/portage/env/
RUN cp -v debug.conf /etc/portage/env/
RUN cp -v glibc-dbg /etc/portage/package.env/
RUN emerge -v glibc
