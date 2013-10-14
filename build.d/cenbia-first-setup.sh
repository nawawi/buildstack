#!/bin/bash
# cenbia setup script: nawawi@rutweb.com

# check if bash
if [ "x${BASH_VERSION}" = "x" ]; then
    echo "This software require bash version 3 and above";
    exit 1;
else
    if [ -n "${BASH_VERSINFO[0]}" ] && [ ${BASH_VERSINFO[0]} -lt 3 ]; then
        echo "This software require bash version 3 and above";
        exit 1;
    fi
fi

ROOT_PATH="@ROOT_DIR";
INST_PATH="@INST_DIR";
if [ -f "${INST_PATH}/etc/cenbia-environment" ]; then
    source $INST_PATH/etc/cenbia-environment;
fi
if [ -n "${UID}" -a "${UID}" != "0" ]; then
    echo "You need to run this program as root";
    exit;
fi

if ! grep -q nobody /etc/groups &>/dev/null; then
    groupadd nobody &>/dev/null;    
fi

chown -R nobody:nobody $ROOT_PATH/data/mariadb;
chown -R nobody:nobody $ROOT_PATH/data/php-fpm;
chown -R nobody:nobody $ROOT_PATH/data/run/php-fpm;
chown -R nobody:nobody $ROOT_PATH/data/log/php-fpm;
chown -R nobody:nobody $ROOT_PATH/data/run/mysqld;

if [ -f "/etc/hosts" ]; then
    if ! grep -q localhost /etc/hosts &>/dev/null; then
        echo "127.0.0.1 localhost localhost.localdomain" >> /etc/hosts;
    fi
fi

exit 0;