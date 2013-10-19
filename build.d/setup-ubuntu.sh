#!/bin/bash
# ubuntu package
apt-get install \
build-essential \
coreutils rsync patch \
cmake \
ccache \
nasm autoconf automake libtool \
libkrb5-dev \
libpam0g-dev \
freetds-dev

if ! grep -q nobody /etc/groups &>/dev/null; then
    groupadd nobody &>/dev/null;
fi

exit 0;
