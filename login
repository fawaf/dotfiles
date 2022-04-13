#!/bin/sh

export LANG="en_US.UTF-8"

# {{{ remove part files
rm -f "$HOME"/Downloads/*.part
rm -f "$HOME"/Desktop/*.part
# }}}

# {{{ sanity checks
if [ -f /etc/motd ]
then
    uname -a | diff -q - <(cat /etc/motd | \grep "$(uname -a)")
fi

type uptime > /dev/null
if [ $? -eq 0 ]
then
    uptime
fi

type klist > /dev/null
if [ $? -eq 0 ]
then
    klist
fi
# }}}

unset LS_COLORS

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# custom login {{{
if [ -f "$HOME"/.login-custom ]
then
    source "$HOME"/.login-custom
fi
# }}}
