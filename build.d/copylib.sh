#!/bin/bash

source "./build.d/source-config.sh" &>/dev/null;
[ -z "${INST_DIR}" ] && { echo "Load config failed"; exit 1; };

_DESPATH="${INST_DIR}/lib32";
if [ "$(uname -m | grep -c 64)" = "1" ]; then
    _DESPATH="${INST_DIR}/lib64";
fi

# copy ld-linux* libc etc..etc..
_noskip=0;

_error() {
	local msg=$@;
	echo "[ERROR] $msg";
	exit 1;
}

_exec_echo() {
	local msg=$1;
	echo ">> $msg";
	$msg;	
}

_copy_file() {
	local _SRC="$1" _DST="$2" _DSRC _BSRC _LSRC="";

    if [ $# != 2 ]; then
        _error "${FUNCNAME}: invalid options";
    fi

	if [ ! -e "$_SRC" ]; then
        [ "$_SRC" = "dynamic" -o "$_SRC" = "not" ] && return 1;
		echo "[ERROR] ${FUNCNAME}: file '${_SRC}' not found";
        return 1;
	fi

	_BSRC="$(basename ${_SRC})";

	if [ -e "${_DST}/${_BSRC}" ]; then
		echo "[*] ${FUNCNAME}: File exists! ${_DST}/${_BSRC}";
		return 1;
	fi

	echo "[*] ${FUNCNAME} ${_SRC} ${_DST}";

	if [ -L "${_SRC}" ]; then
		_exec_echo "cp -fa ${_SRC} ${_DST}";
		_LSRC="${_SRC}";
		_DSRC="$(dirname ${_SRC})";
		while [ -L "${_LSRC}" ]; do
			_LSRC="$(readlink ${_LSRC})";
			# check if not in fullpatch
			if [ ! -e "${_LSRC}" ] && [ -e "${_DSRC}/${_LSRC}" ]; then
				_LSRC="${_DSRC}/${_LSRC}";
			fi
			_exec_echo "cp -fa ${_LSRC} ${_DST}";
			 # strip if not symlink
			_BSRC="$(basename ${_LSRC})";
			if [ ! -L "${_DST}/${_BSRC}" ]; then
				_exec_echo "strip --strip-debug --strip-unneeded ${_DST}/${_BSRC}";
			fi
			unset _BSRC;
		done
	else
		_exec_echo "cp -fa ${_SRC} ${_DST}";
		_exec_echo "strip --strip-debug --strip-unneeded ${_DST}/${_BSRC}";		
	fi
}

_copy_lib() {
    if [ $# != 2 ]; then
        _error "${FUNCNAME}: invalid options";
    fi

    local _SRC="$1" _DST="$2" _BSRC _DSRC _LSRC="";
	local _LO _P;
    echo "[*] ${FUNCNAME}: checking -> ${_SRC}";
	if [ ! -e "${_SRC}" ]; then
		_error "${FUNCNAME}: file '${_SRC}' not found";
	fi
	
	# check in destination
	_BSRC="$(basename ${_SRC})";

	if [ -e "${_DST}/${_BSRC}" ]; then
		echo "[*] ${FUNCNAME}: Skip! ${_DST}/${_BSRC}";
		return 1;
	fi

	[ ! -d "${_DST}" ] && _exec_echo "mkdir -p ${_DST}";
	local _LO="$(_P=$(ldd ${_SRC});echo "${_P}" |tr -d '^\t' |sed -e 's/=>//g' |cut -d ' ' -f 3; echo "${_P}" |tr -d '^\t' |grep -v "=>" |cut -d ' ' -f 1)";
	if [ -n "${_LO:-}" ]; then
		unset _P;
		for _P in ${_LO}; do
            if [[ $_P =~ $INST_DIR* ]]; then
                echo "[*] ${FUNCNAME}: Skip! ${_P}";
                continue;
            fi

			if [ "${_noskip}" == "0" ]; then
                # glibc
			    [[ $(basename $_P) =~ libdl-* ]] && continue;            
			    [[ $(basename $_P) =~ libaudit* ]] && continue;            
			    [[ $(basename $_P) =~ libpthread-* ]] && continue;
			    [[ $(basename $_P) =~ libresolv-* ]] && continue;
			    [[ $(basename $_P) =~ librt-* ]] && continue;
			    [[ $(basename $_P) =~ libm-* ]] && continue;
  				[[ $(basename $_P) =~ ld-* ]] && continue;
				[[ $(basename $_P) =~ libc-* ]] && continue;

                # libselinux
				[[ $(basename $_P) =~ libselinux-* ]] && continue;
			fi
			_copy_file "${_P}" "${_DST}";
		done
	fi
}

if [ -d "${INST_DIR}/lib" ]; then
    for f in $(find $INST_DIR/lib/ -name "*.so") $INST_DIR/bin/*; do
        _copy_lib $f $_DESPATH;
    done
fi
exit 0;
