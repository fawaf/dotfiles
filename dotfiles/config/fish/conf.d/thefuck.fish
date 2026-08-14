# conf.d/thefuck.fish
# mirrors: dotfiles/zsh.conf.d/thefuck

if status is-interactive; and command -q thefuck
    thefuck --alias | source
end
