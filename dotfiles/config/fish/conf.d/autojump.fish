# conf.d/autojump.fish
# mirrors: dotfiles/zsh.conf.d/autojump

if status is-interactive
    set -l autojump_fish "$HOMEBREW_PREFIX/share/autojump/autojump.fish"
    if test -f $autojump_fish
        source $autojump_fish
    end
end
