FROM olifre/gentoo-docker-physics.setup
MAINTAINER olifre

RUN mkdir -p /etc/portage/env/
COPY debug.conf /etc/portage/env/
RUN mkdir -p /etc/portage/package.env/
COPY glibc-dbg /etc/portage/package.env/
# Fix Gentoo default useflags
RUN euse -E threads
RUN emerge -v dev-util/debugedit
RUN emerge -v sys-libs/glibc

# Update once more
RUN emerge -uDNv @system @world
RUN emerge -v --depclean
RUN rm -rf /usr/portage/distfiles/*
