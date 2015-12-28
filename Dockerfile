FROM olifre/gentoo-docker-physics.gentoo-portage
MAINTAINER olifre

# Update a bit
RUN emerge -uDNv @system @world
RUN emerge -v --depclean
RUN rm -rf /usr/portage/distfiles/*

# Timezone stuff
RUN echo "Europe/Berlin" /etc/timezone
RUN emerge --config sys-libs/timezone-data

# Locale stuff
RUN echo en_US ISO-8859-1 > /etc/locale.gen
RUN echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
RUN locale-gen
RUN echo 'LANG="en_US.UTF-8"' >> /etc/env.d/02locale
RUN env-update
RUN echo 'LINGUAS="en en_US"' >> /etc/portage/make.conf
RUN emerge -v --newuse --deep --with-bdeps=y @system @world

# OpenRC setup
RUN sed -i 's/#rc_sys=""/rc_sys="lxc"/g' /etc/rc.conf

# Networking is setup by Docker
RUN echo 'rc_provide="loopback net"' >> /etc/rc.conf
RUN rc-update delete loopback boot
RUN rc-update delete netmount default

# Log boot process to /var/log/rc.log
RUN sed -i 's/^#\(rc_logger="YES"\)$/\1/' /etc/rc.conf

# Syslog? 
