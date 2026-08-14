# conf.d/atuin.fish
# mirrors: dotfiles/zsh.conf.d/atuin

if status is-interactive; and command -q atuin
    atuin init fish | source
end
