# conf.d/term_type.fish
# mirrors: dotfiles/zsh.conf.d/term_type
# If ncurses is installed, use tput to gracefully degrade termtypes.

if status is-interactive
    settermtype
end
