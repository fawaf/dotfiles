# conf.d/helmfile.fish
# mirrors: dotfiles/zsh.conf.d/helmfile

if status is-interactive; and command -q helmfile
    helmfile completion fish 2>/dev/null | source
end
