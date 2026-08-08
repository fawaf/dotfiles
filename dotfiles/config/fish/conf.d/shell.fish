# conf.d/shell.fish
# mirrors: dotfiles/zsh.conf.d/shell
# Sets tab title / hardstatus variables and history settings

# Tab title prefix
set -gx TAB_TITLE_PREFIX "$USER@$REALHOST:"
set -gx TAB_HARDSTATUS_PREFIX ''

# History settings (fish manages its own history; these mirror the intent)
# fish uses $fish_history to set the history file
# HISTSIZE analog: fish keeps all history by default
# Mirror REPORTTIME (commands taking > N seconds are timed) -- fish doesn't have a built-in,
# but we export so any scripts can use it
set -gx REPORTTIME 60
set -gx DIRSTACKSIZE 2000
set -gx HISTSIZE 5000
set -gx SAVEHIST 7000
