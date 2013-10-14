#!/bin/bash
source @INST_DIR/etc/cenbia-environment &>/dev/null || { echo "Failed to load library"; exit 1; };
cert_config="@INST_DIR/etc/httpd/cert_config";
server_key="@INST_DIR/etc/httpd/ssl.key/server.key";
server_crt="@INST_DIR/etc/httpd/ssl.crt/server.crt";

if [ -n "$1" -a "$1" != "." -a "$1" != "/" -a ! -d "$1" ]; then
    server_key="@INST_DIR/etc/httpd/ssl.key/$1.key";
    server_crt="@INST_DIR/etc/httpd/ssl.crt/$1.crt";
fi

if [ -f "${cert_config}" ]; then
    @INST_DIR/bin/openssl req -x509 -newkey rsa:1024 -keyout $server_key -out $server_crt -days 9999 -nodes -config $cert_config;
    [ -f $server_key ] && chmod 600 $server_key;
    [ -f $server_crt ] && chmod 600 $server_crt;
fi
exit 0;
