FROM olifre/gentoo-docker-physics.gentoo-debugging
MAINTAINER olifre

COPY root-dbg /etc/portage/package.env/
RUN echo "sci-physics/root" >> /etc/portage/package.keywords
RUN euse -E graphviz,http,postgres,sqlite,qt4,math,xml
RUN emerge -v root
