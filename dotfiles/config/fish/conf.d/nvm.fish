# conf.d/nvm.fish
# mirrors: dotfiles/zsh.conf.d/nvm
# nvm.sh is bash-only, so wrap it with bass when available
# ($NVM_DIR is exported in conf.d/exports.fish)

if command -q bass; and test -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
    function nvm --description "Node Version Manager (via bass)"
        bass source "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" --no-use ';' nvm $argv
    end
end
