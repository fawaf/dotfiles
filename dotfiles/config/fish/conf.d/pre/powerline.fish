# conf.d/pre/powerline.fish
# mirrors: dotfiles/zsh.pre.d/00-powerline

if set -q TMUX; and command -q powerline-config
    powerline-config tmux setup
end
