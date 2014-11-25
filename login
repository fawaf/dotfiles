#!/bin/sh

export LANG="en_US.UTF-8"

if [ "`ps aux | \grep ssh-agent | \grep -v \grep | wc -l`" -eq 0 ]
then
    eval `ssh-agent`
    if [ -e ~/.ssh/id_rsa ]
    then
        ssh-add
    fi
    export KILL_SSH_AGENT_ON_LOGOUT="true"
fi

rm -f ~/Downloads/*.part
rm -f ~/Desktop/*.part

if [ -f /etc/motd ]
then
    uname -a | diff -q - <(cat /etc/motd | \grep $(uname -r))
fi
uptime

if [ -e /usr/bin/klist ]
then
    klist
fi

unset LS_COLORS

#if which xrdb > /dev/null; then
#	xrdb -merge ~/.Xresources
#fi
#if which xmodmap > /dev/null; then
#	if [ `xmodmap -pke | \grep Caps | wc -l` -eq 1 ]; then
#		command xmodmap .xmodmap
#	fi
#fi
#if which pcmanfm > /dev/null; then
#	pcmanfm --set-wallpaper ~/stuff/angel_beats-038.png --wallpaper-mode=stretch
#fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

if [ -f ~/.login-custom ]
then
    source ~/.login-custom
fi
