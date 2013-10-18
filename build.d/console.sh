#!/bin/bash
# cenbia startup script: nawawi@rutweb.com

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

_RUN_SHELL() {
    export HOME=$ROOT_PATH;
    export PS1="cenbia \W> ";
    cd $ROOT_PATH;
    if [ $# -gt 1 ]; then
        local cmd=${@#shell};
        $cmd;
        exit $?;
    fi
cat << _END_

Available command:
httpd-control           - control script for http daemon
mysqld-control          - control script for mariadb daemon
php-fpm-control         - control script for php-fpm daemon
httpd-selfsign-cert     - generate sel-sign https certificate
cenbia-start            - start service
cenbia-stop             - stop service
cenbia-restart          - restart service

_END_
    exec /bin/bash --norc --noprofile --login
}

_START() {
    if [ $# -eq 1 -o "$2" = "all" ]; then
        mysqld-control start;
        php-fpm-control start;
        httpd-control start;
    else
        for x in $@; do
            if [ $x = "mysqld" -o "$x" = "mariadb" -o "$x" = "mysql" ]; then
                mysqld-control start;
            elif [ $x = "php-fpm" ]; then
                php-fpm-control start;
            elif [ $x = "httpd" -o "$x" = "http" ]; then
                httpd-control start;
            fi
        done
    fi    
}

_STOP() {
    if [ $# -eq 1 -o "$2" = "all" ]; then
        httpd-control stop;
        php-fpm-control stop;
        mysqld-control stop;
    else
        for x in $@; do
            if [ $x = "mysqld" -o "$x" = "mariadb" -o "$x" = "mysql" ]; then
                mysqld-control stop;
            elif [ $x = "php-fpm" ]; then
                php-fpm-control stop;
            elif [ $x = "httpd" -o "$x" = "http" ]; then
                httpd-control stop;
            fi
        done
    fi
}

_RESTART() {
    _STOP $@;
    _START $@;
}

_HELP() {
cat << _END_

Usage: $0 [start|stop|restart] [all|httpd|mysqld|php-fpm]
       $0 shell [command]

$0 start    - start all service
$0 stop     - stop all service
$0 restart  - restart all service
$0 shell    - execute cenbia cli

_END_
}

case $1 in
    start)
        _START $@
    ;;
    stop)
        _STOP $@
    ;;
    restart)
        _RESTART $@
    ;;
    shell)
        _RUN_SHELL $@
    ;;
    *)
    _HELP;
    exit 1;
esac    

