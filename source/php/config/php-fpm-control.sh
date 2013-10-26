#!/bin/bash
source @ROOT_DIR/scripts/bootstrap.sh &>/dev/null || { echo "Bootstrap failed"; exit 1; };

phpfpm="@INST_DIR/bin/php-fpm";
pidfile="@ROOT_DIR/data/run/php-fpm/php-fpm.pid";
prog="php-fpm";
RETVAL=0

STARTTIMEOUT=120
STOPTIMEOUT=60

start() {
    _msg "Starting $prog.";
    $phpfpm --pid $pidfile --daemonize &>/dev/null;
    RETVAL="$?";
    if [ $RETVAL = 0 ]; then
        _success;
    else
        _failure;
    fi
    return $RETVAL;
}

stop() {
	if [ ! -f "$pidfile" ]; then
	    _msg "Stopping $prog" && _success;
	    return 0;
	fi
    _msg "Stopping $prog";
    PHPFPMPID="$(< $pidfile)";
	if [ -n "$PHPFPMPID" ]; then
	    kill "$PHPFPMPID" >/dev/null 2>&1
	    ret=$?;
	    if [ $ret -eq 0 ]; then
            TIMEOUT="$STOPTIMEOUT";
            while [ $TIMEOUT -gt 0 ]; do
                kill -0 "$PHPFPMPID" >/dev/null 2>&1 || break
                _printdot;
                sleep 1;
                let TIMEOUT=${TIMEOUT}-1;
            done
            if [ $TIMEOUT -eq 0 ]; then
                echo "Timeout error occurred trying to stop php-fpm Daemon."
                ret=1
                _failure;
            else
                rm -f $pidfile;
                _success;
            fi
        else
            _failure;
        fi
    else
	    _failure;
        rm -f $pidfile;
	    ret=4;
    fi
	return $ret;
}

reload() {
    _msg "Reloading $prog";
    if [ -f "$pidfile" ]; then
        PHPFPMPID="$(< $pidfile)";
        if kill -USR2 $PHPFPMPID 2>/dev/null ; then 
            _success;
            exit 0;
        else
            _failure;
            exit 1;
        fi
    fi
    PHPFPMPID="$(pidof $phpfpm)";
    if [ -n "${PHPFPMPID}" ]; then
        if kill -USR2 $PHPFPMPID 2>/dev/null ; then 
            _success;
            exit 0;
        fi
    fi
    _failure;
    exit 1;
}

status() {
    if [ -f "$pidfile" ]; then
        PHPFPMPID="$(< $pidfile)";
        if kill -0 $PHPFPMPID 2>/dev/null ; then 
            echo "php-fpm running ($PHPFPMPID)";
            exit 0;
        else
            echo "php-fpm is not running";
            rm -f $pidfile;
            exit 1;
        fi
    fi
    PHPFPMPID="$(pidof $phpfpm)";
    if [ -n "${PHPFPMPID}" ]; then
        echo "php-fpmD running ($PHPFPMPID)";
        exit 0;
    fi
    echo "php-fpm is not running";
    exit 1;
}

restart() {
    stop;
    start;
}

case "$1" in
    start)
        start
    ;;
    stop)
        stop
    ;;
    status)
        status
	;;
    restart)
        restart
	;;
    reload)
        reload
	;;
    configtest)
        $phpfpm -t
    ;;
    *)
        echo "Usage: $prog {start|stop|restart|reload|status}"
        exit 1;
esac

exit $?;
