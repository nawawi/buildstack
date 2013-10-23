#!/bin/bash
# centos package
yum -y install \
coreutils bash gcc gcc-c++ glibc-devel libstdc++-devel cmake make autoconf automake libtool bison libgcc \
readline-devel gnutls-devel \
libuuid-devel pam-devel libgcrypt sed coreutils patch nasm ccache \
libcom_err-devel cyrus-sasl-devel libss-devel
exit 0;
