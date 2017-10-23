FROM docker.io/ubuntu:xenial
MAINTAINER MAB <mab@mab.net>

# Keep image updated
ENV REFRESHED_AT 2017-10-23-00-00Z

ENV LANG C.UTF-8

# Add repositories and update base
RUN echo "deb http://archive.ubuntu.com/ubuntu/ xenial main restricted universe multiverse" > /etc/apt/sources.list \
  && echo "deb http://archive.ubuntu.com/ubuntu/ xenial-updates main restricted universe multiverse" >> /etc/apt/sources.list \
  && echo "deb http://archive.ubuntu.com/ubuntu/ xenial-backports main restricted universe multiverse" >> /etc/apt/sources.list \
  && echo "deb http://security.ubuntu.com/ubuntu xenial-security main restricted universe multiverse" >> /etc/apt/sources.list \
  && apt-get update -q \
  && DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -qy

# Install software
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qy --no-install-recommends supervisor ca-certificates curl openvpn openssl iptables \
  && apt-get clean \
  && rm -rf /var/lib/apt /tmp/* /var/tmp/*

# Add custom files
COPY files/root /

# Start command
CMD ["/start"]
