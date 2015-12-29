FROM olifre/gentoo-docker-physics.debugging
MAINTAINER olifre

COPY root-dbg /etc/portage/package.env/
RUN echo "sci-physics/root" >> /etc/portage/package.keywords
RUN euse -E graphviz http postgres sqlite qt4 math xml clang qt3support jpeg gif png tiff truetype fontconfig

# Update once more
RUN emerge -j3 -uDNv @system @world && \
    emerge -v --depclean && \
    rm -rf /usr/portage/distfiles/*

# Compile some heavy stuff which is needed for ROOT
RUN emerge -j3 -v clang && \
    rm -rf /usr/portage/distfiles/*

# Update once more
RUN emerge -j3 -uDNv @system @world && \
    emerge -v --depclean && \
    rm -rf /usr/portage/distfiles/*
