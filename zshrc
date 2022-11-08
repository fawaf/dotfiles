# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

# rc -- zsh
# vim:fdm=marker
# useful links: {{{
#  - http://gentoo-wiki.com/Talk:Screen
#  - http://www.gentoo.org/doc/en/zsh.xml
#  - http://aperiodic.net/phil/prompt/
#  - http://www.cs.elte.hu/zsh-manual/zsh_15.html
#  - http://www.cs.elte.hu/zsh-manual/zsh_16.html
#  - http://grml.org/zsh/zsh-lovers.html
#  - http://wiki.archlinux.org/index.php/Zsh
#  - http://zshwiki.org/home/examples/compquickstart
# }}}

autoload -Uz compinit
compinit -d $HOME/.zsh/zcompdump.$HOSTNAME

if [ -f $HOME/.zshrc-pre ]
then
    source $HOME/.zshrc-pre
fi

for file in $HOME/.zsh.d/*
do
  test -r "$file" && source "$file"
done

# chmods {{{
if [ -f $HOME/.fetchmailrc ]
then
    chmod 600 $HOME/.fetchmailrc
fi
if [ -f $HOME/.muttrc ]
then
    chronic chmod 640 $HOME/.muttrc
fi
# }}}

# Options {{{
unsetopt HIST_BEEP

setopt AUTO_CD              # Skip `cd' when changing to a directory
setopt AUTO_LIST            # Show possible matches if completion can't figure out what to do
setopt AUTO_PUSHD           # cd uses directory stack
setopt AUTO_RESUME          # Commands without arguments will first try to resume suspended programs of the same name
setopt EXTENDED_GLOB
setopt EXTENDED_HISTORY     # Put beginning and ending timestamps in the history file
setopt HIST_FIND_NO_DUPS    # Don't show duplicate commands when searching the history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS     # Sequential duplicate commands only get one history entry
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY          # perform history substitution and reload the line into the editing buffer
setopt INC_APPEND_HISTORY   # save every command before it is executed
setopt INTERACTIVE_COMMENTS # allow comments in interactive shells
setopt MAGIC_EQUAL_SUBST    # Do completion on <value> in foo=<value>
setopt NO_BEEP              # "I refer to this informally as the OPEN_PLAN_OFFICE_NO_VIGILANTE_ATTACKS option."
setopt NONOMATCH            # Don't error if globbing fails; just leave the globbing chars in
setopt PROMPT_SUBST         # Required for the prompt
setopt PUSHD_IGNORE_DUPS    # Don't push multiple copies of the same directory onto the directory stack
setopt PUSHD_SILENT         # make pushd quiet
setopt PUSHD_TO_HOME        # Have pushd with no arguments act like 'pushd $HOME'
setopt SHARE_HISTORY        # Share history between multiple instances of zsh
# }}}

# compinit/tab-completion {{{
zstyle :compinstall filename "/home/waf/.zshrc"
zmodload zsh/complist
zstyle ':completion:::::' completer _complete _approximate
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'
zstyle ':completion:*:descriptions' format "- %d -"
zstyle ':completion:*:corrections' format "- %d - (errors %e)"
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o user,pid,command'
zstyle ':completion:*' use-cache on
# case insensitivity, partial matching, substitution
zstyle ':completion:*' matcher-list 'm:{A-Z}={a-z}' 'm:{a-z}={A-Z}' 'r:|[-._]=* r:|=*' 'l:|=* r:|=*' '+l:|=*'
# }}}

# menu-select settings {{{
bindkey '^d' menu-select    # Use ^D for more useful tab completion
bindkey -M menuselect '^o' accept-and-infer-next-history
bindkey -M menuselect h backward-char
bindkey -M menuselect j down-line-or-history
bindkey -M menuselect k up-line-or-history
bindkey -M menuselect l forward-char
# }}}

# Font colors {{{
# colors adapted from Phil!'s Zsh prompt
autoload -U colors zsh/terminfo
if [ "$terminfo[colors]" -ge 8 ]
then
    colors
fi

for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE BLACK PURPLE PINK ORANGE
do
    eval PR_$color='%{$bold_color$fg[${(L)color}]%}'
    eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
    eval PR_BG_$color='%{$bold_color$bg[${(L)color}]%}'
    (( count = $count + 1 ))
done

PR_NO_COLOR="%{$reset_color%}"
export PR_NO_COLOR
# }}}

# VCS {{{
# Set up vcs_info.
autoload -Uz vcs_info
zstyle ':vcs_info:*' disable bzr cdv darcs mtn svk tla
zstyle ':vcs_info:*' enable git svn hg
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats " using $PR_BLUE%s$PR_NO_COLOR on $PR_GREEN%b$PR_NO_COLOR branch in working directory $PR_MAGENTA%S$PR_NO_COLOR with status $PR_RED%m%u%c$PR_NO_COLOR"
zstyle ':vcs_info:*' actionformats " on $PR_GREEN%b on:%a"
zstyle ':vcs_info:hg*:*' hgrevformat "$PR_GREEN%r" # only show local revision
zstyle ':vcs_info:hg*:*' branchformat "$PR_GREEN%b" # only show branch
#zstyle ':vcs_info:git*:*' actionformats " on ±$PR_GREEN%b|%a"
#zstyle ':vcs_info:git*:*' formats " on ±$PR_GREEN%b"
# }}}

# Set variables {{{
# use current user@host as the prefix of the current tab title
TAB_TITLE_PREFIX="${USER}@${REALHOST}:"
export TAB_TITLE_PREFIX
# when at the shell prompt, show a truncated version of the current path (with
# standard ~ replacement) as the rest of the title.
TAB_TITLE_PROMPT='`print -Pn "%~" | sed "s:\([~/][^/]*\)/.*/:\1...:"`'
export TAB_TITLE_PROMPT
# when running a command, show the title of the command as the rest of the
# title (truncate to drop the path to the command)
TAB_TITLE_EXEC='`case $cmd[1]:t in ; "sudo") echo $cmd[2]:t;; *) echo $cmd[1]:t;; esac`'
export TAB_TITLE_EXEC

