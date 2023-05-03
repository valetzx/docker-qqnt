# syntax=docker/dockerfile:1

FROM ifrstr/novnc:0.0.1

ARG BUILD_QQNT_LINK
ARG BUILD_ARCH

COPY --chmod=0755 rootfs /

RUN apt update && \
  \
  # Upgrade OS
  apt upgrade -y -o Dpkg::Options::="--force-confold" && \
  \
  # Install packages
  apt install -y wget && \
  \
  # QQNT
  wget -O /tmp/qqnt.deb ${BUILD_QQNT_LINK}_${BUILD_ARCH}.deb && \
  apt install -y /tmp/qqnt.deb && \
  \
  # Cleanup
  apt purge -y wget && \
  apt autoremove -y && \
  apt clean && \
  rm -rf \
  /var/lib/apt/lists/* \
  /tmp/* \
  /var/tmp/*
