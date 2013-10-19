#!/bin/bash
me="$(basename $0)";
cmd="";
case $me in
    *-start) cmd="start";;
    *-stop) cmd="stop";;
    *-restart) cmd="restart";;
esac
exec @ROOT_DIR/cenbia $cmd $@
