# conf.d/rvm.fish
# mirrors: dotfiles/zsh.conf.d/rvm
# rvm is bash-only, so wrap it with bass when available

if command -q bass; and test -s "$HOME/.rvm/scripts/rvm"
    function rvm --description "Ruby Version Manager (via bass)"
        bass source "$HOME/.rvm/scripts/rvm" ';' rvm $argv
    end
end
