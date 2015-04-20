#!/bin/bash

set -e

BEGIN_MARKER="### BEGIN SearchOne SETTINGS ###"
END_MARKER="### END SearchOne SETTINGS ###"

clean_sty() {
    # Delete sty settings
    target_file="$1"
    sed -i /"$BEGIN_MARKER"/,/"$END_MARKER"/d "$target_file"
}

print_sty() {
    content="$1"
    echo
    echo "$BEGIN_MARKER"
    echo "$content"
    echo "$END_MARKER"
}


