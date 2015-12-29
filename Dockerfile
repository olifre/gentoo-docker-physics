FROM olifre/gentoo-docker-physics.setup
MAINTAINER olifre

RUN mkdir -p /etc/portage/env/
COPY debug.conf /etc/portage/env/
RUN mkdir -p /etc/portage/package.env/
COPY glibc-dbg /etc/portage/package.env/
# Fix Gentoo default useflags
RUN euse -E threads
RUN emerge -j3 -v dev-util/debugedit sys-libs/glibc && \
    rm -rf /usr/portage/distfiles/*

# Update once more
RUN emerge -j3 -uDNv @system @world && \
    emerge -v --depclean && \
    rm -rf /usr/portage/distfiles/*
