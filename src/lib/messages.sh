_die() {
    local scrname=$(basename "$0")
    echo "$scrname: $1" >&2
    exit 1
}
#--------------#

_msg() {
    local scrname=$(basename "$0")
    echo "$scrname: $1" >&2
}

