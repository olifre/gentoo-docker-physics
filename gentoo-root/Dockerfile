FROM wking/gentoo-layman

RUN layman -S
RUN layman -a science
RUN echo "sci-physics/root" >> /etc/portage/package.keywords
RUN emerge -v root
