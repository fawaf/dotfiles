# conf.d/os/darwin/rc.fish
# mirrors: dotfiles/zsh.darwin.d/zshrc

if command -q zoxide
    zoxide import autojump --merge 2>/dev/null
end
