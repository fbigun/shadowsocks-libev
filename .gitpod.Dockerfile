FROM gitpod/workspace-full

# Install custom tools, runtimes, etc.
# For example "bastet", a command-line tetris clone:
# RUN brew install bastet
#
# More information: https://www.gitpod.io/docs/config-docker/

# Installation of basic build dependencies
## Debian / Ubuntu
RUN sudo apt-get update \
    && sudo apt-get install --no-install-recommends -y \
        gettext build-essential autoconf libtool libpcre3-dev asciidoc xmlto \
        libev-dev libc-ares-dev automake libmbedtls-dev libsodium-dev \
    && sudo rm -rf /var/lib/apt/lists/* && sudo apt-get autoclean && sudo apt-get -y autoremove

# Installation of libsodium
RUN export LIBSODIUM_VER=1.0.18\
    && wget https://download.libsodium.org/libsodium/releases/libsodium-$LIBSODIUM_VER.tar.gz \
    && tar xvf libsodium-$LIBSODIUM_VER.tar.gz \
    && cd libsodium-$LIBSODIUM_VER \
    && ./configure --prefix=/usr && make \
    && sudo make install \
    && cd .. \
    && sudo ldconfig

# Installation of MbedTLS
RUN export MBEDTLS_VER=2.6.0 \
    && wget https://tls.mbed.org/download/mbedtls-$MBEDTLS_VER-gpl.tgz \
    && tar xvf mbedtls-$MBEDTLS_VER-gpl.tgz \
    && cd mbedtls-$MBEDTLS_VER \
    && make SHARED=1 CFLAGS="-O2 -fPIC" \
    && sudo make DESTDIR=/usr install \
    && cd .. \
    && sudo ldconfig
