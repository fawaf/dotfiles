# conf.d/kubectl.fish
# mirrors: kubectl completion loading in dotfiles/zshrc

if status is-interactive; and command -q kubectl
    kubectl completion fish | source
end
