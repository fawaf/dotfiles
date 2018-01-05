#!/bin/sh

export LANG="en_US.UTF-8"


rm -f $HOME/Downloads/*.part
rm -f $HOME/Desktop/*.part

# {{{ sanity checks
if [ -f /etc/motd ]
then
    uname -a | diff -q - <(cat /etc/motd | \grep "`uname -a`")
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

#if which xrdb > /dev/null; then
#	xrdb -merge $HOME/.Xresources
#fi
#if which xmodmap > /dev/null; then
#	if [ `xmodmap -pke | \grep Caps | wc -l` -eq 1 ]; then
#		command xmodmap .xmodmap
#	fi
#fi
#if which pcmanfm > /dev/null; then
#	pcmanfm --set-wallpaper $HOME/stuff/angel_beats-038.png --wallpaper-mode=stretch
#fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# custom login {{{
if [ -f $HOME/.login-custom ]
then
    source $HOME/.login-custom
fi
# }}}

# ssh agent {{{
ENABLE_SSH_AGENT="false"

if [ "x$ENABLE_SSH_AGENT" == "xtrue" ]
then
    if [ "`ps aux | \grep ssh-agent | \grep -v \grep | wc -l`" -eq 0 ]
    then
        eval `ssh-agent`
        if [ -e $HOME/.ssh/id_rsa ]
        then
            ssh-add
        fi
        export KILL_SSH_AGENT_ON_LOGOUT="true"
    fi
fi
# }}}
