FROM scratch
ADD /sources/images/ubuntu-bionic-oci-amd64-root.tar.gz /

# System Environment
ENV DEBIAN_FRONTEND=noninteractive

# Initialize Container
RUN sed -i "s/archive.ubuntu.com/mirror.dknet.my.id/g" /etc/apt/sources.list && \
    sed -i "s/security.ubuntu.com/mirror.dknet.my.id/g" /etc/apt/sources.list && \
    apt -y update && \
    apt -y install sudo systemd rsyslog cron locales dos2unix nano git htop
RUN apt -y install iputils-ping
RUN apt -y install libutempter0 screen curl tzdata wget

# Create shortcut SystemD
RUN ln -sf /lib/systemd/systemd /systemd

# Configure Command
ADD /sources/commands /tmp
RUN dos2unix /tmp/configure-* && \
    chmod +x /tmp/configure-* && \
    sh -c /tmp/configure-userd && \
    sh -c /tmp/configure-healthcheck && \
    sh -c /tmp/configure-container

# Configure Script
ADD /sources/scripts /usr/local/bin
RUN dos2unix /usr/local/bin/* && \
    chmod +x /usr/local/bin/*

# Add healthcheck files
ADD /sources/healthcheck /opt/healthcheck

# Clear Temp
RUN rm -rf /tmp/* && \
    apt -y autoclean && \
    apt -yqq autoremove \
    && apt -y clean \
    && rm -rf /var/lib/apt/lists/* && \
    touch /var/log/installed.log && \
    rm /var/log/*.log

# Container Environment
CMD ["/systemd"]
HEALTHCHECK CMD node /opt/healthcheck/monitor.js
LABEL maintainer="Andika Muhammad Cahya <andkmc99@gmail.com>"
LABEL version="Ubuntu SystemD build 2201221602 based on Ubuntu 18.04 Bionic"
WORKDIR /root
