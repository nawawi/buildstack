# -*-Shell-script-*-
# shell scripts: nawawi@rutweb.com

# C strstr
strstr() {
  [ "${1#*$2*}" = "$1" ] && return 1
  return 0
}

# remove leading/trailing whitespace
_trim() {
    local str="$@";
    str="${str#"${str%%[![:space:]]*}"}";
    str="${str%"${str##*[![:space:]]}"}";
    echo -n "${str}";
}

