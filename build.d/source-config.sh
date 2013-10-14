# -*-Shell-script-*-
# shell scripts: nawawi@rutweb.com
#
# This file contains functions to be used by all
# shell scripts in the source directory.

ROOT_DIR="/opt/cenbia";
INST_DIR="${ROOT_DIR}/stack";
[ -n "${_CENBIA_ROOT_PATH}" ] && ROOT_DIR="${_CENBIA_ROOT_PATH}";
[ -n "${_CENBIA_INST_PATH}" ] && INST_DIR="${_CENBIA_INST_PATH}";
export PATH="${INST_DIR}/bin:${PATH}";
export LD_LIBRARY_PATH=${INST_DIR}/lib:$LD_LIBRARY_PATH;
export CFLAGS="-I${INST_DIR}/include";
export CPPFLAGS="-I${INST_DIR}/include";
export LDFLAGS="-L${INST_DIR}/lib";

if [ -z "${_CENBIA_ARCH}" ]; then
    if [ "$(uname -m | grep -c 64)" = "1" ]; then
        _CENBIA_ARCH="64";
    else
        _CENBIA_ARCH="32";
    fi
    export _CENBIA_ARCH;
fi
# rpath
export CENBIA_RPATH="$INST_DIR/lib:$INST_DIR/lib${_CENBIA_ARCH}";
export LDFLAGS="${LDFLAGS} -Wl,-rpath,${CENBIA_RPATH}";

strstr() {
  [ "${1#*$2*}" = "$1" ] && return 1
  return 0
}

_clean_src() {
    local dir="$1";
    if [ -n "${dir}" -a "${dir}" != "/" -a "${dir}" != "." -a -d "${dir}" ]; then
        rm -rf $dir;
    fi
}

_getfile() {
    local url="$1";
    local file="$2";
    if [ -z "${url}" -o -z "${file}" ]; then
        echo "Invalid parameter";
        return 1;
    fi
    if [ ! -f "${file}" ]; then
        wget -S -c --no-check-certificate $url -O ${file}.part;
        ret="$?";
        [ "$ret" = "0" ] && mv ${file}.part $file;
        return $ret;
    fi
    return 1;
}

_extract_file() {
    local file="$1";
    local dlurl="$2";
    local fdl="../../tarball/${file}";
    [ ! -d "./../tarball" ] && mkdir -pv ../../tarball;
    if [ -n "${file}" ]; then
        if [ -f "${fdl}" ]; then
            local ext="${fdl##*.}";
            local opt="";
            [ "${ext}" = "gz" -o "${ext}" = "tgz" ] && opt="-zxf";
            [ "${ext}" = "bz2" -o "${ext}" = "tbz2" ] && opt="-jxf";
            [ -z "${ext}" -o -z "${opt}" ] && { echo "File extension not supported"; exit 1; };
            tar $opt $fdl;
            if [ "$?" -ne "0" ]; then
                echo "Failed to extract file: ${file}";
                exit 1;
            fi
            return 0;
        elif [ -n "${dlurl}" ]; then
            echo "${file} not found, downloading..";
            for url in $dlurl; do
                if strstr "$url" "$file"; then
                    _getfile $url $fdl;
                elif strstr "$url" ".gz"; then
                    _getfile $url $fdl;
                elif strstr "$url" ".bz2"; then
                    _getfile $url $fdl;
                elif strstr "$url" ".tgz"; then
                    _getfile $url $fdl;
                else
                    _getfile $url/$file $fdl;
                fi
                [ "$?" = "0" ] && break;
            done
            _extract_file "${file}";
            return 0;
        fi
    fi
    echo "Failed to extract file";
    exit 1;   
}

_change_dir() {
    local dir="$1";
    if [ -z "${dir}" -o "${dir}" = "/" -o "${dir}" = "." -o ! -d "${dir}" ]; then
        echo "Failed to change directory";
        exit 1;
    fi

    if ! cd ${dir} &>/dev/null; then
        echo "Failed to change directory";
        exit 1;
    fi
}

_exit_when_failed() {
    local task="$1";
    local status="$2";
    if [ "$status" -ne "0" ]; then
        echo "${task}: task failed";
        exit 1;
    fi
}

_exit_and_cleanup() {
    local status="$1";
    local dir="$2";
    if [ "$status" = "0" ]; then
        if [ -n "${dir}" -a "${dir}" != "/" -a "${dir}" != "." -a -d "../${dir}" ]; then
            echo "Done";
            rm -rf ../$dir;
        fi
    else
        echo "Failed";
    fi
    exit $status;
}

_build_setup() {
    echo "Setup.."
    local file="$1";
    local dir="$2";
    local dlurl="$3";
    if [ -z "${file}" -a -z "${dir}" ]; then
        echo "_build_setup(): Invalid parameter";
        exit;
    fi
    _clean_src "${dir}";
    _extract_file "${file}" "${dlurl}";
    _change_dir "${dir}";
}

_apply_patches() {
    echo "Apply patching..";
    [ -f "../patches/dopatch.sh" ] && sh ../patches/dopatch.sh;
}

_require() {
    local bin="$1";
    if ! type -p $bin &>/dev/null; then
        echo "This script require $bin";
        exit 1;
    fi
}

