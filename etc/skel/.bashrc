# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific aliases and functions
test -s ~/aliases.sh  && . ~/aliases.sh || true
test -s /etc/sty/aliases.sh  && . /etc/sty/aliases.sh || true
test -s /etc/sty/ps-twtty-7.sh &&  . /etc/sty/ps-twtty-7.sh || true
test -s /etc/sty/showcolors &&  . /etc/sty/showcolors || true

# Allow bash to use <Ctrl>+s and <Ctrl>+q
stty -ixon -ixoff

# Editor for crontab, subversion, etc, etc...
export VISUAL=mcedit
export EDITOR=mcedit
