FROM gitpod/workspace-full

# Install custom tools, runtimes, etc.
# For example "bastet", a command-line tetris clone:
# RUN brew install bastet
#
# More information: https://www.gitpod.io/docs/config-docker/

USER root

# Installation of basic build dependencies
## Debian / Ubuntu
RUN sudo apt-get install --no-install-recommends gettext build-essential autoconf libtool libpcre3-dev asciidoc xmlto libev-dev libc-ares-dev automake libmbedtls-dev libsodium-dev

# Installation of libsodium
RUN export LIBSODIUM_VER=1.0.16; wget https://download.libsodium.org/libsodium/releases/libsodium-$LIBSODIUM_VER.tar.gz; \
    tar xvf libsodium-$LIBSODIUM_VER.tar.gz; \
    pushd libsodium-$LIBSODIUM_VER; \
    ./configure --prefix=/usr && make; \
    sudo make install; \
    popd; \
    sudo ldconfig

# Installation of MbedTLS
RUN export MBEDTLS_VER=2.6.0; \
    wget https://tls.mbed.org/download/mbedtls-$MBEDTLS_VER-gpl.tgz; \
    tar xvf mbedtls-$MBEDTLS_VER-gpl.tgz; \
    pushd mbedtls-$MBEDTLS_VER; \
    make SHARED=1 CFLAGS="-O2 -fPIC";\
    sudo make DESTDIR=/usr install;\
    popd;\
    sudo ldconfig
