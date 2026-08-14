# conf.d/stty.fish
# mirrors: dotfiles/zsh.conf.d/stty + stty line of term_type

if status is-interactive
    stty sane 2>/dev/null
    stty ixoff -ixon 2>/dev/null
end
