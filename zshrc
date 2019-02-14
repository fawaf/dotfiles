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

# set term type {{{
# If ncurses is installed, use tput to gracefully degrade termtypes.
settermtype
stty ixoff -ixon
# }}}

# chmods {{{
if [ -f $HOME/.fetchmailrc ]
then
    chmod 600 $HOME/.fetchmailrc
fi
if [ -f $HOME/.muttrc ]
then
    chmod 640 $HOME/.muttrc
fi
# }}}

# Options {{{
unsetopt HIST_BEEP

setopt EXTENDED_GLOB
setopt PROMPT_SUBST         # Required for the prompt
setopt SHARE_HISTORY        # Share history between multiple instances of zsh
setopt EXTENDED_HISTORY     # Put beginning and ending timestamps in the history file
setopt INC_APPEND_HISTORY   # save every command before it is executed
setopt HIST_VERIFY          # perform history substitution and reload the line into the editing buffer
setopt HIST_IGNORE_DUPS     # Sequential duplicate commands only get one history entry
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS    # Don't show duplicate commands when searching the history
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt MAGIC_EQUAL_SUBST    # Do completion on <value> in foo=<value>
setopt NONOMATCH            # Don't error if globbing fails; just leave the globbing chars in
setopt AUTO_LIST            # Show possible matches if completion can't figure out what to do
setopt AUTO_RESUME          # Commands without arguments will first try to resume suspended programs of the same name
setopt AUTO_CD              # Skip `cd' when changing to a directory
setopt NO_BEEP              # "I refer to this informally as the OPEN_PLAN_OFFICE_NO_VIGILANTE_ATTACKS option."
setopt AUTO_PUSHD           # cd uses directory stack
setopt PUSHD_SILENT         # make pushd quiet
setopt PUSHD_TO_HOME        # Have pushd with no arguments act like 'pushd $HOME'
setopt PUSHD_IGNORE_DUPS    # Don't push multiple copies of the same directory onto the directory stack
setopt INTERACTIVE_COMMENTS # allow comments in interactive shells
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

# Bindings {{{
bindkey -v                  # vi keybindings
bindkey ' ' magic-space     # Do history expansion on space
bindkey '^_' undo           # Ctrl-/ usually inserts Ctrl-_
bindkey '^r' history-incremental-search-backward
## start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search
  bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search
  bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi
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

export PR_NO_COLOR="%{$reset_color%}"
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

# Prompt {{{
set_prompt() {
    set_host_variables
    export PS2="$PR_WHITE%#$PR_NO_COLOR($PR_LIGHT_GREEN%_$PR_NO_COLOR) "
    export RPS1BEGIN="%(?..$PR_RED [%?]$PR_NO_COLOR)%(1j.$PR_CYAN [%j]$PR_NO_COLOR.)"
    export RPS1END="$PR_LIGHT_CYAN%D{%Y-%m-%d} (%D{%Y.%V}) %D{%H:%M:%S}$PR_NO_COLOR"
    export PS1BEGIN="%(!.$PR_BG_RED$PR_YELLOW%n$PR_NO_COLOR$PR_WHITE.$PR_GREEN%n$PR_NO_COLOR)@$PR_BLUE$REALHOST"
    export PS1END="$PR_NO_COLOR:$PR_RED%~$PR_NO_COLOR${vcs_info_msg_0_}$PR_NO_COLOR
$PR_MAGENTA%#$PR_NO_COLOR "

    if [ -f $HOME/.zsh-prompt ]
    then
        source $HOME/.zsh-prompt
    else
        if [ x"$INTERNALHOST" == x"" ] || [ x"$EXTERNALHOST" == x"" ] || [ x"$INTERNALHOST" == x"$EXTERNALHOST" ]
        then
            export PS1="$PS1BEGIN$PS1END"
        else
            export PS1="$PS1BEGIN/$INTERNALHOST$PS1END"
        fi
        export RPS1="$RPS1BEGIN$RPS1END"

        export PROMPT="$PS1"
        export RPROMPT="$RPS1"
    fi
}
# }}}

# Set variables {{{
#set_host_variables
# use current user@host as the prefix of the current tab title
export TAB_TITLE_PREFIX="${USER}@${REALHOST}:"
# when at the shell prompt, show a truncated version of the current path (with
# standard ~ replacement) as the rest of the title.
export TAB_TITLE_PROMPT='`print -Pn "%~" | sed "s:\([~/][^/]*\)/.*/:\1...:"`'
# when running a command, show the title of the command as the rest of the
# title (truncate to drop the path to the command)
export TAB_TITLE_EXEC='`case $cmd[1]:t in ; "sudo") echo $cmd[2]:t;; *) echo $cmd[1]:t;; esac`'

# use the current path (with standard ~ replacement) in square brackets as the
# prefix of the tab window hardstatus.
export TAB_HARDSTATUS_PREFIX='`print -Pn "[%~] "`'
# when at the shell prompt, use the shell name (truncated to remove the path to
# the shell) as the rest of the title
export TAB_HARDSTATUS_PROMPT='$SHELL:t'
# when running a command, show the command name and arguments as the rest of
# the title
export TAB_HARDSTATUS_EXEC='$cmd'
# }}}

# mmv {{{
autoload -U zmv
alias mmv='noglob zmv -W'
# }}}

# preexec() and precmd() {{{
# Called by zsh before executing a command:
function preexec() {
    local -a cmd; cmd=(${(z)1})        # the command string
    tab_title="$TAB_TITLE_PREFIX$TAB_TITLE_EXEC"
    tab_hardstatus="$TAB_HARDSTATUS_PREFIX$TAB_HARDSTATUS_EXEC"
    set_titlebar $tab_title $tab_hardstatus
}

function rp() {
    if [[ -z "$RP" ]]
    then
      RP=1
    else
      unset RP
    fi
    clear
}

# Called by zsh before showing the prompt:
function precmd() {
#    tab_title="$TAB_TITLE_PREFIX$TAB_TITLE_PROMPT"
#    tab_hardstatus="$TAB_HARDSTATUS_PREFIX$TAB_HARDSTATUS_PROMPT"
#    set_titlebar $tab_title $tab_hardstatus
    vcs_info
    if [[ -z "$RP" ]]
    then
      set_prompt
    else
      PS1="%n@$(hostname -s):%~%# "
      RPS1=""
    fi
}
# }}}

# Environment {{{
autoload -Uz compinit
compinit -d $HOME/.zsh/zcompdump.$HOSTNAME
#umask 077   # Deny group/world rwx by default (multiuser systems)
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

export DIRSTACKSIZE=2000  # maximum size of directory stack
export HISTSIZE=5000      # Maximum size of history list
export SAVEHIST=2500      # Save the last x commands
export LISTMAX=0          # Only ask if completion listing would scroll off screen
export REPORTTIME=60      # Give timing statistics for programs that take longer than a minute to run
export HISTFILE="$HOME/.zhistory_$HOSTNAME"
unset LS_COLORS
# }}}

# Sources {{{
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if [ -f $HOME/.zshrc-custom ]
then
    source $HOME/.zshrc-custom
fi

if [ -f $HOME/.aliases-custom ]
then
    source $HOME/.aliases-custom
fi
# }}}

cd ~