# use the current path (with standard ~ replacement) in square brackets as the
# prefix of the tab window hardstatus.
TAB_HARDSTATUS_PREFIX='`print -Pn "[%~] "`'
export TAB_HARDSTATUS_PREFIX
# when at the shell prompt, use the shell name (truncated to remove the path to
# the shell) as the rest of the title
TAB_HARDSTATUS_PROMPT='$SHELL:t'
export TAB_HARDSTATUS_PROMPT
# when running a command, show the command name and arguments as the rest of
# the title
TAB_HARDSTATUS_EXEC='$cmd'
export TAB_HARDSTATUS_EXEC
# }}}

# mmv {{{
autoload -U zmv
alias mmv='noglob zmv -W'
# }}}

# Environment {{{
umask 022   # Deny group/world rwx by default (multiuser systems)
# }}}

# Miscellaneous {{{
type mesg > /dev/null
if [ $? -eq 0 ]
then
    mesg n
fi

rationalise-dot() {
    if [[ "$LBUFFER" == *.. ]]
    then
        LBUFFER+=/..
    else
        LBUFFER+=.
    fi
}
zle -N rationalise-dot
bindkey . rationalise-dot

DIRSTACKSIZE=2000 # maximum size of directory stack
export DIRSTACKSIZE
HISTSIZE=5000     # Maximum size of history list
export HISTSIZE
SAVEHIST=7000     # Save the last x commands
export SAVEHIST
LISTMAX=0         # Only ask if completion listing would scroll off screen
export LISTMAX
REPORTTIME=60     # Give timing statistics for programs that take longer than a minute to run
export REPORTTIME
HISTFILE="$HOME/.zhistory_$HOSTNAME"
export HISTFILE
unset LS_COLORS
# }}}

source $HOME/.zsh/k/k.sh

autoload zcalc

# Sources {{{
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /usr/local/bin/aws_zsh_completer.sh ] && source /usr/local/bin/aws_zsh_completer.sh

source_os_dotfiles zshrc

if [ -f $HOME/.zshrc-post ]
then
    source $HOME/.zshrc-post
fi
# }}}

if [[ -z "$HOST_IP" ]]
then
    echo_color red "No IP address(es) detected"
fi

cd ~

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

test $commands[kubectl] && source <(kubectl completion zsh)

# fig {{{
# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
# }}}
