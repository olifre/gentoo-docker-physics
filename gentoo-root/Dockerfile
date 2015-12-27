FROM olifre/gentoo-docker-physics.gentoo-debugging
MAINTAINER olifre

COPY root-dbg /etc/portage/package.env/
RUN echo "sci-physics/root" >> /etc/portage/package.keywords
RUN euse -E graphviz http postgres sqlite qt4 math xml clang qt3support

# Update once more
RUN emerge -uDNv @system @world
RUN emerge -v --depclean
RUN rm -rf /usr/portage/distfiles/*

RUN emerge -v root

# Update once more
RUN emerge -uDNv @system @world
RUN emerge -v --depclean
RUN rm -rf /usr/portage/distfiles/*
