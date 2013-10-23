#!/bin/bash
# ubuntu package
apt-get install \
build-essential \
bash coreutils rsync patch wget \
cmake \
ccache \
nasm autoconf automake libtool \
libpam0g-dev \
libsasl2-dev \
ss-dev \
comerr-dev \
bison flex

if ! grep -q nobody /etc/group &>/dev/null; then
    groupadd nobody &>/dev/null;
fi

exit 0;
