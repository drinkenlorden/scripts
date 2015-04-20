#!/bin/bash

set -e

dst_file="$HOME/.bashrc"
source sty_functions.sh
touch "$dst_file"
clean_sty "$dst_file"
print_sty "
test -s /etc/sty/aliases.sh  && . /etc/sty/aliases.sh || true
test -s /etc/sty/ps-twtty-7.sh &&  . /etc/sty/ps-twtty-7.sh || true
test -s /etc/sty/showcolors &&  . /etc/sty/showcolors || true

test -s ~/aliases.sh  && . ~/aliases.sh || true


# Allow bash to use <Ctrl>+s and <Ctrl>+q
stty -ixon -ixoff

# Editor for crontab, subversion, etc, etc...
export VISUAL=mcedit
export EDITOR=mcedit

" >> "$dst_file"


