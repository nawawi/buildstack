#!/bin/bash
# centos package
yum -y install \
coreutils gcc gcc-c++ glibc-devel libstdc++-devel cmake make autoconf automake libtool bison libgcc \
unixODBC-devel readline-devel gnutls-devel krb5-devel freetds-devel \
libuuid-devel pam-devel libgcrypt sed coreutils patch nasm ccache

exit 0;