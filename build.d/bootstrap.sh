# -*-Shell-script-*-
# shell scripts: nawawi@rutweb.com

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

_ARCH="$(uname -m)";
_PERLV="";
if [[ "$(perl --version)" =~ v([0-9.]+) ]]; then
    if (( ${#BASH_REMATCH[@]} > 0 )); then
        _PERLV="${BASH_REMATCH[1]}";
    fi
fi

_GCCV="";
regex="gcc\s+\([ a-zA-Z0-9./-]+\)\s+([0-9.]+)";
if [[ "$(gcc --version)" =~ $regex ]]; then
    if (( ${#BASH_REMATCH[@]} > 0 )); then
        _GCCV="${BASH_REMATCH[1]}";
    fi
fi

_B64=0;
[[ ${_ARCH} =~ 64$ ]] && B64=1;

export _ARCH _PERLV _GCCV _B64;
export _BOOTSTRAP=1;

# -- functions --

# C strstr
strstr() {
  [ "${1#*$2*}" = "$1" ] && return 1
  return 0
}

# remove leading/trailing whitespace
trim() {
    local str="$@";
    str="${str#"${str%%[![:space:]]*}"}";
    str="${str%"${str##*[![:space:]]}"}";
    echo -n "${str}";
}

_cat() {
    local INPUTS=( "${@:-"-"}" )
    for i in "${INPUTS[@]}"; do
        # quick hack to get /proc/*/cmdline content that end by null character
        if [[ "${i}" =~ ^(/proc/[0-9]+/.*) ]] && [ -f "${i}" ]; then
            echo $(< $i );
            break;
        fi
        if [[ "${i}" != "-" ]]; then
            exec 3< "${i}" || return 1;
        else
            exec 3<&0
        fi
        while read -ru 3; do
            echo -E "${REPLY}";
        done
    done
    return 0;
}

# read file and remove leading #
_gfile() {
    [ $# -lt 1 ] && return 1;
    local f="$1";
    if [ -f $f ]; then
        exec 3< $f;
        while read -ru 3; do
           [ -z "${REPLY}" ] && continue;
           [[ "${REPLY}" =~ ^# ]] && continue;
            echo -E "${REPLY}";
        done;
    fi
}

