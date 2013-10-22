_ARCH="$(uname -m)";
_PERLV="$(perl --version |egrep '\(v.*\)' |sed 's/.*(v\(.*\)).*/\1/g')";
_GCCV="$(gcc --version |egrep 'gcc\s(.*)\s' |sed 's/.*)\s\(.*\).*/\1/g')";
_B64=0;
[[ ${_ARCH} =~ 64$ ]] && B64=1;
export _ARCH _PERLV _GCCV _B64;
